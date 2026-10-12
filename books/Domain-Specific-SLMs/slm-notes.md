# Domain-specific Small Language Models

## Chapter 1: Small Language Models


- Typically 100 millions to 10 billions parameters
- No official cut-off point

- NVIDIA 2025
  - "Small Language Models are the Future of Agentic AI”
  - https://arxiv.org/abs/2506.02153
  
  
### Transformers

- Two families of Transformers
  - BERT: Just uses the encoder part
  - GPT: Just uses the decoder part
  
- RLHF: Important aspect of transformers evolution


### LLM Areas of Application

  - Language understanding
  - Text classification
  - Test generation
  - Question answering
  - Document summarization
  - Semantic parsing
  - Pattern recognition
  - Basic math solving
  - Code generation
  - Dialogue
  - General knowledge
  - Logical inference chains
  
- The open source revolution


### Risks and challenges with generalist LLMs
  - Deployment outside your organization’s network
  - Data leakage risks
  - Model or version drift
  - Cost unpredictability
  - Closeness
  - Transparency
  - Hallucinations
  - Compliance
  - Harmful content generation
  - Code generation
  
  
### Domain-specific vs. generalist LLMs for business value
  - For specialized domains and tasks, you’ll need a strategy to tune the pretrained model
    on domain-specific data
  - This porocess is commonly called **Transfer Learning**
  - Transfer Learning involves taking a model trained on one task or domain and applying it
	to a related task or domain.
  - Can use full SFT or partial (subset of layers) SFT. 
  - Catastrophic forgetting is a noticeable drop in performance on general knowledge or
    initial capabilities due to a model being trained on new data and tasks.
  - Many domains require SLM specialization

- A  definition of **alignment** is adhering to principles of:
  - helpfulness (following user instructions, completing a task, and providing results),
  - truthfulness (providing factual information and acknowledging limitations),
  - harmlessness (avoiding biased or toxic responses and refusing to assist with harmful tasks)


### Summary
- Transformers use self-attention mechanisms to process entire text sequences at once instead
  of word by word.
- Self-supervised learning creates training labels automatically from text data without
  human annotation.
- RLHF uses reinforcement learning to improve large language model (LLM)
  responses based on human feedback.
- LLMs can generate any symbolic content including code, math expressions, and
  structured data.
- Open source LLMs reduce development costs by providing pretrained models as
  starting points.
- Transfer learning adapts pretrained models to specific domains using
  domain-specific data.
- Generalist LLMs risk data leakage when they’re deployed outside organizational
  networks.
- Closed source models lack transparency about training data and model
  architecture.
- Domain-specific LLMs provide better accuracy for specialized tasks than gener-
  alist models.
- Smaller specialized models require less computational power than large gener-
  alist models.
- Fine-tuning costs significantly less than training models from scratch.
- Regulatory compliance often requires domain-specific models with known training data.



## Chapter 2: Tuning for a Specific Domain 

### Data Preparation

#### This Chapter Covers

- Preparing data for LLM customization
- The basics of retrieval-augmented generation
- Fine-tuning an LLM
- Alternatives to fine-tuning


#### Notes on Tokens

- For LLMs, a token is a unit of text the model processes during training and 
  inference. Tokens can represent words, subwords, characters, punctuation, and
  special characters.
  
- How text is tokenized directly affects model performance and language understanding
  by shaping how well it manages vocabulary, handles out-of-vocabulary words, and
  generates coherent responses.
  
- Tokenization is vital in NLP: the token count determines input size and affects
  processing time and memory use. LLMs have a maximum number of tokens they can
  accept in a single prompt.
  
- Most pretrained models on the Hugging Face Hub include a custom tokenizer, since
  each architecture expects a specific token format.


#### Data preparation for BERT fine-tuning

Dataset: List of tuples
Pick & load tokenizer
Format data by inserting start & end tokens ([CLS]) and separator tokens ([SEP])
Tokenize formatted data
Extract input ids & attention mask from tokenized data
Encode laabels from Dataset (use sklearn LabelEncoder)
Create train & val sets for inputs and lables (use sklearn train_test_split)
Create CustomDataset class (inherit from torch Dataset)
  - input_ids
  - attention_maSK
  - labels
Create train & val CustomDataset instances
Create train & val DataLoader instances


#### Data preparation for GPT fine-tuning

Similar to BERT but CustomDataset class only has input_ids and different __init__
and __get_item__ methods.

#### Data preparation for RAG

- Converrt knowledge base to embeddings
- Store in as vector DB

- Example with FAISS

