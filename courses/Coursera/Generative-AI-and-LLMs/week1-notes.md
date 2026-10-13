# WEEK 1 Notes

## 1. Introduction to LLMs and the generative AI project lifecycle

GenAI Project Lifecycle
- Scope
- Select
- Adapt and Align Model
- Application Integration

### Transformer Architecture

- Encoder / Decoder
- Embedding of Input Tokens 
- Positional Encoding
- Self-Attention Layer
- Fully Connected Layer

### Prompt and Prompt Engineering

- In-Context Learning (ICL)
  - Zero-shot prompting
  - One-shot prompting
  - Few-shot promptin
  
- Useles to prtovide more than 5 or 6 examples
  ==> Need Fine-tuning

### Generative Configuation

- Max-new tokens
- Greedy vs. Random sampling
- Top-K: Choose from K tokens with highest probabilities
- Top-P: Choose from cummulative probabilty
- Temperature: Impacts shape of the probalbity distribution
  - Cooler temp. (eg < 1) ==> less randomness
  - Hot temp. (eg > 1) ==> more randomness
  - Softmax value (e.g. = 1)

----

## LLM Pre-Training and Scaling Laws

- LLM learn a statiscal reprersentation of language


### Pre-Training LLMs

- Model Hubs: E.g. Hugging Face
- Model Cards
- LLM Pre-Training GB/TB/PB of unstrctured data
- Large amount of compute & GPUs
- Only 1% - 3& pof tokens used for pre-training
- Larger models tend to perform better

#### Encoder Only Model
- Autoencoding Models
- Use Masked Langugaed Modeling (MLM)
- Self-Supervised Learning
- Objectivbe: Reconstruct text (Denoising)
- Context is Bi-directional
- Good Uses Cases
  - Sentiment Analyusis
  - NER: Named Entity Recognition
  - Word Classification
- Examples: BERT, ROBERTA


#### Decoder Only Models
- Autoregressive Models
- Use Causal Language Modeling n(CLM)
- Objective: Predict Next Token (Full Language Modeling)
- Context Unidirectional
- Use case: Text generation
- Examples: GPT Family, BLOOM


#### Encode/Decoder Models

- Sequence-to-sequence Mode
- Trained using Maked Language Modeling
- Training
  - Trained using Span Corruption (sequences of masked tokens)
  - Sequences of masked tokens then replaced with unique Sentinel Token
- Output: Sentinel Tokens followed by predicted tokens
- Objectives: Reconstruct Span
- Use cases: Translation, Text summarization, Question answering
- Useful when body of text of input and output (e.g.translation)
- Examples: FLAN-T5, BART


### Computational  Challenges

- CUDA: Compute Unified Device Architecture
- 1 parameter = 4 8-bit bytes (1B parameters ==> 4G memory)
- Training: Requires additional elements in addition to parameters
- Memory: Aproximately 20 times the number of parameters
- Quantization: Reduce size of floats numbers
  - FP32 (full precision)
  - FP16 (1/2 precision) 4 byte --> 2 byte
  - BFLOAT16 aka BF16. "Tricated FP32"
    - Has become a popular choice
	- Maintains the dynamic range of FP32
	- Used to tarin FLAN-T5
  - INT8 4 byte --> 1 byte
- Either smalller range, or fewer numbers in same range
- Choices: , , , BFPLOAT16
- BF16: Trucated 32-bit float. Adds stability to training.
- Very large models requires distributed training (many GPUs)

- Need distributed computing for large models

### Scaling Laws and Compute-Optimal Models

- Goal: Maximize mode performance
- Scaling Choices:
  - Dataset Size: number of token
  - Model size: number of parameters
  - Constraint: Compute budget (GPUs, training time, cost)
- Unit of measure
  - Petaflops / s-day
  - Number of FP operations performed at 1 petaFlop/s for one day
  - 1 Petaflop/s = 1 Quadrillion FP operations per second
  - 1 Quadrillion = 1,000,000,000,000,000
  - 1 PF/s-day is about 8 NVIDIA V100s runiing for 1-day
  - Power-Log relationshiops appear as straight lines
  - Chinchilla Paaper: Compute-Optimal LLM
    - Chinchilla Scaling Loss
    - Models are over-parametrized and under-trained
  - Result smaller models with more training data:
    - LLaMa 65B
	- BloommbergGPT 50B
	
### Efficient Multi-GPU Compute Strategies

- DDP:Distributed Data Parallel
  - Has data redundancy
- FSDP: Fully Sharded Data Parallel
  - ZeRO: Zero Redundancy Optimizer
  - Model Sharding (Distributed)
  - Helps reduce overall GPU memory utilization 
  - Control with *sharding factor*.
  - Zhao et al.(2023): "Pytorch FSDP: Experiences..."

### Pre-Training for Domain Adaptation

- Pre-Training from scratch
- Non common vocabulary and expresions
- Legal Domain & Medical Domain
- Bloomberg MModel based on Chichilla Loss
- Bloomberg was on aligned with number of parameters
- Bloommberg short on dataset size due to data unavailability

## Key Takeaways

- LLM Use cases and tasks
  - Essay Writing
  - Summarization
  - Translation
  - Information Retrieval
  - Invoke APIs and actions
- Transformer Architecture
- Generative AI Project-Lifecycle
  - Scope
  - Select
  - Adapt and Align model
  - Application Integration
- Almost always 
