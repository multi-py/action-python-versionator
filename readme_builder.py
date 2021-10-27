from jinja2 import Environment, FileSystemLoader, ChoiceLoader, select_autoescape
import yaml
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


def get_key_value(obj, key):
    if hasattr(obj,'iteritems'):
        for k, v in obj.iteritems():
            if k == key:
                return v
            if isinstance(v, dict):
              return get_key_value(v, key)
            elif isinstance(v, list):
                for d in v:
                    return get_key_value(d, key)

platform = "linux/amd64,linux/arm64,linux/arm/v7"
variants = ["full", "slim", "alpine"]
if os.environ.get('BUILDER_WORKFLOW_PATH', False):
  with open(os.environ['BUILDER_WORKFLOW_PATH'], "r") as stream:
      try:
          build_spec = yaml.safe_load(stream)
          platform_guess = get_key_value(build_spec, "platform")
          if platform_guess:
            platform = platform_guess
          strategy = get_key_value(build_spec, "strategy")
          if strategy and 'matrix' in strategy:
            if 'target_base' in strategy['matrix']:
              variants = strategy['matrix']['target_base']
      except yaml.YAMLError as exc:
          print(exc)

variables = {
  "package": os.environ["PACKAGE"],
  "project_name": os.environ["PROJECT_NAME"],
  "package_versions": os.environ["PACKAGE_VERSIONS"].split(),
  "python_versions": os.environ["PYTHON_VERSIONS"].split(),
  "organization": os.environ["ORGANIZATION"],
  "repository": os.environ["REPOSITORY"],
  "platforms": platform.split(','),
  "variants": variants
}

for template_var in subtemplates:
  subtemplate = env.get_template(f"{template_var}.md")
  variables[template_var] = subtemplate.render(**variables)

readme_template = env.get_template("README.md")
print(readme_template.render(**variables))
