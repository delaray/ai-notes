# Module 3: Information Retrieval with Vector Databases

## Module 3 Introduction

- Optimized for huge amounts of vector data
- Almost synonymous with RAG
- Produuction techniques:
  - Chunking
  - Query parsing
  - Reranking
  
## Approximate nearest neighbors algorithms (ANN)

- Basic Vector Retrieval: KNN
  - Vectorize all docs
  - Compute distances to all docs
  - Sort by distance
  - Return closest K docs
  - Scales Terrible: O(n)
  
- Approximate nearest neighbor search: ANN
  - Family of Algorithms
  
  - Navigable Small worlds (NSW)
    - Create a proximity graph
	  - Compute distance between each pair of docs
	  - Create a node for each doc
	  - Link to a few of each doc's nearest neighbors
	- Randopmly selects candidate
	- Follows path from candidate to prompt vector
	  - Chooses the closest candidate neighbor
	  - Closest neighbor becomes candidate
	  - Until no neighbor id closer
	  
  - Hierarchical Navigable Small worlds (HNSW)
    - Creates a hierarchy of proximity graphs
	- Signifgicantly speeds up up early part of search
	- Makes big jumps initially
	  - Layer 1: As usual with all vectors
	  - Layer 2: 10x less vectors than layer1
	  - Layer 3: 10x less vectors than layer 2
	- Start with Layer 3
	- Then move to Layer 2
	- Then move to final Layer 3
	- O(nlog(n))
  
## Vector Databases

- Designed for Vector Search
- Outperform RDBs
- Optimized for ANN search
  - Designed to build HNSW indexes
  - Designed to compute vector distances
  
- Use Weaviaste in this course
  - Popular Open-Source VDB
  
- Typical Setup
  - Load documents
  - Create sparse vectors
  - Create dense vectors
  - Create HNSW index
  
## Chunking
  - Breaking longer chunks into smaller
  - VDBs have limit of chunk size
  - Large chunks result in loss of precision
  - What chunk size. No one-size fits all
  - Fixed size option (might split words)
  - Use overlapping chunk strategy
  - Overlap increases relevancy of chunks
  - Recursive character splitting (variable chunk size)
    - Splits based on a particlar charact (e.g. \n)
	- Pros: Preserves continuous thoughts
	- Cons: Both tiny and huge chunks, context window size
	
  - Fixed size default
    - Chunk size = 500 characters
	- Overlap size = 50 to 1oo chracters
	
## Chunking lab
- Fixed size chunking
- Variable size chunking
  - Recursive character splitting chunking
  - sentences, pargraphs, sections...
- Mixed size chunking
  - Can keep section titles non isolated
- Good chunking essential for relevance of retrieved docs


## Advanced Chunking Techniques

### Semantic Chunking
- Grouips sentences in chunks if they have similar meaning
- Results in variable size chunks
- Chunks follow authors thoughts
- More costly wrt number of vectorize operations


### LLM Based Chunking
- Can use LLM to create chunks by prompting it
- Instruct LLM with types of chunks desired
- Instruct to add breaks between chunks
- Instruct on when to start a new topic
- Performs, increasingly economically viable solution


### Context Aware Chunking
- Like above uses an LLM with supplied document
- Augments each chunk nwith contextual information
- Incredibly expensive at insertion time
- Has no effect on search time


### Summary of Advanced Techniques
- Start with simpler chhunking strategies
- Experimenent with advanced strategies
- Use a subset of your data 


## Query Parsing

- Query Rewriting
- Named Entity Recognition (e.g. GLINE)
- HyDE: Hypothetical Document Embedding 

### Cross-encoders and ColBERT

Bi-Encoder
- Docs and prompts are embedded separately by an embedding model
- ANN is useed to search and retrieve similar documents
- Doc vectors are pre-computed
- Prompt vector computed dynamically

Cross-encoder
- Prompt concatanated to each vector
- PROS
  - Almost always improves qualitry of bi-encoder
  - Great for improving other search techniques
- CONS
  - Scales terribly with millions+ docs
  - Can't pre-compute doc vectors
  - Too inefficient to use as default search technique
  
ColBERT: Contextual Late Interaction Over BERT
- Attempts to split differences between bi and cross encoders 
- Each token from both prompt and docs gets its own vector
- Create a per documednt matrix
  - Rows are the prompt tokens
  - Columns are document tokens
  - Entries are the vector similarities
  - Compute **MaxSim Score**
    - Sum of most similar score of each column
  - Yields **MaxSim Score** for that document.

### Reranking
- Purpose is tyo improve quality of retrieval
- Only a small set of documents need to be evaluated
  - Enables the use of advanced non-scalable search algorithms
- Typically have retriever overfetch documents
- Then apply a more advanced search algorithm on retrieved docs
- Rerank documents based on the new scores
- Return final score ordered documnets
- Still return 5-10 documents
- Retriever may initially retrieve 20-100 documents
- Reranker typically have a cross-encoder architecture
- Reranker adds minor latency but much higher quality results
  - Tradeoff is almost always worth it
- Today LLM based reranking can also be used
  - However as inefficient as a cross-encoder
  - Scoring can't begin until prompt received
- Reranking should be first thing explored to improve quality
  



		

	
