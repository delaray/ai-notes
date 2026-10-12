# Build an AI Agent (From Scratch) 

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
  - Coding agents can navigate codebases, add features, fix bugs, and refactor code
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


## Chapter 2: The Brain of AI Agents: LLMs

### This chapter covers

- Selecting the right LLM for agent development
- Using LLM APIs with LiteLLM
- Prompt engineering for agents
- Experiencing LLM limitations through the GAIA benchmark


### Choosing LLMs for agents

LLM choice impacts performance, cost, and development speed.

Open LLMs: Meta's Llama, Mistral AI's Mistral, Alibaba's Qwen and DeepSeek
Closed LLMs: OpenAI's GPT, Anthropic's Claude, and Google's Gemini

#### Starting with closed LLMs

- RAPID EXPERIMENTATION AND VALIDATION
- WHEN YOU NEED TOP PERFORMANCE
- PRODUCTION-READY FEATURES

- Closed LLM providers offer essential features for agents
  - Tool Calling
  - Structured Output
  - Cost Optimization

#### Expanding to open LLMs

Benefits
- COST OPTIMIZATION
- STABILITY AND CONTROL
- A REALISTIC APPROACH

Transition gradually
1. Validate your agent's design and behavior with Closed LLMs
2. Port the same design to Open LLMs
3 Test whether performance degradation falls within acceptable bounds

Hybrid configuation
- Closed LLMs for core reasoning
- Open LLMs for simple tasks

#### Essential LLM capabilities for agents

- TOOL CALLING (FUNCTION CALLING)
- STRUCTURED OUTPUT
- LONG CONTEXT SUPPORT
- DESIGNING FOR MODEL AGILITY IN A RAPIDLY CHANGING LANDSCAPE

Staying Informed of Changing Landscape

- Artificial Analysis 
  - https://artificialanalysis.​ai
  - Comprehensive comparison of quality, speed, and cost
  
- LMArena Leaderboard
  - https://lmarena.​ai/leaderboard
  
  - User preference rankings based on real interactions
- Official announcements from providers:
  - New model releases
  - Pricing updates
  
  
### LLM API basics for building agents

All code examples are available on GitHub:
- https://github.​com/shangrilar/​ai-agent-​from-scratch

- Clone the repo
- cd into directory

    uv sync
    uv run jupyter lab
	
- Can use LiteLLM to switch between providers using the same chat completion format
- OpenAI & Anthropic differ in syntax and method names
- LiteLLM uses a single *completion* function for both APIs

- Conversation management: Handling stateless APIs
  - LLM APIs are stateless.
  - Can accumulate all responses and submit as context
    - Inefficient
	- Expensive
	- Slow
- Efficient context length management techniques are needed

- Structured Output
  - Use Pydantic & response_format
  
- Use Asyncio & semaphores to manage simulateous LLM calls
- LiteLLM has an *acompletion* functtion for asyncronous LLM calls

  
### Enhancing agent intelligence: Prompt engineering

Two main categories of prompts:

- **User prompts** are messages that users type into the chat interface

- **System prompts** are developer-defined instructions that persist throughout 
  the conversation, setting the agent's personality, permissions, constraints,
  and tool usage policies


#### System Prompts

- System prompts are particularly important for agents.
- Agents act autonomously across multiple steps.
- System prompts define the behavioral rules that guide all of these decisions
- From a context engineering perspective, the system prompt is information that is always
  included in the context

- Anthropic publishes Claude's system prompts
  - https://docs.​anthropic.​com/en/release-​notes/system-​prompts 
  
- Claude's system prompt serves four main roles:
  1. defining the product's identity,
  2. specifying output format and style,
  3. setting boundaries on prohibited behaviors,
  4. clarifying the limits of its knowledge.


DEFINING PRODUCT IDENTITY
SPECIFYING OUTPUT FORMAT AND STYLE
SETTING BEHAVIORAL BOUNDARIES
CLARIFYING KNOWLEDGE LIMITS

#### Guidelines for agent prompts

- Guidelines are different for agent than for a chatbot

ACTING AUTONOMOUSLY

USING TOOLS STRATEGICALLY
  - Setting the default attitude
  - Defining trigger patterns
  - Specifying negative guides
  - Anchoring with examples
  
