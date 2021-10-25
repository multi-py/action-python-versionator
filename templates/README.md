# {{ project_name }}

{{ description }}

## Quick Start

### Full

To pull the latest slim version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-LATEST
```

### Slim

To pull the latest slim version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-slim-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-slim-LATEST
```

## Python Versions

This project actively supports these Python versions:

{% for version in python_versions|reverse -%}
* {{ version }}
{% endfor %}

## Image Variants

Like the upstream Python containers themselves a variety of image variants are supported.

### Full

The default container type, and if you're not sure what container to use start here. It has a variety of libraries and build tools installed, making it easy to extend.

### Slim

This container is similar to Full but with far less libraries and tools installed by default. If yo're looking for the tiniest possible image with the most stability this is your best bet.

### Alpine

This container is provided for those who wish to use Alpine. Alpine works a bit differently than the other image types, as it uses `musl` instead of `glibc` and many libaries are not well tested under `musl` at this time.

## Architectures

Every tag in this repository supports these architectures:

* linux/amd64
* linux/arm64
* linux/arm/v7

## Tags

Tags are based on the package version, python version, and the upstream container the container is based on.

{% for package_version in ["latest"] + package_versions|reverse|list %}
### {{ package }} {{ package_version }}

* Recommended Image: `ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-{{ package_version }}`
* Slim Image: `ghcr.io/{{ organization  }}/{{ repository }}:py{{ python_versions|last }}-slim-{{ package_version }}`

| Python Version | Full Container | Slim Container | Alpine Container |
|----------------|----------------|----------------|------------------|
{% for python_version in python_versions|reverse -%}
| {{ python_version }} | py{{ python_version }}-{{ package_version }} | py{{ python_version }}-slim-{{ package_version }} | py{{ python_version }}-alpine-{{ package_version }} |
{% endfor %}
{% endfor %}

### Older Tags

Older tags are left for historic purposes but do not receive updates. A full list of tags can be found on the package's [registry page](https://github.com/{{ organization }}/{{ repository }}/pkgs/container/{{ repository }}).

