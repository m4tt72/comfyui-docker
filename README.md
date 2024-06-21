# ComfyUI Dockerized

This is a dockerized version of the [ComfyUI](https://github.com/comfyanonymous/ComfyUI) project.

## How to run

1. Clone the repository

```bash
git clone https://github.com/m4tt72/comfyui-docker
```

2. Run the compose file

```bash
cd comfyui-docker
docker compose up -d --build
```

## Run without cloning

You can run the container without cloning the repository by using the following `docker-compose.yml` file:

```yml
# compose.yml
services:
  comfyui:
    build:
      context: https://github.com/m4tt72/comfyui-docker.git
    container_name: comfyui
    restart: unless-stopped
    volumes:
      - ./models/checkpoints:/app/models/checkpoints
      - ./output:/app/output
    ports:
      - 8080:8080
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```