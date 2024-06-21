#!/bin/bash

function download_models() {
  MODELS_LIST=(
    "https://huggingface.co/RunDiffusion/Juggernaut-X-Hyper/resolve/main/JuggernautXRundiffusion_Hyper.safetensors"
    "https://huggingface.co/RunDiffusion/Juggernaut-X-v10/resolve/main/Juggernaut-X-RunDiffusion-NSFW.safetensors"
  )

  for model in "${MODELS_LIST[@]}"
  do
    if [ ! -f "models/checkpoints/$(basename $model)" ]; then
      echo "Downloading $model..."
      wget $model -O models/checkpoints/$(basename $model)
    else
      echo "Model $(basename $model) already exists."
    fi
  done
}

# check missing environment variables
if [ -z "$PORT" ]; then
  echo "PORT environment variable is missing. Using default port 8080."
  PORT=8080
fi

if [ -z "$HOST" ]; then
  echo "HOST environment variable is missing. Using default listen address 0.0.0.0"
  HOST=0.0.0.0
fi

if [ "$DOWNLOAD_MODELS" = "true" ]; then
  download_models
fi

python main.py --listen $HOST --port $PORT
