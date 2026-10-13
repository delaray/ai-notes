# RAG Module 5: RAG Systems in Production

## Introduction

- Evaluation and Logging
- System Optimization
- Multi-modal RAG


## What Makes Production Challenging

- Scaling Performance
  - More Traffic
  - More requests
  - Scaling
  
- Messy Real World Data
  - Data can be fragmented, messy or missing metadata
  - Much of it isn't text: Images, PDFs or slide decks
  - Accessing data requires extraction tools
  
- Security and Privacy

- Mistakes in Production can be costly


## Implementing RAG Evaluation Stategies

- Build a robust observability platform
- Key Metrics
  - Software Performance Metrics
    - **Latency**,
	- **throughput**
	- **memory** 
	- **compute usage**
  - Quality Metrics
    - **User satisfaction**
	- **System Output Quality**
	
- How to Track
  - Collect agggregate statistics
    - Track trends
	- Identify regressions
  - Detailed logs
    - Trace individual prompts through system
  - Experimentation
    - A/B test changes and run secure experiments
	

- Scope & Evaluator-Type

  - Scopes: System level or component-level
  - Evaluators: Code-based, Human Eval, LLM-as-a-Judge
  
  - Systewm Scope
    - Overall eval, indicaters **what** is wrong
	  - Code-based evaluators
	    - Cheapest & simplest
		- Recordiong prompts per second
		- Unit tests for valid JSON output
		- Can run automatically
	  -Human Feedback
	    - Most costly but captures what code misses
		  - Thumbs up/down
		  - Detailed text feedback
		  - Pre-compiled test datasets
		  - Manual quality assessment
	  - LLM-as-a-Judge
	    - Splits the difference between 
		  - code-based (less flexible)
		  - human feedback (more costly)
		- Can determine if retrieved docs are relevant
		- Works best with distinct labels rather than numeric scale
		
  - Coomponent Scope
  
  
## Logging, Monitoring and Observability

- Many LLM Observability Platforms  
  - Capture system-wide and component-level metrics  
  - Help log system traffic  
  - Enable experimentation  
  - Example: **Phoenix** by Arize  

Phoienix Tools
- Traces
  - F0llow a prompt through RAG pipeline
  - Common tool
- Eval Integration
  - Integrates with Ragas
  - Interactively test your own prompts
  - A/B Test Changes
  - Generate regular reports of key syatem metrics
  
Other Monitoring Tools
 - Systems like Phoenix don't satisty all monitoring needs
 - Can use other Classic MONITORING TOOLS
   - **Datadog**
   - **Grafana**
   - Loop
     - Experiment with changes
	 - Observe traffic
	 - Evaluate performance

## Tracing a RAG System (LAB) 

- Examples of Phoenix Interface
- Prompt Traces
- Comnponent leval evaluations
- OpenTelemetry tool Library (alsao used by Phoenix)

## Customized Evaluation

Custom Dataset
- Collection of previously received prompts & responses
- Info on prompts journmey through system
- Great deal of flexibility on the data stored
- What you store determines what eval you can run
- Prompts and responses are good systemwide evals
- For detailed evals collect more data from each component
- Datasets can easily get massive

Visualizaing Data
- Important for detecting high-level trends
- Clustering tools allow you to identify trends
- Can evaluate each cluster individually

## Quantization

- Can evaluate different tradeoffs__
  - Speed__
  - Cost__
  - Quality__
  
- Good amalogy is Image compression__

- LLM Quantization__
  - Typical LLM has 16-bit parameters__
  - For example 32-bit float mapped to 8-bity float__
  
- Quantization process__
  - Assume we want 8-bit vectors__
  - 1. Find min & max values that appear in each dimension__
  - 2. Divide each range into 256 sections (max 8 bits can represent)__
  - 3. Sections are then labeled 1,...256__
  - 4. Each FP number from original vectors assigned an integer__
  - 5. If you store min & section size can recover the values__
  
- Quantization Performance__
  - 8-bit integer quantization performs remakebly well__
  - Embeddings models show only few percentage drop in recall@k__
  - Often only have a minor drops in performance in standard benchmarks__
  - Use less GPU memory and run faster __
  
