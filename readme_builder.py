from jinja2 import Environment, FileSystemLoader, ChoiceLoader, select_autoescape
import os
from pathlib import Path

subtemplates = [
  "description",
  "documentation",
  "quick_start",
  "tags"
]

template_paths = []

# Use explicit user setting *or* default repo directory for templates.
# These get called first, allowing repos to override action templates.
TEMPLATE_DIR = os.environ.get("TEMPLATE_DIRECTORY", False)
if TEMPLATE_DIR and len(TEMPLATE_DIR) > 0:
  template_paths.append(FileSystemLoader(TEMPLATE_DIR))
else:
  WORKSPACE_DIR = os.environ.get("GITHUB_WORKSPACE", False)
  if WORKSPACE_DIR:
    workspace_template_path = Path(WORKSPACE_DIR, 'templates')
    if workspace_template_path.exists():
      template_paths.append(FileSystemLoader(str(workspace_template_path)))

# Add the action templates as the final templates to check.
SCRIPT_DIR=os.path.dirname(os.path.realpath(__file__))
template_paths.append(FileSystemLoader(f"{SCRIPT_DIR}/templates/"))

env = Environment(
    loader=ChoiceLoader(template_paths),
    autoescape=select_autoescape()
)

variables = {
  "package": os.environ["PACKAGE"],
  "project_name": os.environ["PROJECT_NAME"],
  "package_versions": os.environ["PACKAGE_VERSIONS"].split(),
  "python_versions": os.environ["PYTHON_VERSIONS"].split(),
  "organization": os.environ["ORGANIZATION"],
  "repository": os.environ["REPOSITORY"]
}

for template_var in subtemplates:
  subtemplate = env.get_template(f"{template_var}.md")
  variables[template_var] = subtemplate.render(**variables)

readme_template = env.get_template("README.md")
print(readme_template.render(**variables))
