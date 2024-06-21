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
      wget $model -O models/checkpoints/$(basename $model) -q
    else
      echo "Model $(basename $model) already exists."
    fi
  done
}

download_models

python main.py --listen 0.0.0.0 --port 8080