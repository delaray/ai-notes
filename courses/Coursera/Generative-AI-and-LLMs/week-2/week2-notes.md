# WEEK 2 Notes

## Fine-Tuning LLMs with Instruction

- Learning Objectives
  - Describe how fine-tuning with instructions using prompt datasets can improve performance on one or more tasks  
  - Define catastrophic forgetting and explain techniques that can be used to overcome it  
  - Define the term Parameter-efficient Fine Tuning (PEFT)  
  - Explain how PEFT decreases computational cost and overcomes catastrophic forgetting  
  - Explain how fine-tuning with instructions using prompt datasets can increase LLM performance on one or more tasks  
  
  

### Introduction

- Instruction Fine-Tuning  
  - Tuning the model to know how to answer  
- Paraameter Efficient Fine-Tuning (PEFT)  
  - LoRA (reduces memory footprint)  
- Full Fine-Tuning can be cost prohibitive.  

### Instruction Fine-Tuning

- Fine-Tuning with Instruction Prompts  
- Limitation of In-copntext learning  
  - Insufficient for small models  
  - Space constrained bu Context Window  
- Task Specific examples  
  - Pairs of: Prompt[...] and Completion[...]   
  - GB - TB of labeled examples  
- Known as Full Fine-Tuning  
  - 1. Prepare your data  
  - 2. Prompt template libraries  
       - Map datasets --> Instruction prompts  
	   - Divide into training, test, validation  
  - 3. Standard Supervised Technique (Backprop)  
  - 4. Takes Pre-Trained Model ==> Instruct Model  


### Fine-Tuning on a Single Task

- Usually 500-1000 examples sufficee  
- May lead to catastrophic forgetting  
  - Avoid by mtraining on multiple tasks  
  - Can use PEFT techniques  


### Multitask Instruction Fine-Tuning

- May require much more data   
  - May require 50,000 - 100,000  
- FLAN: Fine-tuned LAnguage Net  
- FLAN-T5  
  - Fine-Tuned version T5  
  - 473 Datasets, 146 task categtories  
  - Includes different variations of the same instruction  
  - Great general purpose instruct model  


### Scaling Instruct Models

  - Chung et al (2022): "Scaling Instruction-Finetuned Language Models"  

### Model Evaluation

- Output is non-deterministic  
- ROUGE Metric  
  - Recall-Oriented Understudy for Gisting Evaluation  
  - Used text summarization  
- ROUGE-1: Unigrams  
  - recall, precision, F1 (harmonic mean)  
- ROUGE-2: Bigrams  
  - recall, precision, F1 (harmonic mean)  
- ROUGE-L: Longest Common Subsequence (LCS)  
- ROUGE clipping: Clip number of unigrams  
  
- BLEU Metric  
  - Bi-Lingual Evaluation Understudy  
  - Metric for text translation  
  - Avg(precision across range of n-gram sizes)  
  
### Benchmarks
  
- GLUE: General Language Understanding Evaluation (2018)  
- SuperGLUE (2019)  
- MMLU: Massive Multitask Language Understanding (2021)  
- BIG-bench (2022)  
  - Big-Bench  
  - BIG-Bench Hard  
  - Big-Bench Lite  
- HELM: Holistic Evaluation of Language Models  

----
  
  
## Parameter Efficient Fine-Tuning

### Paraameter Efficient Fine-Tuning (PEFT)

- Need to Allocate memory  
  - trainable weights  
  - optimizer states  
  - gradients  
  - forward activations  
  - temporay memory  
- PEFT only update a subset of model mparameters  
- All (most) weights are kept frozen  
- Makes memory requirements more manageable  
- Can often be performed on a single GPU  
- PEFT helps prevent catastrophic forgetting  


### PEFT Techniques 1: LoRA

- Low-Rank AdaptationFine-Tuning method  
  - Freeze most of the original LLM weights  
  - Inject 2 rank decomposition matrices  
  - Train the weight of the smaller matrices  
    
- Steps to update model for inference  
  - Matrix multiple the low rank matrices  
  - Add to the original weights  
    
- Reduces number ofd trainable parameters significantly  
- Can be applied to Attention weights or FF weights  
- More effective on the attention weights  
- Can use LoRA for many tasks on same Foundation model  
- Choosing rank of the low-rank matrices still reasearch area  
- Rank range of 4 - 32 has shown promising results  
- Substitute the LoRA parameters at inference tinme  
- Can train different LoRA matrices for different tasks.  
- Still Performance / Cost tradeoff to consider when FT.  
  
### PEFT Techniques 2: Soft Prompts (Prompt Tuning)
  
- Prompt Tuning IS NOT Prompt Engineering  
- Add a number of trainable SOFT PROMTS to inputs  
- 20 to 100 virtual tokens can be sufficient  
- Soft prompts are not fixed vectors  
- Embedding vectors get updated during fine-tuning  
- Train a differentr set of soft prompts for different tasks  
  
### Key Takeways

- Instructioon Finetuning  
-   
- Evaluation Metrics  
- PEFT Reduce compute cost  
  
----