TOOL INFORMATION IS ALSO PART OF THE PROMPT


### Experiencing LLM limitations with GAIA 

#### Why GAIA? Setting goals for agent development

- Have clear, verifiable answers (so we can measure accuracy objectively)
- Represent realistic user requests 
  - So improvements translate to real-world value
- Cover a range of difficulty levels  
  - So we can track progress as we add capabilities
  
GAIA: General AI Assistants
- Ideal benchmark for practicing agent development

THINKING OF GAIA AS SIMULATED USER INPUTS

LOADING THE GAIA DATASET
- https://huggingface.​co/datasets/​gaia-benchmark/​GAIA
- load_dataset("gaia-benchmark/GAIA", "2023_level1", split="validation")

- GAIA problems are categorized into three difficulty levels
  - Level 1
    - Generally require no tools,
	- At most one tool, with no more than 5 steps.
  - Level 2
    - Roughly between 5 and 10 steps
	- Combining different tools is needed
  - Level 3
    - A near-perfect general assistant, 
	- Requiring arbitrarily long sequences of actions,
	- Any number of tools
	- Access to the world in general
	
UNDERSTANDING THE PROBLEM STRUCTURE

Fileds
- Question
- Final answer
- file_name
- Metadata

#### Experiment setup

Need to:
- define the response format
- create an API calling function with proper error handling,
- select models to test
- establish how we'll judge correctness.


DEFINING THE RESPONSE FORMAT

use Structured Output

    class GaiaOutput(BaseModel)
        is_solvable: bool
        unsolvable_reason: str = ""
        final_answer: str = ""
	
BUILDING THE EVALUATION PIPELINE

    async def solve_problem(model: str, question: str) -> GaiaOutput
    def is_correct(prediction: str | None, answer: str) -> bool
    async def evaluate_gaia_single(problem: dict, model: str) -> dict
    async def run_experiment(problems: list[dict], models: list[str]) 
	
#### Results and analysis: Why LLMs need tools

ONLY FIVE PROBLEMS ARE TRULY SOLVABLE WITHOUT TOOLS
  - Only 5 of the 20 Level1 problems can actually be solved without external tools
MODELS VARY IN SELF-ASSESSMENT ACCURACY
MODEL REFUSALS

#### KEY TAKEAWAYS

This experiment reveals three critical insights for agent development:
- LMs have reasonable self-awareness of their limitations. When properly prompted,
  models can often identify when they cannot solve a problem.
- Training data is not a substitute for tools. Even when models "know" information
  from training, this knowledge is unreliable for precise, current, or verifiable answers.
- Most real-world questions require external capabilities. 

### Summary

When starting agent development, Closed LLMs offer practical
advantages: out-of-the-box features like tool calling and structured
output, stable APIs that let developers focus on agent logic, and top-tier
performance for complex reasoning tasks. Open LLMs become relevant
later for cost optimization.

LiteLLM provides a unified interface across providers, enabling model
flexibility in a rapidly evolving landscape. Key API patterns include
conversation management, structured output with Pydantic, and
asynchronous calls with rate limiting.

System prompts define agent behavior: product identity, output format,
behavioral boundaries, and knowledge limits. For agents, prompts should
emphasize autonomous action and strategic tool use rather than asking
for permission.

GAIA benchmark reveals that even capable LLMs solve only 25% of
"easy" problems without tools. 75% of problems require external
capabilities like web search and file reading—motivating Chapter 3's focus
on tools.

Models show reasonable self-awareness of limitations when properly
prompted, but training data knowledge is unreliable for precise, current,
or verifiable answers. Agents need tools to access authoritative sources.


## Chapter 3: Enabling actions: Tool use

### This chapter covers

- LLM limitations and why they need tools
- Tool calling and execution
- Building and integrating custom tools
- MCP for tool standardization


### LLM Tools

- Temporal limitations
- Interaction limitations
- Functional Limitations

- Custom Built by developer
- Preddefined by LLM provider

- Importance of custom tools
  - Understanding how tools work internally is essential for debugging agent failures.
  - Real-world agents often require specialized capabilities that providers don’t offer.


#### How Tool Calling Works

