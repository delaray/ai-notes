# WEEK 3: Reinforcement learning and LLM-powered applications

- Learning Objectives  
  - Describe how RLHF uses human feedback to improve the performance and 
    alignment of large language models  
  - Explain how data gathered from human labelers is used to train a 
    reward model for RLHF  
  - Define chain-of-thought prompting and describe how it can be used to
    improve LLMs reasoning and planning abilities  
  - Discuss the challenges that LLMs face with knowledge cut-offs, and explain how
    information retrieval and augmentation techniques can overcome these challenges  


## Reinforcement Learning from Human Feedback



### Introduction



### Align Models with Human Values


### Reinforcement Learning from Human Feedback

- Instruct FT Model --> RLHF  --> Human-aligned LLM  
- Based on standard RL model
  - Agent: RL Policy = LLM
  - Actions: Token Vocabulary
  - Environment: LLM Context
  - State: Current context
  - Reward: Reward Model

### RLHF: Obtaining Feedback from Humans

- Select nmodel to work with
- Prepare dataset: Prompt Samples
- Collect human feedback on completions
- Human ranks several completions with score 1, 2, etc...
- Use several humans to rank same completions
  - Ensures quality rankings
  - Handles diversity of thought
  - Minimize impact of poor labelers
- Humans provided with detailed instructions
  - Humans can use internet to verify facts
  - Humans are told how top handle ties
  - Humans can select 'F' instead of rank score
    - Allows elimination of bad completions
- Geared towards high quality responses

- Prepare labeled data for training
- Generate n-choose-2 Completion PAIRS 
- Use [0, 1] or [1, 0] on each pair for reward model
- Ranking yields more HF training data than thumbs up/down


### RLHF: Reward Model

- Reward Model Training Data: Pairs of completions
- Completion pair: {preferred, not-preferred}
- Training Reward Model
- Using Reward Model
  - Binary classifier using logits
  - Logits are unormalized model outputs before activation
  - Logits are the reward value
  - Applying Softmax to logits yields probabilities
  - loss = log(sigma(rj - rk))
  - rj is always the preferred completion


### RLHF: Fine-tuning with Reinforcement Learning

- How to use the reward model to updated the LLM weights
- Methodology
  - Start with an Instruct Model
  - Pass a prompt which generates a completion
  - Send the pair to Reward Model
  - Reward Model returns a reward based on its training 
  - Reward is sent to RL Algorithm
  - Model is then updated  
  
- Known as RL-UPDATED LLM
- Iterations continue for a given nummber of epics
- Rewards will increase if the process is working
- Stopping criteria:
  - Based on a particular reward model score
  - Based on fixed number of iterations
- Final model is known as HUMAN-ALIGNED LLM

- RL Algorithm: 
  - Proximal Policy Optimization (PPO)


### RLHF: Proximal Policy Optimization (Optional)

- TODO: Watch video

### RLHF: Reward Hacking

- RLHF: A fine-tuning process that aligns LLM with human preferences  
  
- Agent learns to manipulate system  
  - Artificially maximizes model reward  
    - Learns to generate responses that maximize reward  
  - These can be untrue, hallucinated or nonsenses  
  
- Avoiding reward hacking  
  - Maintain a frozen REFERENCE MODEL  
  - Send prompt to both models  
  - KL Divergence: Kullback-Leibler Divergence  
  - Compute KL Divergence shift penalty  
  - KL divergence measures difference in two probaility distributions  
  - Compute KL divergence SHIFT PENALTY  
  - Shift Penalty is added to the reward  
    
 - Now have 2 full size models  
 - Can apply PEFT strategy.  
   - Reduces memory footprint in 1/2.  
     
- Evaluate the Human-Algned LLM  
  - Evaluate using toxicity score  
  - Toxicity score: Probability of the negative class  
  - Use Validation set to measure toxicity reduction.  
  - Compare toxicity score of the Instruct LLM vs Human-Aligned LLM  
  


### RLHF: KL Divergence

- A library that you can use to train transformer language models with   
  reinforcement learning, using techniques such as PPO, is TRL   
  (Transformer Reinforcement Learning). In this link you can read more   
  about this library, and its integration with PEFT (Parameter-Efficient   
  Fine-Tuning) methods, such as LoRA (Low-Rank Adaption).  
    
    
### RLHF: Scaling Human Feedback

- 10's of thousands human-preference labels  
- Scaling: Area of active research  
  
- Model self-supervision: CONSTITUTIONAL AI  
  - Proposed in 2022 by Anthropic  
  - The Contitution  
    - Set of rules and principles that govern model's behavior  
    - Together with a set of sample prompts  

----

## LLM-Powered Applications

### Model Optimization for Deployment

- Questions about deployment  
  - What cost/compute budget?  
  - What completion speed?  
  - Willing to tradeoff speed/performance/memory?  
    
- Questions about additional resources  
  - External resources  
  - Interact with external data and applications  
  - How to connect to those resources  
    
