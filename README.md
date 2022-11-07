# Stable_Diffusion_FastAPI_Flutter

Stable Diffusion is a deep learning, text-to-image, model which generates images based on some given description.

This codebase will be updated when I'm able, and as such, not all changes may be documented. If a changelog is present, refer to that for the latest additions or edits.

## Included:

### Stable Diffusion API Service

A microservice based on HuggingFace's publicly available repository which was optimized for Apple Silicon. I have included notes for adapting it to a CUDA based accelerator as opposed to Apple Silicon's MPS.

#### TODO:
- [ ] Add rate limiting
- [ ] Add a DB component to store the most recent generated images with tag support
- [ ] Add user management support for fun (not really required)


### Flutter Client

A flutter-based frontend which currently is a WIP (as of 7th Nov 2022) that allows you to communicate with the API service and renders the returned image.

#### TODO:
- [ ] Improve state managment (probably Riverpod support)
- [ ] Fix search function 
- [ ] Fix loading UI elements