- 1-bit Quantiozed Embedding Models__
  - Gaining popularity__
  - Compress the model size by 32x__
  - Each value is either a 0 or a 1.__
  - Performance can drop noticeably__
  - Fast 1-bit retrievaL + full-precision reranking__
	
- Matryoshka Quantization__
  - Baseed on Russian woird for nesting__
  - Choose Your vector size__
  - Dimensions sorted by information__
  - Flexible retrieval approaches__
  
- Advanced technioquews are very new__
- First experiment with integer (8-bit) quantization.__


## Cost vs Response Quality

Primaryt RAG Cost Drivers
- LLMs
- VDBs

Optimizing LLM Costs

- Smaller Models
- Smaller Prompts
- Host Models on dedicated endpoints

Vector Database Cost Reduction

- Three types of Memory
  - **RAM**: Fastest and most expensaive
  - **Disk Memory** Somewhat fast, cheaper
  - **Cloud Object Storage**
  
- Key Principle
  - Styore HNSW index in RAM
  - Move Rarely accessed vectors to SSD/Disk
  - Keep document contents in object storage
  
- Multi-Tenancy
  - Divide documents by user and org
  - Each Tenant has their owen HNSW index
  - Dynamically move tenant data to RAM or slower storage
  - Can leverage multi-tenancy as follows
    - On-demand data loading
	  - Load tenant's index into memory whewn they log in
	- Time zone optimization
	  - Move tenant data into faster storage during their daytime
	  
- Essenhtially moving data in and out memory
- By dividing by tenant can do this efficiewntly


## Latency vs. Response Quality

Why Latency Matters

First Address LLM
  - LLM calls takes most time iun RAG
  - Use smaller or quantized models
  - Caching frequent prompts

Next Improve Other Transformer based compoments
 - Reranker
 - Query-rewriter
 - Router LLM
 
 - Identify which component is less effecting quality
 - Then Remove that component
 
Retrieval Latency
- Quantized embeddings
  - Use binary/low-bit quantized vectors
- Database Sharding
  - Split large indexes across instances
- Leverage provider tools
  - Most platforms support these features
   
## Security

Cybsecurity is a complex topic

Securing your Knowledge Base
- Autheticate Users
- Data Tenant Separation
- Metadata filtering not sufficiently secure

LLM Data Leakage
- Have no control once daqa is sent to a provider
- Hosting your own LLMs and hardware is the most secure
  - Run your RAG system entirely on premise

Database Hacking Risks
  - Hackers frequently penetrate DBs

Vector Reconstruction Risk
 - Research shows text reconstruction from dense vectors possible
 - Miigation Techniques
   - Adding noise to vectors
   - Applying transformations
   - Reducing dimewnsionality while preserving distance
 - Subject of ongoing research
 
- Knowledge base liokely contains sensitive data
- Need to understand risks and safegards


## Multimodal RAG

Mulkti-Modal Model
- Handle different types of data
  - Text docs
  - Images
  - Audio & Video also possible


Both Retriever and LLM need to become multi-modal

- Multi-modal Embedding-Model
  - Embeds both text & images into proximal vectors when similar
  
- Multi-modal Vector Retrieval
  - Works like regular retriever
  - Both text & images returned 
  - Prompt augmented with both types
  
- Multi-Modal Model
  - Language Vision Model
  - Processes both text and images using shared token sequence
  
  - Image tokenization
    - Each patch represented by a vector
	- Typically 100-1000 tokens per image
	- Significantly increases number of tokens
	
- Upgrading RAG System
  - Straightforward once you have
    - multi-modal embedding model
	- multi-modal language model
	
- PDF RAG
  - Slides and PDFs are information dense
    - Text
	- Captions
	- Charts
	- Images
	
  - Old Approach used sophisticated detection algorithms
  
  - **PDF RAG**
    - Split into grid of patches, regardless of content
	- Then vectorize each patch like you wouls a text chunk
	- Chunking strategy for PDFs
	
  - Benefits
    - Very flexible
	- Performns well
	- Promoiing direction for mu8ltimodal retrieval

