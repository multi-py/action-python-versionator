{% set short_repository = repository.split("/")[1] -%}
# {{ short_repository }}

{{ description }}

<!--ts-->
<!--te-->

## Benefits

### Multi Architecture Builds

Every tag in this repository supports these architectures:

{% for platform in platforms -%}
* {{ platform }}
{% endfor %}

### Small Images via Multi Stage Builds

All libraries are compiled in one image before being moved into the final published image. This keeps all of the build tools out of the published container layers.

### No Rate Limits

This project uses the Github Container Registry to store images, which have no rate limiting on pulls (unlike Docker Hub).

### Rapid Building of New Versions

Within 30 minutes of a new release to {{ package }} on PyPI builds will kick off for new containers. This means new versions can be used in hours, not days.

### Regular Updates

Containers are rebuilt weekly in order to take on the security patches from upstream containers.

## How To

{{ pull_containers }}

{{ copy_packages }}

{{ quick_start }}

{{ documentation }}

## Python Versions

This project actively supports these Python versions:

{% for version in python_versions|reverse -%}
* {{ version }}
{% endfor %}

## Image Variants

Like the upstream Python containers themselves a variety of image variants are supported.

{% if "full" in variants %}
### Full

The default container type, and if you're not sure what container to use start here. It has a variety of libraries and build tools installed, making it easy to extend.
{% endif %}

{% if "slim" in variants %}
### Slim

This container is similar to Full but with far less libraries and tools installed by default. If yo're looking for the tiniest possible image with the most stability this is your best bet.
{% endif %}

{% if "alpine" in variants %}
### Alpine

This container is provided for those who wish to use Alpine. Alpine works a bit differently than the other image types, as it uses `musl` instead of `glibc` and many libaries are not well tested under `musl` at this time.
{% endif %}


## Architectures

Every tag in this repository supports these architectures:

{% for platform in platforms -%}
* {{ platform }}
{% endfor %}

{{ funding }}

{{ tags }}