Load knowledge into FAISS index
- DF of text & context
- Load encoder from SentenceTransformer
- Generate vectors by encoding text in df
- Create a FAISS index (IndexFlatL2) using vector dimensionality
- Normalize vectors (faiss.normalize_L2)
- Add vectors to FAISS index
- FAISS uses Euclidian distance for proximity

Retrieve similar contexts
- Start with search text
- Search vector: Encode search text and convert to np.array
- Normalize search vector
- Compute k nearest neighbors using FAISS index search method 
- Search results include distances and vector indices for k vectors


### Retrieval-Augmented Generation

- RAG integrates data retrieval into LLM content generation
  - Retrieval phase
  - Content generation phase
  
- Can implement RAG-based solution with LangChain
- Many other dedicated frameworks

### Fine-Tuning

- Further trains a pretrained LLM on a smaller, task-specific dataset
- FT uses a smaller, task-specific, labeled dataset
- Can update all model weight or
- Can use PEFT to update smaller subset of weights

- QA example with DistillBERT-base (on HF)
- Training data has 3 fields
  - Question
  - Context
  - Answer
  
- Several QA datasets available on HF
- Hugging Face Datasets library
- https://github.com/huggingface/datasets

- Load a dadaset:
  - training_set = datasets.load_dataset("<dataset_id>")
  - training_set = training_set.train_test_split(test_size=0.2)
  
- Load tokenizer
  - tokenizer = AutoTokenizer.from_pretrained("distilbert-base-uncased")
  
- Implement a custom preprocess function
- Apply the custom function to the entire dataset

- Load model
  - model = AutoModelForQuestionAnswering.from_pretrained("distilbert-base-uncased")
  
- create a batch of examples
  - Use the Transformers library’s DefaultDataCollator
  
- Train the model
  - Use from transformers TrainingArguments & Trainer
  - trainer.train()
  
- Test inference with sample question and context (i.e. paragraph of text)
  - Tokenize:
	- inputs = tokenizer(question, context, return_tensors="pt")
	
  - Infer:
    - with torch.no_grad(): outputs = model(**inputs)
	
  - Select the highest-probability start and end positions from the model’s output
	- answer_start = outputs.start_logits.argmax()
    - answer_end = outputs.end_logits.argmax()
  
  - Decode the predicted tokens to get the answer
    - predict_answer_tokens = inputs.input_ids[0, answer_start : answer_end + 1]
    - tokenizer.decode(predict_answer_tokens)

### LoRA

PEFT is a set of techniques for adapting a pre-trained model by updating only a 
small fraction of its parameters

These are some major PEFT methods:

- LoRA (Low-rank Adaptation)—The main topic of this section

- Prefix tuning: Keeps the LLM parameters frozen and optimizes a sequence of
  continuous, task-specific vectors called the prefix
  
- LoftQ: A framework that quantizes an LLM and provides a low-rank
  initialization for LoRA fine-tuning
  
- AdaLoRA: A LoRA variant that adaptively allocates the parameter budget across
  weight matrices based on importance scores
  
- P-tuning: Uses trainable continuous prompt embeddings concatenated with dis-
  crete prompts
  
- Prompt tuning—A simpler form of prefix tuning that scales better to larger
  models

LoRA Paper:
  - “LoRA: Low-Rank Adaptation of weights Large Language Models”
  -  https://arxiv.org/abs/2106.09685
  
See example CoLab notebook that uses FLAN-T5
	The dataset used in this example is samsum
	https://huggingface.co/datasets/knkarthick/samsum
	

### Summary

- BERT tokenization adds special tokens [CLS] and [SEP] to mark sequence boundaries
  for classification tasks.
- GPT models use context-target pairs, learning to generate target text from the
  input context.
- Tokenizers convert text to numerical representations that models can process
  during training and inference.
- FAISS builds vector indexes for efficient similarity search over large text
  embedding datasets.
- RAG combines retrieval and text generation to give models access to external
  knowledge
- RAG retrieves relevant information from vector databases before generating
  responses, improving accuracy.
- Fine-tuning adjusts all parameters of a pretrained model using task-specific
  labeled datasets.
- LoRA fine-tunes only a small subset of a model’s parameters, retaining the 
  original weights.
- PEFT techniques like LoRA cut computational costs compared with full fine-­
  tuning while maintaining performance.
- RAG works better for up-to-date information and reduces hallucinations through
  source traceability.
- Fine-tuning produces better results for complex, domain-specific tasks that
  require specialized knowledge.
- Vector databases store embeddings and support fast similarity search for RAG
  implementations.
