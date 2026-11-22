
## Chapter 5: Building Knowledge Bases with RAG

### This chapter covers

- Understanding why agents need external knowledge bases
- Using keyword, vector, graph, and structure-based search methods
- Implementing vector search from scratch with embeddings,
  chunking, and similarity calculations
- Building structure-based search tools for filesystem exploration
- Extending agent capabilities through the callback pattern


### Search

**Keyword search**

**Vector search**

**Graph search**

**Structure-based search**

### Summary

Internal data requires approaches other than web search. Single files can
be read directly into context, but multiple files need exploration, and
large-scale data requires search mechanisms to extract only relevant portions.

Four search methods serve different purposes: keyword search for exact match-
ing, vector search for semantic similarity, graph search for relationship
traversal, and structure-based search for navigating organized filesystems.
Production systems often use multiple methods.

Vector search converts text to numerical vectors in which semantic similarity
becomes geometric distance. The pipeline involves chunking long documents,
generating embeddings, and calculating cosine similarity to find the most
relevant content.

Structure-based search uses filesystem organization as information in its own
right. Folder names, filenames, and directory hierarchies provide meaningful
metadata that agents can navigate using simple tools such as list_files and
read_file.

The callback pattern extends agent behavior without modifying core logic.
before_tool_callback enables HITL approval for dangerous operations, and
after_tool_callback enables automatic compression of search results.

Context engineering through search dramatically reduces token use. In our exer-
cise, extracting only relevant chunks reduced more than 37,000 tokens to 304
tokens, achieving a 99% savings rate while preserving the information required
to answer the query.

---