- Questions about model consumption  
  - What will interface or API look like?  
    
- Model optimization to improve application performance  
  - Optimization/Reduction Techniques  
    - Distillation: Uses Teacher/Student approach  
	- Quantization: Post-training quantization  
	- Pruning: Eliminating low impact parameters  
	  
- Distillation  
  - Train a smaller student model from a larger   
  - Compute Distillation Loss between the models  
  - Distialltion: Probability distribution of the softmax layer tokens  
  - For the Teacher model the distribution is close to the ground truth.  
    - Add a Temperature factor > 1 to increase creativity  
  - Teacher Model Output: SOFT LABELS  
  - Student model Output: SOFT PREDICTIONS  
  - Student Loss: Loss between Soft Predictions & Hard Predictions (ground truth)  
  - Key Benefit: Deploy Student Model  
  - More effective for Encoder-only models such as BERT  
    - Encoder models have a higher degree of redundancy  
  - Not very good for Decoder-only models  
  
- Post-Training Quantization (PTQ)  
  - Transform model weights to lower reepresentation  
  - Requires callibration of the dynamic range  
    
- Pruning  
  - Remove weights close-to or equal to zaro  
  - Pruning methods  
	- Full model re-training  
	- PEFT/LoRA  
	- Post-training  
  - In theory: Reduces model size and improves performance  

### Genrative AI Project Lifecycle

- Pre-Training: Costly, time consuming, high technical skills  
- Preferred Order:  
  - First try: Promp Engineering  
  - Then try: Instruct or PEFT Fine-Tuning  
  - RLHF alignment  

### Using the LLM in applications

- Issues with LLMs  
  - Knowledge is outdated  
  - Cannot carry out numerical operations  
  - Hallucinations  
    
- Retrieval Augmented Generation (RAG)  
  - Useful for LLM to have access to data it has not seen  
  
- Uses a Retriever component  
  - User Query is encoded  
  - External data source is queried  
  - Prompt is augmented with query results  
- RAG Architecture can be used with multiple sources  
- Interact with Web Pages, Databases & Vector stores  
  
- Data Preparation:  
  - Must fit inside the context window  
  - Must be in proper fornmat: Embedding vectors  
    
- Vector Database is a particular implementation of Vector Store  
    
  
### Interacting with external applications

- Can be used to Trigger API call  
- Can be used to perform Calculations  
  
- Requirements for using LLMs to power applications:  
  - Plan Actions: Model need to generate set of instruction  
  - Format Outputs: SQL, etc...  
  - Validate Actions  
    - Collect required information  
	- Ensure it is in the completion  
	  
- Prompt structure is important  
  
### Helping LLMs reason and plan with chain-of-thought

- Chain of Though Prompting  
- Include reasoning steps in few-shot prommpting  
- Can help guide reasoning process  
- Chain of Though Prompting only goes so far  
  

### Program-aided Language Models (PAL)

- LLMs can struggle with mathematics  
- Couple LLM with Python Interpreter  
- Use PAL Formatted prompts & CoT structure  
- Use # for text & Python code for calculations  
- Pass to Python Interpreter  
- Need orchastrater to automate process  
  

### ReAct: Combining Reasoning and Action

- ReAct is a prompting strategy  
  - Combines CoT reasoning with Action planning  
  - Paper: "ReAct: Synergizing Reasoning and..."  
  - Paper Uses HOTPOT QA: Multi-step QA   
    - Includes/Requires multiple wikipedia passages  
  - Paper Uses FEVER: Fact verification  
  - ReAcT Example(s) Methodology  
    - Question  
	- Thought  
	- Action  
	- Observation  
  
- ReAct Instructions  
  - Can only choose from a limited set of actions  
  - Prepends ReAct instructions to define action space  
    
- Building Up the ReAct prompt  
  - Instructions  
  - ReAct example  
  - Question to be Answered  
    
- LangChain Orchestrator  
  - Tools, Prompt Templates & Mememory  
  - the three combined into a "CHAIN"  
  - a number of pre-defined chains  
    
- LangChain also defines Agents  
  - Provides flexibility in choosing next actions  
  - Interpret user input and choose which tool(s) to use  
  - Pre-defined agents for PAL & ReAct  
  - Plan ansd execute sequence of actions  
    
- Use Larger models for techniques like PAL & ReAct  

### ReAct: Reasoning and Action

- Read ReAct Paper  
- ReAct: Synergizing Reasoning and Acting in Language Models  
- https://arxiv.org/abs/2210.03629  
    
  
### LLM Applicationn architectures
  
- Architectre Layers  
  1. Infrastructure: Training/FT, Serving, Application Components  
  2. Information Sources, LLM Models, Generated Outputs & Feedback  
  3. LLM Tools & Frameworks: LangChain, Model Hubs, etc...  
  4. Application Intrerface:   
     - Websites, Mobile Applications, APIs...  
	 - Security componentsd  
	   
- Consumers: Users & Systems  
  
----
  
### Responsible AI



