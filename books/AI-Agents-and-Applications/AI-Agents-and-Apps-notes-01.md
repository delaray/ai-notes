# AI Agents and Applications, Manning, 2026

## Book Resources

GitHub: https://github.com/roberto-inf/building-llm-applications/tree/main

Manning: https://www.manning.com/books/ai-agents-and-applications?continue 

Drive: https://drive.google.com/drive/folders/1mX8u9j64NfMqFGppnt6hJc0x5bXRTOgL 

---

## Chapter 1:

### This chapter covers

- Core challenges in building applications powered by large language models
- LangChain’s modular architecture and components
- Patterns for engines, chatbots, and agents
- Foundations of prompt engineering and Retrieval-Augmented Generation

---

### Building LLM-based applications and agents

LLM-based applications and agents fall into three main categories

1. **LLM-based applications** or engines are systems that deliver a specific, bounded
   capability (for example, summarization, search, or content generation).
   
2. **Chatbots** are conversational interfaces that maintain context over multiple
   exchanges. They are primarily focused on dialogue and interactive Q&A rather
   than independently taking action.
   
3. **AI agents** are autonomous or semi-autonomous systems that use LLMs to choose
   actions, plan, and execute multi-step work to reach a goal
   
#### LLM-based applications: Summarization and Q&A engines

DEFINITION **Embeddings** are vector representations of words, tokens, or larger
text units—such as sentences, paragraphs, or document chunks—mapped
into a continuous, high-dimensional space (typically with hundreds or thou-
sands of dimensions).

**Retrieval-Augmented Generation** (**RAG**) is an inference process in which in the query
phase, the engine takes a user’s question, turns it into an embedding using the same model,
and performs a semantic search over the vector store. It retrieves themost relevant chunks
and combines them with the original question to form a prompt, which is then sent to the LLM.
The model then uses the question and the retrieved context to generate an answer.

#### ChatBots

#### AI agents

An AI agent is a system that works with an LLM to carry out multi-step tasks—often
involving multiple data sources, branching logic, and adaptive decision-making.
Unlike simple pipelines, agents can operate with a degree of independence: they fol-
low the constraints you set, but they make choices about what to do next.

---

### Introducing LangChain

#### LangChain architecture

#### LangChain’s core object model

LangChain's Primary classes include:

	Document
	DocumentLoader
	TextSplitter
	VectorStore
	Retriever

#### Typical LLM use cases

---

### How to adapt an LLM to your needs

1. Prompt engineering
2. Retrieval-Augmented Generation (RAG)
3. Fine-tuning

#### Prompt engineering

#### RAG

#### Fine-Tuning

---

### Which LLMs to choose

### What you’ll learn from this book

### Summary
LLM-based systems come in three flavors: engines (specific tasks, e.g., summari-
zation), chatbots (back-and-forth dialogue with memory), and agents (autono-
mous multi-step execution with tool selection).

Embeddings convert text into mathematical vectors that capture meaning. Both
text chunks and their embeddings are stored in vector databases for efficient
similarity-based retrieval.

Retrieval-Augmented Generation (RAG) enhances LLMs by pulling relevant
information from your knowledge base before generating answers. This grounds
responses in actual documents rather than relying solely on training data.

LangChain packages common patterns into reusable components based on
three principles: modularity (swap implementations easily), composability
(chain components via LangChain Expression Language [LCEL]), and extensi-
bility (add custom loaders, retrievers, or tools).

Documents are LangChain’s basic building blocks that package text with meta-
data. Document loaders pull content from sources (PDFs, web pages, data-
bases) into standardized Document objects.

LangChain’s core components include BaseLoader (extract content into docu-
ments), TextSplitters (chunk large texts), Embedding models (convert text to
vectors), VectorStores (store and retrieve embeddings), BaseRetriever (query
backends), and BaseLanguageModel (unified LLM interface).

The Runnable interface makes all LangChain components work together
smoothly through LCEL. Components can be chained using the pipe operator
(|) to build complex workflows.

Prompt engineering crafts inputs that help models understand what you want.
Few-shot prompting includes examples in the prompt to teach the model
desired patterns.

Balance three dimensions when selecting models: accuracy (larger models
trained on more data), speed (smaller models respond faster), and cost (bigger
models charge more per token). Customer support chatbots favor speed and
cost; legal analysis tools prioritize accuracy.

Use different models for different tasks in the same workflow: for example,
GPT-5-nano for fast summarization, GPT-5-mini for answer synthesis, and full
GPT-5 for routing complex queries. This optimizes the accuracy/speed/cost
tradeoff across your system.

Choose between RAG and fine-tuning: RAG provides dynamic context at run-
time (reducing costs and retraining needs), while fine-tuning embeds domain
knowledge into the model (improving efficiency for specialized tasks).