- A multistep process
  Step 1: Developer sends a message (user input) to the LLM, along with
  tool definitions
  
  Step 2: Set up the tool. Define a Python function to match the input
  schema provided earlier
  
  Step 3: Executing the tool calling
  The LLM receives the tool definitions and the user’s input. the LLM responds
  by generating a tool call, including the correct operator and operands.
  
  Step 4: Running the tool
  This step executes the tool that the LLM requested. Because the LLM itself
  can’t run any code, we, as the host system, must perform the execution.
  
  Step 5: Feeding results back to the LLM
  Finally, we feed the tool result back into the LLM by appending a new message
  to the conversation with a role of "tool" and including the output in the content.


#### How an LLM chooses tools

- During training, LLMs are exposed to datasets containing tool definitions paired
  with appropriate tool calls.
  
- The model develops the ability to do the following:
  1. Recognize when a tool is needed based on the user’s request
  2. Select the appropriate tool from the available options
  3. Extract the correct parameter values from the user’s input
  4. Format the tool call in the expected structure


#### Guidelines for effective tool calling

- Clear and explicit function definitions
- Applying software engineering best practices
- Reducing model load and using code effectively
- Limiting the number of functions
- Handling errors gracefully

### Building tools and tool definitions for LLMs

- Implementing a web search tool
  - https://www.tavily.com/
  - TAVILY_API_KEY
  - Define a search_web function
    - Create a Tavily client (in Python)
    - response = tavily_client.search(<query>)
	- return response.get("results")
  
#### Converting to tool definitions

- To generate a tool definition from a function, we extract
  - the function’s name,
  - the function' doc-string
  - the function's parameter details.
  
- Extracting parameters in Python is done by using the inspect module.


#### End-to-end tool execution
- Building the tool execution system
- Build a control loop to manage the interaction between the LLM and tools

- Simple agent loop for tool execution. What happens in this loop:
  1. The LLM receives the system prompt, user question, and available tool
	 definitions.
  2. If the LLM determines that it needs external information, it generates a tool call.
  3. We append the assistant’s message (which contains the tool call) to the
     conversation history.
  4. We execute the requested tool and append the result as a “tool” message.
  5. The loop continues, sending the updated conversation back to the LLM.
  6. When the LLM has enough information to answer, it returns a response without
	 tool calls, and we exit the loop.
	

#### The challenges of custom tools
- Understanding unfamiliar APIs
- Handling errors robustly
- Duplicating efforts across teams
- Carrying the ongoing burden of maintenance


### MCP: Standardizing tools

#### The core of MCP: Server–client architecture
- **Host**
  The host is the application that interacts with users and makes decisions
  using an LLM
- **Client**
  The MCP client acts as a bridge between the host and the MCP servers
- **Server**
  The MCP server hosts the tools and executes them on demand
  Responds to two types of requests
  - “What tools do you have?”
  - “Execute this tool with these arguments”
  
#### MCP’s scope beyond tools
  
MCP defines three types of capabilities that servers can provide:
- Tools (functions the LLM can call),
- Prompts (reusable prompt templates),
- Resources (data the LLM can access).


#### Two standardized interfaces

- Tool discovery
- Tool execution


#### Transport mechanisms

- MCP defines two standard transport mechanisms for client/server communication:
  - Stdio (standard I/O): This approach is the simplest one.
  - Streamable HTTP: This approach enables remote communication over the network


#### Hands-on: Running an MCP server

- Running the Tavily MCP server
  npx @modelcontextprotocol/inspector npx -y tavily-mcp@latest
  
- Exploring the server with MCP Inspector
  - tavily_search: Provides web search functionality
  - tavily_extract: Extracts content from specific URLs
  - tavily_crawl: Crawls websites and extracts structured data
  - tavily_map: Generates site maps
  
#### Understanding the MCP client
- Connecting to an MCP server
  uv add mcp
- Converting MCP tools for LLM use


#### Hands-on: Implementing an MCP server
- building an MCP server is surprisingly simple
  - Use the FastMCP library
  - Convert an existing function to an MCP-compatible tool
  - Do this by adding the mcp.tool decorator.  
  
- Building the server

1. mcp = FastMCP("custom-tavily-search")
2. @mcp.tool()
   *function definition*
3. mcp.run

- Connecting with the client
  The only change needed is updating StdioServerParameters to point
  to our custom server instead of the official Tavily package


### Summary

