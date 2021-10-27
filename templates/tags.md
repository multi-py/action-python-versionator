## Tags
{% set short_repository = repository.split("/")[1] -%}

* Recommended Image: `ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-{{ package_versions|last }}`
* Slim Image: `ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-slim-{{ package_versions|last }}`

Tags are based on the package version, python version, and the upstream container the container is based on.

| {{ package }} Version | Python Version | Full Container | Slim Container |{{ ' Alpine Container |' if "alpine" in variants }}
|-----------------------|----------------|----------------|----------------|{{ '------------------|' if "alpine" in variants }}
{%- for package_version in ["latest"] + package_versions|reverse|list -%}
{%- for python_version in python_versions|reverse %}
| {{ package_version }} | {{ python_version }} | py{{ python_version }}-{{ package_version }} | py{{ python_version }}-slim-{{ package_version }} |{{ " py"+ python_version +"-alpine-"+ package_version +" |" if "alpine" in variants }}
{%- endfor %}
{%- endfor %}


### Older Tags

Older tags are left for historic purposes but do not receive updates. A full list of tags can be found on the package's [registry page](https://github.com/{{ repository }}/pkgs/container/{{ short_repository }}).
