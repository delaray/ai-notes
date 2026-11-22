
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

---
