# AI Agents in Action

## About this Book

Executable snippets of code:
  - https://livebook.manning.com/book/ai-agents-in-action 
  
The complete code for the examples in the book:
  - https://www.manning.com/books/ai-agents-in-action 

GPT-Agents:  https://github.com/cxbxmxcx/GPT-Agents
 - Holds the code for several examples demonstrated in the chapters.
 
GPT Assistants Playground: https://github.com/cxbxmxcx/GPTAssistantsPlayground
  - An entire platform and tool dedicated to building OpenAI GPT assistants with 
    a helpful web user interface and plenty of tools to develop autonomous agent
	systems.
	
Nexus: https://github.com/cxbxmxcx/Nexus
  - An example of a web-based agentic tool that can help you create agentic systems 
    and demonstrate various code challenges.


## Chapter1: Introduction to Agents and Their World

Four types of user LLM interactions  

1. Direct user interaction  
2. Agent/assistant Proxy  
3. Agent/assistant  
4. Autonomous agent  

Five types of Agent Components  

1. Actions and tool use
2. Reasoning and evaluation
3. Profile and Persona
4. Memory and knowledge
5. Planning and feedback  

### Profiles and Persona

Agent profiles describe the work that is required and the tools needed.  

* Profile Contents
  Persona: Role, i.e., coder or tester
  Demographics: Sex, age, background

* Profile Generation
  Handcrafted: Manually designed by humans
  LLM generated: Directed by human prompts
  Data generated: Constructed from data personas
  
  
### Actions

* Threee types of agent actions  

1. Task completion
2. Exploration
3. Communication

* Agent Action Aspects  

1. Action target  
2. Action space  
3. Action impact  
4. Action generation  


### Memory and Knowlwdge  

* Used to provide context and limit token usage  
* Can be unified or hybrid  


Retrieval Structure
• Unified
• Hybrid

Retrieval Formats
• Language
• Databases
• Embeddings
• Lists

Retrieval Operation
• Augmentation
• Semantic Extraction
• Compression
  
  
### Reasoning and Evaluation

* Reasoning provides the ability to think through probles and evaluate solutions  
* Reasoning allows for self-reflection and internal reasoning  
* Evaluation provides the basis for self-reflection of task completion  
  
Reasoning  
• Zero-shot prompting
• One-shot prompting
• Few-shot prompting
• Chain of thought
• Tree of thought
• Skeleton of thought

Evaluation  
• Self-consistency
• Prompt chaining
  
  
### Planning and Feedback

* Planning may employ single-path reasoning, sequential reasoning  or multipath reasoning  
* External planners can be code or other agent systems  
* External planners may also play a role in orchestrating plans  
* The planning component has a role outside of the autonomous agent  

Two types of Agent Planning   

1. Planning without feedback  
   Autonomous agents make decisions independently.  
   
2. Planning with feedback  
   Monitoring and modifying plans is based on various sources of input.
   This includes environmental changes and direct human feedback.
   
   
Planning without feedback (autonomous)  
• Basic planning
• Automatic reasoning with tool use
• Sequential planning

Planning with feedback  
• Environmental feedback
• Human feedback
• LLM feedback
• Adaptive constructive feedback
  
  
### Rise of Agents Era

* Planning, iteration, and repetition are the best processes for solving complex and multifaceted goals for an LLM.

* Autonomous agent systems require trust in the agent decision-making
process, the guardrails/evaluation system, and the goal definition


### Summary

- An agent is an entity that acts or exerts power, produces an effect, or serves as a means for achieving a result. An agent automates interaction with a large language model (LLM) in AI.  

- An assistant is synonymous with an agent. Both terms encompass tools such as OpenAI’s GPT Assistants.  

- Autonomous agents can make independent decisions, and their distinction from non-autonomous agents is crucial.  

- The four main types of LLM interactions include direct user interaction, agent/assistant proxy, agent/assistant, and autonomous agent.  

- Multi-agent systems involve agent profiles working together, often controlled by a proxy, to accomplish complex tasks.  

- The main components of an agent include the profile/persona, actions, knowledge/memory, reasoning/evaluation, and planning/feedback.  

- Agent profiles and personas guide an agent’s tasks, responses, and other nuances, often including background and demographics.  

- Actions and tools for agents can be manually generated, recalled from memory, or follow predefined plans.  

- Agents use knowledge and memory structures to optimize context and minimize token usage via various formats, from documents to embeddings.  

- Reasoning and evaluation systems enable agents to think through problems and assess solutions using prompting patterns such as zero-shot, one-shot, and few-shot.  

- Planning/feedback components organize tasks to achieve goals using single-path  

- The rise of AI agents has introduced a new software development paradigm, shifting from traditional to natural language–based AI interfaces.  

- Understanding the progression and interaction of these tools helps develop agent systems, whether single, multiple, or autonomous.  


## Chapter 2: Harnessing the power of large language models

This chapter covers
- Understanding the basics of LLMs
- Connecting to and consuming the OpenAI API
- Exploring and using open source LLMs with LLM Studio
- Prompting LLMs with prompt engineering
- Choosing the optimal LLM for your specific needs

### Mastering the OpenAI API

* Connecting to the chat completions model
* Understanding the request and respones

### Exploring open source LLMs with LM Studio

* Installing and running LM Studio
