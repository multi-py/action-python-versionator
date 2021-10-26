# Python Versionator - Github Action

This Github Action is part of the [Multi-Py Project](https://github.com/multi-py). It works alongside the [Multi-Py Image Builder Action](https://github.com/multi-py/action-python-image-builder) to continuously release multiarchitecture containers.

The Versionator takes three primary actions-

* Updates a designated workflow with the most recent versions of a Python package.
* Updates that same workflow with the most recent Python versions.
* Updates the project README file based off of the templates in this project.

In other words, when a Python package gets pushed to PyPI this action will update workflows to use it. This is how Multi-Py can release new containers quickly after upstream packages are released.

## Example Workflow

```yaml
# Every 30 minutes check for a new version of the package.
on:
  push:
    branches:
      - 'main'
  schedule:
    - cron:  '0,30 * * * *'

jobs:
  Version-Updater:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2
        with:
          # Github Actions can't be granted the required workflow
          # permissions, so it has to be a Personal Access Token.
          token: ${{ secrets.WORKFLOW_GITHUB_TOKEN }}

      - name: "Update Build Workflow"
        uses: multi-py/action-python-versionator@main
        with:
          package: "uvicorn"
          git_name: "Robert Hafner"
          git_email: "user@example.com"
          action_path: ${{ github.workspace }}/.github/workflows/build_and_push.yml
```

## Readme Templates

The default templates are very specific to the Multi-Py project. Templates can be overridden- by default any files in your repo's `templates` directory will get used instead of the action ones. A `README.md` file will replace the entire default template, or specific components can be overridden while allowing the others to remain (`description.md`, `quick_start.md`, `tags.md`, `documentation.md`). The `template_directory` parameter can be used to specific a different template directory.
