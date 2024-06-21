FROM python:3.8-slim
RUN apt-get update && apt-get install -y \
  git \
  wget \
  && rm -rf /var/lib/apt/lists/*
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu124
RUN useradd -m comfy && mkdir /app && chown -R comfy:comfy /app
USER comfy
WORKDIR /app
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager
RUN pip install --no-cache-dir -r requirements.txt
COPY scripts/run.sh /scripts/run.sh
EXPOSE 8080
CMD ["/bin/bash", "/scripts/run.sh"]