
## Chapter 1: What is an AI agent?

### This chapter covers

- The landscape of AI agents today
- LLMs as the decision-making core of agents
- Workflows vs agents and when to use each
- GAIA benchmark for measuring agent performance
- Context engineering for building effective agents

### Frameworks for building agents

- LangGraph
- CrewAI
- AutoGen
- OpenAI Agents

### Landscape of AI agents

- **Personal AI Agents**
  - ChatGPT, Claude, and Gemini 
  - Serve as general-purpose assistants
  
- **Customer-Facing Agents**
  - Operate on behalf of businesses
  - Interact directly with customers in real time.
  
- **Specialized Agents**
  - Tackle domain-specific tasks that require deep expertise
  - Coding agents can navigate codebases, add features, fix bugs,
	and refactor code
  - Deep Research agents can conduct investigations across hundreds of sources
  
All agents are powered by Large Language Models

### LLM Agents

Core Agent Definition: AUTONOMOUS CONTROL FLOW

An LLM agent is a program that autonomously decides
  - What actions to take
  - When to stop based on its current context and goals.
  
By control flow, we mean the sequence of “what to do next.” In traditional software, this
flow is spelled out in the code.

ELEMENTS THAT REALIZE AUTONOMY: LLM + TOOL + LOOP

HOW THE AGENT LOOP WORKS

The process follows a continuous loop:

1.The LLM evaluates the current context
2.The LLM evaluates the current context
3.The tool's results are added back to the LLM's context
4.The LLM decides whether to continue or stop

This iterative process of reasoning, acting, and observing enables the agent to handle tasks
of unpredictable complexity.


### Workflow: Developer-defined flow

A workflow is a system where developers explicitly design the sequence of operations, with
LLMs executing specific steps within that predefined structure. The key characteristic is
predictability: given the same input, the system follows the same path through the
workflow.

Progression of agency levels in LLM applications.

- Code
  - No LLM. Just the developer
- LLM Call
  - The most basic pattern is a single LLM call
- Chain
  - A chain connects multiple LLM calls in a predefined sequence
- Router
  - A router introduces conditional logic. The LLM decides which path to take next.
  
### Agent: LLM-directed flow

The defining pattern of an agent combines two capabilities:

- Tool Call
  - The ability to use external tools
- Multi-step
  - The autonomy to continue operating until the task is complete.

At the highest level of autonomy, the agent doesn't just select from available tools.
- Tool creation: Agent creates new tools
  - Typically involves generating code to implement new functionality
  
In practice, the most effective architectures often combine both workflows and agents


### Agents as Nodes in a Workflow

A common pattern is to design an overall workflow with well-defined stages, but implement
one or more of those stages as an agent. Consider a document processing pipeline:

1.**Document intake** (workflow): Validate format, extract metadata
2.**Content analysis** (agent): Research context, gather related information, synthesize findings
3.**Quality review** (workflow): Check against compliance rules, format output
4.**Delivery** (workflow): Route to the appropriate destination

The architectural choice isn't "workflow or agent" but rather "where in this system does
agent behavior provide enough value to justify its costs?"


### Deciding when to use LLMs and Agents

Two key decisions shape whether an agent is the appropriate solution:
1. Does this task require an LLM at all?
2. If an LLM is needed, does it require an agent, or will a workflow suffice?

#### Conditions for using LLMs
- Tasks involving unstructured data
- Handling input diversity


#### Conditions for using agents
- Does the task require iterative reasoning and tool use
- Agent inherent trade-offs
  - Costs are higher
  - Latency increases
  - Errors propagate.
  
#### Agent use Crfiteria

- Task complexity
- Task value
- Error cost and detectability


### GAIA: An agent gym

In 2023, Meta and HuggingFace released GAIA (General AI Assistants), a dataset that
systematically collects tasks requiring agents.

This book uses GAIA for three specific reasons.
- Clear answers enable fast feedback
- It's optimal for practicing the agent development cycle
- No domain knowledge required

GAIA gives us a way to measure agent performance. But measurement alone doesn't
improve an agent. What actually makes an agent better at solving these problems? The
answer lies in how we engineer the context the LLM receives.

### Context Engineering

Definitions
- A prompt is the input text that a user sends to an LLM

- Context is a broader concept that encompasses all the information an LLM references
  - The system prompt
  - User messages
  - Previous conversation history
  - Tool execution results
  - Retrieved documents
  
In this sense **prompts** are just one component of **context**.

Agent failure reasons
- Insufficient model intelligence
- Lack of necessary information

**Context engineering** is the discipline of providing the information an LLM needs to perform
its tasks at the right time and in the right form

- Bigger context is not always better
- Context Rot
  - Model performance degrades as context length increases
  - "Lost in the Middle" effect is particularly well documented
- Importance of **highly relevant information**

### Five context engineering strategies

- **Generation**: Constructing context with LLM-generated outputs
- **Retrieval**: Bringing information from external sources into context
- **Write**: Saving from context to external storage
- **Reduce**: Compressing and deleting context
- **Isolate**: Separating tasks/tools into distinct environments


### Summary

- AI agents span a wide spectrum, from personal assistants like ChatGPT
  and Claude to customer-facing agents and specialized tools like Claude
  Code and Cursor. All share a common foundation: LLMs as their decision-
  making core.

- An LLM agent consists of three elements: the LLM (brain), tools (means
  of interacting with the external world), and a loop (iterative process until
  goal completion). The LLM decides which tool to use and when to stop.

- Workflows are developer-defined execution flows where LLMs perform
  specific steps. Agents are LLM-directed flows where the model
  dynamically determines its own process. Production systems often
  combine both approaches.

- Use agents when tasks require multiple unpredictable steps, provide
  sufficient value to justify costs, and allow for error detection. The GAIA
  benchmark provides ideal practice problems for agent development.

- Context engineering is the discipline of providing the right information at
  the right time. Five strategies (Generation, Retrieval, Write, Reduce,
  Isolate) form the framework for building effective agents throughout this
  book.
