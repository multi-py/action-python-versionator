### Using the Full Image
{% set short_repository = repository.split("/")[1] -%}

The Full Images use the base Python Docker images as their parent. These images are based off of Ubuntu and contain a variety of build tools.

To pull the latest full version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-LATEST
```

### Using the Slim Image

The Slim Images use the base Python Slim Docker images as their parent. These images are very similar to the Full images, but without the build tools. These images are much smaller than their counter parts but are more difficult to compile wheels on.

To pull the latest slim version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-slim-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-slim-LATEST
```


{% if "alpine" in variants %}
### Using the Alpine Image

The Alpine Images use the base Python Alpine Docker images as their parent. These images use Alpine as their operating system, with musl instead of glibc.

In theory these images are smaller than even the slim images, but this amounts to less than 30mb difference. Additional Python libraries tend not to be super well tested on Alpine. These images should be used with care and testing until this ecosystem matures.


To pull the latest alpine version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-alpine-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-alpine-LATEST
```

{% endif %}