- Tools extend LLM capabilities, enabling them to access APIs, perform
calculations, and retrieve external information. Tools fall into three
categories: information-augmenting, action-executing, and domain-
specialized.

- Tool calling is the mechanism by which LLMs generate structured outputs
specifying which tool to use and with what parameters. The LLM acts as a
mediator between user requests and available tools, but does not execute
tools itself.

- Tool execution is handled externally. The LLM generates specifications
that a separate system executes, with results fed back into the LLM's
context for further reasoning.

- Tool definitions are structured schemas that describe available tools, their
parameters, and expected outputs. Clear and explicit definitions are
essential for reliable tool selection by the LLM.

- Building custom tools involves implementing the tool function, creating
tool definitions, and building execution infrastructure. While
straightforward for simple cases, custom tools create a maintenance
burden and inconsistency as projects scale.

- MCP (Model Context Protocol) standardizes tool development through a
server-client architecture. Servers host and execute tools, while clients
discover and invoke them. This separation enables tool reuse across
projects and providers.


#------------------------------------------------------------------

## Chapter 4: Implementing a basic ReAct agent


### This chapter covers
- ReAct, the core pattern behind modern AI agents
- Managing agent state with ExecutionContext
- Unifying local functions and MCP tools
- Building the LLM communication layer
- Implementing a ToolCallingAgent with the think-act loop
- Adding structured output with Pydantic models
- Testing agent performance on the GAIA benchmark


### How ReAct agents work

- **ReAct**: Reasoning plus Acting
- Foundational pattern behind most modern AI agents. 
- Instead of trying to answer everything at once,
  - An agent alternates between
	- Reasoning about what it needs
	- Taking actions to get it.

#### The think-act cycle

- Thought
- Action
- Observation
- Repeat


#### From text parsing to tool calling

- Early ReAct implementations relied entirely on text parsing
- The agent had to output responses in an exact format
- Any deviation would break the system

- Tool calling eliminates this fragility
- The LLM generates structured outputs
- These specify which tool to call and arguments to use.
- The format is guaranteed by the API,


### Agent architecture overview


#### The completed agent

agent = Agent(
	model=LlmClient(model="gpt-5-mini"),
	tools=[calculator, search_web]w,
	instructions="You are a helpful assistant"
)
result = await agent.run("What is 1234 * 5678?")


#### Information flow: The core design

**WHY MESSAGES ALONE AREN'T ENOUGH**

- Need to track:

  events: The history of all interactions, including user messages, LLM responses,
          and tool-execution results
  current_step: A counter that prevents infinite loops (what if the agent keeps
               calling tools forever?)
  execution_id: A unique identifier for debugging and logging (which execution
                produced this error?)
  state: A scratch pad for dynamic data during execution, such as task progress,
         intermediate results, or user preferences that tools may need
  final_result: A flag that indicates when execution is complete


**THE EXECUTIONCONTEXT-CENTERED DESIGN**

ExecutionContext serves as the central storage where all information converges. When
the agent needs to call the LLM, it extracts relevant information from Execution­
Context into an LlmRequest. When the LLM responds, the response flows back into
ExecutionContext. When tools execute, the agent passes ExecutionContext to them so
that they can access any execution state they need, and their results are recorded back
in ExecutionContext.

- The architecture provides two key benfits
  - Every method receives only the context.
  - Enables context propagation


#### Components we need to build
- ExcutionContext
- Tool Abstraction
- LLM Communication Layer
- The Agent


### ExecutionContext: The Agent's Central Storage

- Avoids scattering state across multiple variables
- Simplifies how components share information

#### What happens during agent execution?

- Messages
- Tool Calls
- Tool Results

Define **Message**, **ToolCall** & **ToolResult** classes

**ContentItem** = Union[Message, ToolCall, ToolResult]


#### Implementing ExecutionContext

