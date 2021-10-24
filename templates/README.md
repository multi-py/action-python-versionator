# {{ project_name }}

{{ description }}

## Quick Start

To pull the latest version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-slim-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-slim-LATEST
```

## Tags

Tags are based on the package version, python version, and the upstream container the container is based on.

{% for package_version in ["latest"] + package_versions|reverse|list %}
### {{ package }} {{ package_version }}

| Python Version | Full Container | Slim Container | Alpine Container |
|----------------|----------------|----------------|------------------|
{% for python_version in python_versions|reverse -%}
| {{ python_version }} | py{{ python_version }}-{{ package_version }} | py{{ python_version }}-slim-{{ package_version }} | py{{ python_version }}-alpine-{{ package_version }} |
{% endfor %}
{% endfor %}

