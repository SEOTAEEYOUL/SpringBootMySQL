. ./podman.env

podman tag "${repositoryName}:${tag}" "${acrName}.azurecr.io/${repositoryName}:${tag}"
podman push "${acrName}.azurecr.io/${repositoryName}:${tag}"