Fields in an Event (A recorded occurrence during agent execution):

	id: str
	execution_id: str (Unique identifier for this execution session
	timest5amp: float
	author: "user" or agent name
	content: List[ContentItem]

Fields in an ExecutionContext instance:

	execution_id: Unique identifier for this execution session, 
		          generated automatically
	events: Chronological list of all events that occur during execution
	current_step: Counter to prevent infinite loops (agent stops after max_steps)
	state: Flexible key-value store for custom data that tools may need, such as API
	
Configurations or intermediate results
	final_result: Holds the agent’s answer when execution completes


### Tool abstraction 

#### Why we need a unified tool interface
- Previously tool function and its metadata exist as separate entities
- With tool abstraction, everything stays bundled together
- @tool decorator


#### BaseTool: The foundation

- Must have three essential properties:
- a **name** for identification
- a **description** explaining its purpose, 
- a **tool_definition** schema that tells the LLM how to use it.

- Use **@property** for def tool_definition... method
- Use **@abstractmethod** for async def execute... method

#### FunctionTool: Wrapping functions

- Wraps BaseTool with additional fields:
  - func: Callable,
  - needs_context
- execute method distringuishes if needs context or not
- Use **@tool** decorator to create FunctionTool Instances


#### Integrating MCP Tools


### LLM Communication layer

#### Reasons for Adding a Communication Layer

- Provides a translation between ExecutionContext and LLM APIs.
- Bridges the gap between our internal data structures and the LLM’s API requirements.
- The solution involves three components working together:

**LlmRequest**: Packages what we want to send: instructions, conversation contents,
	and available tools. It serves as a staging area where we select and organize
	information before the API call.
	
**LlmClient**: Handles the API communication. It transforms LlmRequest into the
	format that LLM APIs expect, makes the call, and converts the response back.
	
**LlmResponse**: Standardizes what we receive. Regardless of which provider we
	use, responses come back in the same format that our agent can process.


#### LlmRequest: Selecting what to send

class **LlmRequest**(BaseModel):

	Request object for LLM calls.
	**instructions**: list(str)
	**contents**: list[ContentItem]
	**tools**: list[BaseTool]
	**tool_choice**: Optional[str]


#### LlmResponse: Standardizing what we receive

class **LlmResponse**(BaseModel):

	Response object from LLM calls.
	**content**: list[ContentItem]
	**error_message**: Optional[str]
	**udage_metadata**: dict[str]


#### LlmClient: The provider adapter

class **LlmClient**:

	Client for LLM API calls using LiteLLM.	
	def **__init__**(self, model: str, **config):
	async def generate(self, request: LlmRequest) -> LlmResponse:

The generate method orchestrates the API call in three steps:

	1. It builds the messages list from the request.
	2. It extracts tool definitions with a simple list comprehension.
	3. It calls LiteLLM’s acompletion and parses the response.
	   If anything fails, it returns an LlmResponse with the error captured
	   rather than crashing.
	   
	   
**BUILDING MESSAGES**

- The **_build_messages** method transforms **LlmRequest** contents into the message format
that LLM APIs expect.
- The logic handles each ContentItem type differently.


**PARSING RESPONSES**
- The **_parse_response** method converts API responses back to our standard format.
- Handles both **TextResponses** and **ToolCalls.**


#### Putting it together

1. Create client
2. Build request
3. Generate response
4. Response contains the answer


### Implementing the Agent

We’ll implement these five methods in logical order:
1 **_setup_tools()**: Registers the tools the agent will use, converting the list to a
	dictionary for efficient lookup

2 **run()**: The entry point; receives user requests, manages the execution loop, and
	returns the final result
	
3 **step()**: Performs one complete think–act cycle, updating ExecutionContext
	with each interaction
	
4 **think()**: Calls the LLM to analyze the situation and decide the next action

5 **act()**: Executes the tools selected by the LLM and captures their results


#### Agent class structure

The parameters serve distinct purposes:
	
	model: The LlmClient instance that handles LLM communication
	tools: List of BaseTool instances the agent can use
	instructions: System prompt that defines the agent’s behavior
	max_steps: Safety limit to prevent infinite loops when the agent keeps calling
		tools without reaching a conclusion

#### The run() Method

#### The step() method

#### The think() and act() methods


### Adding structured output

#### The approach: Tools as output formatters

#### Modifying the agent

#### Using structured output in practice


## Building knowledge bases with RAG

### This chapter covers

- Understanding why agents need external knowledge bases
- Using keyword, vector, graph, and structure-based search methods
- Implementing vector search from scratch with embeddings,
  chunking, and similarity calculations
- Building structure-based search tools for filesystem exploration
- Extending agent capabilities through the callback pattern


