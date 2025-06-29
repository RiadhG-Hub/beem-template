# Whisper Model Configuration

## Instructions

1. Replace `ggml-tiny.bin` with any model from the [Whisper.cpp models repository](https://huggingface.co/ggerganov/whisper.cpp/tree/main).

2. After replacing the model file, don't forget to update the model path in the code:
   ```dart
   // File: lib/core/util/whisper_converter.dart
   ```

## Available Models

All models can be found at the Hugging Face repository:
[https://huggingface.co/ggerganov/whisper.cpp/tree/main](https://huggingface.co/ggerganov/whisper.cpp/tree/main)

## Notes

- Different models have different sizes and accuracy levels
- Larger models provide better transcription quality but require more resources