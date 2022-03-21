### Full
{% set short_repository = repository.split("/")[1] -%}

To pull the latest full version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-LATEST
```

### Slim

To pull the latest slim version:

```bash
docker pull ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-slim-LATEST
```

To include it in the dockerfile instead:

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-slim-LATEST
```