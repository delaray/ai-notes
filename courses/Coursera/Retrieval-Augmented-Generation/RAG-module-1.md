# Retrieval Augmented Generation

## Module 1

A conversation with Andrew Ng
Module 1 Introduction

### Course Outline
- Module 1: Basic Rag
- Module 2: Retriever
- Module 3: Vector Databases
- Module 4: LLM
- Module 5: Monitoring & Evaluation

### Introduction to RAG


### Application of RAG


### RAG Archiecture overview


### Introduction to LLMs

Fancy autocomplete
Compound words use multiple tokens
Vocabulary size: Typically 10,00 - 100,000
Generates a probability distribution across vocabulary
Earlier choices impact later choices (autoregressive)
Same prompt usually leads to different completions
Trained on trillions of tokens of text
Hallucinations
- Reproduce statistical patterns
- Knowledge gap causes inaccuracies
- Truthful not equal probable
Relevant Info grounds the LLM
- RAG <-- Retriever + KB
Limitations
- ComputationaL Cost
- Context Window Limit

We'll use together.ai in this course


### A brief Python refresher (lab, 1h)

### Introduction to Information Retrieval

Create a DB of documents
Create indexes for documents

Retriever Tradeoffs
- Relevance vs. Irrelevance
- Can't return every document
- Can't retrieve only highest ranking documents
- No perfect solution

Similar Functionality
- Search Engine
- RDB
- In general: Information Retrieval Systems

Typically built on VDB
