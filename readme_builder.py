from jinja2 import Environment, FileSystemLoader, select_autoescape
import os

SCRIPT_DIR=os.path.dirname(os.path.realpath(__file__))

env = Environment(
    loader=FileSystemLoader(os.environ.get("TEMPLATE_DIRECTORY", f"{SCRIPT_DIR}/templates/")),
    autoescape=select_autoescape()
)

template = env.get_template("README.md")

variables = {
  "project_name": os.environ["PROJECT_NAME"],
  "description": os.environ["PROJECT_DESCRIPTION"],
  "package_versions": os.environ["PACKAGE_VERSIONS"].split(),
  "python_versions": os.environ["PYTHON_VERSIONS"].split(),
  "organization": os.environ["ORGANIZATION"],
  "repository": os.environ["REPOSITORY"]
}

print(template.render(**variables))
