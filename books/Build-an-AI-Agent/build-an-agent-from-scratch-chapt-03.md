
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


---
