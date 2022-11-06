# Use uvicorn to autorun app
import uvicorn

# Import actual libraries
from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware
import base64
import torch
from torch import autocast
from io import BytesIO
from diffusers import StableDiffusionPipeline

# Create an config.py or other config file to store the huggingface token
from config import token

app = FastAPI(title="Stable Diffusion Demo", version="0.1.0", debug=True)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True
)

'''Configuration data'''
accelerator = "mps"  # use `mps` for Apple Silicon machines, or `cuda` for Nvidia GPUs, or just CPU as default
model = "runwayml/stable-diffusion-v1-5"  # retrieve a model from Hugging Face, you may need to agree to a TOS first!

'''Refer to the documentation here: https://huggingface.co/docs/diffusers/optimization/mps'''
pipe = StableDiffusionPipeline.from_pretrained(model, use_auth_token=token)
pipe = pipe.to(accelerator)

# Recommended if the host has < 64 GB of RAM to reduce memory pressure during generation
pipe.enable_attention_slicing()


@app.on_event("startup")
async def initialize():
    warmup_prompt = "A day at the beach in Trinidad and Tobago"
    _ = pipe(warmup_prompt, num_inference_steps=1)


# Endpoints

@app.get("/alive")
def alive():
    return Response(status_code=200)


@app.get("/")
async def generate(image_query: str):
    return prompty(image_query)


def prompty(query: str):
    try:
        image = pipe(query).images[0]
        # image.save(f"{query.strip()}.png")
        buffer = BytesIO()
        image.save(buffer, format="PNG")
        imgstr = base64.b64encode(buffer.getvalue())
        return Response(content=imgstr, media_type="image/png")

    except Exception as e:
        print(e)
        raise e


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, limit_concurrency=1, backlog=2048, use_colors=True, log_level='debug')
