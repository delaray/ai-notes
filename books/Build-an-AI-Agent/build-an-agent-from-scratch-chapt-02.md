
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

