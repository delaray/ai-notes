# Module 2: Information Retrieval and Search Foundations

## Module 2 Introduction

Needs to match user prompt to wide range of documnets quickly


## Retriever architecture overview

Two search approaches
- **Keyword Search**
- **Semantic search**
- Known as **Hybrid Search**

Each search typically returns 20 - 50 docs
Many docs may be common to both
Ranking may differ
Each list sent to metadata filter
The filtered lists then combined and ranked

- Keyword search: Ensures sensitivity to users words
- Semantic search: Ensures docs relevant to prompt included
- Metadata filtering: Exclude docs based on rigid criteria

Need to balance these 3 techniques to meet users needs


## Metadata filtering

Uses rigid criterria
Used to narrow down retrieval results
  
PROS
- Conceptually simple
- Fast, optimized, mature & reliable
- Enfoorces strict matching rules

CONS
- Not true search
- Content ignored so no way to rank
- Useless alone

Needs to be paired with other techniques

## Keyword search - TF-IDF

- Powered retrieval for decades
- Prompt & Keywords treated as Bag of Words
- Uses sparse vectors (vector of full vocab)
- A vector ids generated for each doc
- Arranged in a matrix: 
  - **Term Documenmt Matrix**
  - Rows are words
  - Columns are documents
  - Also referred to as **Inverted Index**
  
- Simple scoring: 1 point per word
- Frequency scoring: n points per word
- IDF scoring: # of docs word appears in / total docs
- Generate TF-IDF matrix by muliplying TF matrix by IDF matrix element-wise
- Constituites standard baseline for document retrieval
- Modern systems use a refined version of TF-IDF called BM25

## Keyword search - BM25

Best Matching 25 (BM25)
- BM25 is a scoring function 
- Improves on classic TF-IDF
- The 25 refers to the 25th variant of scoring algorithms tested
- Standard keyword search technique used in RAG retrievers
- Gives the score for a single keyword in a single document

Improves TF-IDF in several ways
- **Term Frequency Saturation**
  - Discounts keyword appearance as frequency increases
  - Keyword appearing 20 times not twice as relevant as one  appearing 10 times
- **Documnt Length Normalization**
  - TF-IDF overally penalizes long documents
  - BM25 applies diminishing penalties as document size increases
  
- BM25 includes 2 tunable hyperparameters
  - k: Controls how much term frequency influences score
    - Higher value increase impact of TFC
	- Lower values reduce it
  -h: Controls degree of normalization for doc length
    - Balances favoring longer vs shorter docs
	
- MB25 vs. TF-IDF
  - better performance
  - same cost
  - more flexibility
  
Keyword Search Overview
  - Strengths
    - Convert keywords to sparse vectors
    - Simplicitly
    - Ensures exact keyword matching
  - Weaknesses
    - Depends on keyword appearing in prompt
    


## Semantic search - Introduction

## Semantic search - Embedding Model Deepdive

Embedding Model Training
- Use millions of positive and negative pair examples
- Contrastive Training Process
- Use three inputs: anchor, pos example, negative example

Key takeaways
- Semantic vectors are abstract and somewhat random
- Before training location in space has no meaning
- After training locations have meaning
- Clusters of similar text have formed
- Can Only compare vectors from same embedding model


## LAB: Vector Embeddings in RAG 

In the context of RAG, vector embeddings are used for:  

- Powering Search:  

**Capturing Meaning**  
  - Vector embeddings act like a map for text.  
  - Convert words and sentences into positions in vector space that capture meaning.  
  - Vectors can then be used to locate information matching a query.  
  
**Comparing Similarity**  
  - Prompt is converted into an embedding vector of its own.  
  - Similarity between prompt's vector and other vectors can be calculated.  
  - Helps identify texts closest in meaning to the prompt.  
  
**Understanding Context**  

- Context Matters
  - Helps in understanding the context of words in a query__
  - Ensures that the best-matched information is found.  
- Flexibility  
  - Contextual embeddings allow for adapting to different meanings__
  - Captures details that might otherwise be overlooked.  

Vector embeddings are a behind-the-scenes technology that facilitates smarter, more helpful, and accurate data retrieval by capturing nuances in a way that no other search technique provides.  
  

## Hybrid search

- **Reciprocal Rank Fusion (RRF)**  
  - **Beta** hyperparameter  
  - Provides weighting between Semantic vs Keyword  
  - A 70/30 weighting scheme is a good starting point  

Allows Retriever to take advantage of all 3 search strastegies:  
- Metadata filtering  
- Keyword Search  
- Semantic Search  
  
  
## Evaluating retrieval

Precision = Total retrieved / Total documents
Recall = Total retreieved / Total relevant

Precision penalizes for returning irrelevant documents
Recall penalizes for leaving out relevant documents

Mean Average Precision (MAP): Good indicator of average precision

Reciprocal Rank
- 1/rank
- Mean Reciprocal Rank

## Lab: Retrieval metrics


