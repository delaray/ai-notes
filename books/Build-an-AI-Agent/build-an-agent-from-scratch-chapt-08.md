
## Chapter 8: Empowering Agents with Code Execution

### This chapter covers

- Understanding the limitations of predefined tool approaches and the
  benefits  of code execution
- Connecting code-execution environments to agents
- Porting tools to sandboxes for efficient execution
- Providing complete workspaces with filesystems and the CLI
- Using agent skills for hierarchical tool management
  
  
### Summary

- The predefined-tool approach has three limitations: the agent’s action space 
  is restricted to the developer-defined tool list; executing one tool per
  LLM call is inefficient; and as tools proliferate, prompt token costs
  increase while the LLM’s tool-selection accuracy decreases.

- Code execution provides three core capabilities: control flow through 
  conditionals and loops, data flow by storing intermediate results in
  variables, and tool composition by combining small functions to create
  new functionality.

- Sandboxes are isolated environments for executing LLM-generated code safely.
  They provide host-system security protection, resource management for CPU
  and memory, and recoverability when problems occur.

- Tool composition can be implemented by extracting the source code of
  user-defined tools and registering them in the sandbox. This approach 
  maximizes token efficiency in processing large amounts of data when you
  need only aggregation or summaries.

- A workspace is a complete working environment that combines code execution,
  a filesystem, and a CLI. Just as human developers write code, save files,
  and execute commands in the terminal, agents can work in the same environment.

- Agent skills is an approach that progressively discloses tool information.
  Only skill names and one-line descriptions are included in the prompt;
  actual use is learned when the LLM determines that a skill is required
  and reads the SKILL.md file.

- Agent tools can be divided into three layers: core tools, which are always
  included in the prompt (execute_python, bash_tool, and upload_file);
  installable tools, which have only summaries in the prompt and detailed
  definitions in the filesystem (agent skills); and generated tools, for which
  the LLM writes code on thespot as needed.

- The essence of the hierarchical tool structure is to offload tool definitions
  from the prompt to a workspace. From a context-engineering perspective,
  the workspace is a powerful method for removing tool information and
  tool-execution results that don’t require LLM judgment from the context.
  
---
