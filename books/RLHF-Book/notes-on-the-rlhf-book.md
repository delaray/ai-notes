# The RLHF Book (Nathan Lambert)

## --------------------------------------------------------------------
## Chapter 1: 
## --------------------------------------------------------------------


- RLHF Basic Pipeline
  - language model that can follow user questions must be trained
  - human preference data must be collected for the training of a reward model  
    of human preferences  
  - the language model can be optimized with an RL optimizer of choice, by sampling  
    generations and rating them with respect to the reward model  

Post-training can be summarized as a many-stage training process using three optimization methods:

1.**Instruction / Supervised Fine-tuning** (IFT/SFT), where we teach
formatting and form the base of instruction-following abilities. This is
largely about learning features in language.

2. **Preference Fine-tuning** (PreFT), where we align to human preferences
(and get smaller bump in capabilities at the same time). This is largely
about style of language and subtle human preferences that are hard to
quantify.

3. **Reinforcement Learning with Verifiable Rewards** (RLVR). The newest type
of post-training that boosts performance on verifiable domains with more
RL training.

- RLHF lives in and dominates **prefernce fine-tuning**

- RLHF tunes the responses on the response level rather than looking at the next token specifically
- it is telling the model what a better response looks like, rather than a specific response it should learn. 
-RLHF also shows a model which type of response it should avoid, i.e. negative feedback.

- The training to achieve this is often called a contrastive loss function

- Elicitation Theory of Post-training
  - Base models determine the vast majority of the potential of a final model, 
    and post-training’s job is to cultivate all of it
	
- Superficial Alignment Hypothesis
  Paper: "LIMA: Less is More for Alignment"
  
- The first shift in open alignment methods and post-training was the story of
  **Direct Preference Optimization** (DPO)
  
- The primary areas of innovation in post-training are now in **reinforcement learning with
verifiable rewards** (RLVR), reasoning training generally, and related ideas
  
    
## --------------------------------------------------------------------	
## Chapter 2: A Tiny History of RLHF
## --------------------------------------------------------------------


This chapter covers
- The three eras of RLHF’s recent history
- Seminal models and papers that shaped RLHF


### Origins - 2018: RL on Preferences

- Field popularized with growth of Deep Reinforcement Learning

- One of the first papers with an approach similar to modern RLHF was **TAMER**.
  TAMER: Training an Agent Manually via Evaluative Reinforcement proposed an approach
  in which humans iteratively scored an agent’s actions to learn a reward model, which
  was used to learn the action policy [4]. 

- Other concurrent or soon after work proposed an **actor-critic** algorithm,
  **COACH**,  where human feedback (both positive and negative) is used to tune
  the advantage function [5].
  

### 2019 to 2022: RL from Human Preferences on Language Models

Aside from applications, a number of seminal papers defined key areas for the future of
RLHF, including those on:

1. Reward model over-optimization [17]: The ability for RL optimizers to
over-fit to models trained on preference data,

2. Language models as a general area of study for alignment [18],

3. Red teaming [19] – the process of assessing the safety of a language model.


### 2023 to Present: ChatGPT Era

### References

T. Kaufmann, P. Weng, V. Bengs, and E. Hüllermeier, “A survey of reinforcement
learning from human feedback,” Transactions on Machine Learning Research
(TMLR), 2025.


## --------------------------------------------------------------------
## Chapter 3: Trining Overview
## --------------------------------------------------------------------

This chapter covers
- Reinforcement learning basics
- How RLHF relates to traditional RL
- An outline of the RLHF tools you’ll learn in this book
- RLHF training recipes of popular models like InstructGPT and DeepSeek R1

### Problem Overview

The optimization of reinforcement learning from human feedback (RLHF) builds on top of
the standard RL setup.  

In RL, an agent takes actions a sampled from a policy π(a ∣ s ) given the state of the  
environment s to maximize reward r(s , a ) [1].

A policy is a function that maps each state to a probability distribution over actions.   

The early policies that evolved into modern literature on RLHF were in what is called
deep reinforcement learning – when a neural network is used to learn said function.  

Traditionally, the environment evolves according to transition (dynamics)  

    p(s(t+1) ∣ s(t) , a(t)) with an initial state distribution ρ0(s0).

Together, the policy and dynamics induce a trajectory distribution  

Here, τ represents a trajectory—the complete sequence of states, actions, and rewards
experienced by an agent:  

    τ = (s0 , a0 , r0 , s1 , a1 , r1 , … , sT , aT , rT ).
	
	
### Comparing Traditional RL and RLHF

- RLHF, while optimizing a simple loss function, involves:
  - Training multiple, different AI models in sequence
  - Then linking them together in a complex online optimization.
  
- The core objective of RLHF is:
  - Optimizing a proxy reward for human preferences with a distance-based 
    regularizer
  - Showing how it relates to classical RL problems

- Fine-tuning and Regularization
  - In traditional RL problems, the agent must learn from a randomly
    initialized policy
	
  - In RLHF, we start from a strong pretrained model with many capabilities.
    - The goal is not to teach the model language from scratch,
	- The goal is to refine an already capable model toward more
      useful behavior.
	  - This strong prior for RLHF induces a need to prevent the optimization 
	    from drifting too far from the initial policy.
	  - RLHF techniques employ multiple types of regularization to control 
	    the optimization
    - The most common change to the optimization function is to add a distance
	  penalty on the difference between the current RLHF policy and the
	  starting point of the optimization, called the reference policy
	  - Use the Kullback-Leibler divergence, which measures how one probability
        distribution differs from another
	  - Penalizes the RL policy for deviating too far from the reference.
	  
	  
### Optimization Tools

Various techniques for solving this type of optimization problem

- **Reward modeling** (Chapter 5): Where a model is trained to capture the
signal from collected preference data and can then output a scalar reward
indicating the quality of future text.

- **Instruction fine-tuning** (Chapter 4): A prerequisite to RLHF where
  models are taught the question-answer format used in the majority of
  language modeling interactions today by imitating preselected examples.

- **Rejection sampling** (Chapter 9): The most basic RLHF technique where
  candidate completions for instruction fine-tuning are filtered by a reward
  model imitating human preferences.

- **Policy gradients** (Chapter 6): The reinforcement learning algorithms
  used in the seminal examples of RLHF to update parameters of a
  language model with respect to the signal from a reward model.

- **Direct alignment algorithms** (Chapter 8): Algorithms that directly
  optimize a policy from pairwise preference data, rather than learning an
  intermediate reward model to then optimize later.
  
  
### Canonical Training Recipes

#### InstructGPT

- 1. Instruction tuning on ~10K examples
- 2. Training a reward model on ~100K pairwise prompts
- 3. Training the instruction-tuned model with RLHF on another ~100K
  prompts
	
#### Tülu 3

A fully open example of this multi-stage approach to post-training where RLHF plays a
major role is Tülu 3. The Tülu 3 recipe consists of three stages:

1. **Instruction tuning on ~1M examples**: This primarily synthetic data
from a mix of frontier models such as GPT-4o and Llama 3.1 405B
teaches the model general instruction following and serves as the
foundation of a variety of capabilities such as mathematics or coding.

2. **On-policy preference data on ~1M preference pairs**: This stage
substantially boosts the chattiness (e.g. ChatBotArena or AlpacaEval 2) of
the model while also improving skills mentioned above in the instruction
tuning stage.

3. **Reinforcement Learning with Verifiable Rewards on ~10K prompts**:
This stage is a small-scale reinforcement learning run to boost
core skills such as mathematics while maintaining overall performance
(and is now seen as a precursor to modern reasoning models such as
DeepSeek R1).


#### DeepSeek R1

With the rise of reasoning language models, such as OpenAI’s o1, the best practices in post-training evolved again to re-order and redistribute compute across training stages. The clearest documentation of a reasoning model post-training recipe is DeepSeek R1 [11], which has been mirrored by Alibaba’s larger Qwen 3 models (i.e. only the 32B and 225B MoE models) [12] or Xiaomi’s MiMo 7B [13]. The DeepSeek recipe follows:

1. **“Cold-start” of 100K+ on-policy reasoning samples**: This data is
sampled from an earlier RL checkpoint, R1-Zero, and heavily filtered to
instill a specific reasoning process on the model. DeepSeek uses the term
cold-start to describe how RL is learned from little supervised data.

2. **Large-scale reinforcement learning training**: This stage repeatedly
covers reasoning problems with the model, running RLVR “until convergence”
on a variety of benchmarks.

3. **Rejection sampling** on 3/4 reasoning problems and 1/4 general queries
to start the transition to a general-purpose model.

4. **Mixed reinforcement learning training** on reasoning problems
(verifiable rewards) with general preference tuning reward models to
polish the model.


#### Chapter 3 Summary

- In reinforcement learning, an agent takes actions sampled from a policy
  given the current state to maximize cumulative reward – RLHF adapts
  this framework for language models.
  
- RLHF builds on the standard RL setup but with key differences: a learned
  reward model replaces the environment reward function, there are no
  state transitions (prompts are sampled from a dataset), and rewards are
  assigned at the response level rather than per-step.
  
- To prevent the model from drifting too far from its starting point, RLHF
  adds a KL divergence penalty between the current policy and a reference
  policy – colloquially, this optimization distance can be viewed as a budget
  to spend in more complex training setups.
  
- The InstructGPT-era recipe established the canonical three steps:
  1. instruction tuning on 10K examples,
  2. Training a reward model on 100K preference pairs
  3. Optimizing the model with RL on 100K prompts.

- Modern recipes like Tülu 3 involve many more stages and orders of
  magnitude more data, combining instruction tuning, on-policy preference
  data, and reinforcement learning with verifiable rewards (RLVR).


## --------------------------------------------------------------------
## Chapter 4: Instruction Fine-Tuning
## --------------------------------------------------------------------


Key papers in the establishment of instructionn fine-tuning

- Exploring the Limits of Transfer Learning with a Unified Text-to-Text Transformer
  (T5 models)
  
- Finetuned Language Models Are Zero-Shot Learners (FLAN dataset)

- Multitask Prompted Training Enables Zero-Shot Task Generalization (T0 models)

- Cross-Task Generalization via Natural Language Crowdsourcing Instructions
  (Natural Instructions dataset)
  
Generalization becomes far more reliable when the model is explicitly trained on
instruction-response examples


### Chat templates and the structure of instructions

- beginning-of-sequence token
- end-of-sequence token
- padding token

All information passed into models is assigned a role. The traditional three
roles are: **system**, **user**, and **assistant**.

Many chat templates exist icluding OpenAI’s early **Chat Markup Language** (ChatML)
Some other examples include Zephyr’s format or Tülu’s format.

Beyond this, many chat templates include formatting and other tokens for tasks such as
tool-use


### Instruction Fine-Tuning Best Practices

A few principles remain

- High-quality data is key to performance. The completions are what the
model actually learns from (in many cases the prompts are not predicted
over so the model does not learn to predict prompts).

- Around 1M prompts can be used to create a model capable of excellent
RLHF and post-training. Further scaling can still help, but returns diminish
quickly.

- The best prompts are those in a similar distribution to downstream tasks
of interest.

- If multiple stages of training are done after instruction tuning, the models
can recover from some noise in the process. Optimizing the overall
optimization is more important than each individual stage.



### Instruction Fine-Tuning Implementation

While the loss function is the same as pretraining, there are a few key implementation  
details that differ from the setting used for pretraining.  

- **Smaller batch sizes**
- **Prompt masking**
- **Multi-turn masking**
- **Same loss function as pretraining**


### Chapter 4 Summary

- **Instruction fine-tuning** (IFT/SFT) teaches pretrained language models to  
respond in an instruction-response format, and is the foundation that all  
later post-training stages – from preference data collection to RLHF  
optimization – depend on.  

- **Chat templates** define how user queries, system prompts, and assistant  
responses are formatted into token sequences using special tokens, and  
are the standard interface between users and instruction-tuned models.  

**Implementation details** include smaller batch sizes than pretraining,  
prompt masking so the model learns responses rather than queries, and  
multi-turn masking strategies that control which assistant turns are  
trained on.  



## --------------------------------------------------------------------
## Chapter 5: Reweard Modeling
## --------------------------------------------------------------------

This chapter covers  
- How language models are trained to predict human preferences  
- How to implement reward models in PyTorch  
- The different varieties of reward models used today  

### The Basics

- Reward models are where the complex human preferences are learned  
- In RLHF that reward models output a probability that an a input is “of high quality  
- The practice of reward modeling for RLHF is closely related to inverse reinforcement learning  

- The reward model in RLHF plays the role of the environment component that returns rewards in standard RL.  
- The key difference is that in RLHF, we get to control and learn this reward function from human preferences, rather than having it fixed by the environment.  


### Training Reward Models

- **Bradley-Terry** model of preference
- A Bradley-Terry model of preferences defines the probability that,
- In a pairwise comparison between two items i and j, a judge prefers i over j  

    P(i > j) = pi / (pi + pj)
	
- Training a preference reward model requires pairs of chosen and rejected completions.  
- The model computes a scalar score at the end-of-sequence (EOS) token for each.  
- The contrastive loss depends only on the score difference between the two.


### Training Reward Models


### Outcome Reward Models

- The majority of preference tuning for language models and other AI systems is done with
the **Bradley Terry** models discussed above.  

- For reasoning heavy tasks, one can use an **Outcome Reward Model** (ORM). The training data for an ORM is constructed in a similar manner to standard preference tuning  

The important intuition here is that an ORM will output a probability of correctness at every
token in the sequence. This can be a noisy process, as the updates and loss propagates per
token depending on outcomes and attention mappings.  


### Process Reward Models

- **Process Reward Models** (PRMs), originally called process-supervised reward models, are
reward models trained to output scores at every step in a chain-of-thought reasoning
process.  

- These differ from a standard RM that outputs a score only at an EOS token or an
ORM that outputs a score at every token.  

- Process Reward Models require supervision at the end of each reasoning step, and then are trained similarly where the tokens in the step are trained to their relevant target – the target is the step in PRMs and the entire response for ORMs.  


### Inference Differences

The models handle data differently at inference time (once they’ve been trained), in order
to handle a suite of tasks that RMs are used for.


**BRADLEY-TERRY RM** (PREFERENCE MODEL):
Input: prompt x + candidate completion y
	Output: single scalar r (x, y) from EOS hidden state
	Usage: rerank k completions, pick top-1 (best-of-N sampling); or provide 0 terminal
	       reward for RLHF
	Aggregation: Not needed with scalar outputs


**OUTCOME RM**:
	Input: prompt x + completion y
	Output: per-token probabilities p ≈ P (correct at token t) over completion tokens
	Usage: score finished candidates; aggregate via mean, min (tail risk), or
	product ∑ log p
	Aggregation choices: mean correctness, minimum p , average over last m
	tokens, or threshold flagging if any p < τ


**PROCESS RM**:
	Input: prompt x + reasoning trace with step boundaries
	Output: scores at step boundaries (e.g., class logits for
	correct/neutral/incorrect)
	Usage: score completed chain-of-thought; or guide search/decoding by
	pruning low-scoring branches
	Aggregation: over steps (not tokens) – mean step score, minimum (fail-
	fast), or weighted sum favoring later steps


**VALUE FUNCTION**:
	Input: prompt x + current prefix y (a state)
	Output: Vt at each token position in the completion (expected remaining
	         return from state t)
	Usage: compute per-token advantages A = R- V during RL training;
	       the values at each step serve as baselines
	Aggregation: typically take V at the last generated token; interpretation
	             differs from “probability of correctness”


The way to understand the different models is:

- **RM**: “How good is this whole answer?” → scalar value
- **ORM**: “Which parts look correct?” → per-token correctness
- **PRM**: “Are the reasoning steps sound?” → per-step scores
- **Value**: “How much reward remains from here?” → baseline for RL advantages


### Generative Reward Modeling

- With the cost of preference data, a large research area emerged to use existing language
models as a judge of human preferences.  

- The core idea is to prompt a language model with instructions on how to judge, a prompt, and two completions (much as would be done with human labelers)  


### Reward Modeling Benchmarks

New benchmarks include:

- **Text-only (general chat / preferences)**: 
  - RMB [25], RewardBench2 [26], Preference Proxy Evaluations [27], or RM-Bench [28].

- **Specialized text-only** (math, etc.):
  - multilingual reward bench (M-RewardBench) [29], RAG-RewardBench for retrieval augmented
  - generation (RAG) [30], ReWordBench for typos [31], RewardMATH [32],
  - AceMath-RewardBench [33].
  
- **Process RMs**:
  - PRM Bench [34] or ProcessBench [35]
  - visual benchmarks of VisualProcessBench [36] or ViLBench [37].
  
- **Agentic RMs**:
  - Agent-RewardBench [38] or CUARewardBench [39].

- **Multimodal**:
  - MJ-Bench [40],
  - Multimodal RewardBench [41],
  - VLRewardBench [42],
  - VLRMBench [43].
  

### Summary

- Reward models are the component of RLHF that learns to represent
human preferences – they compress complex, hard-to-specify human
judgments into a scalar signal that downstream optimization can act on.  

- The standard reward model for RLHF is derived from the Bradley-Terry
model of preferences, trained with a contrastive loss to predict the
probability that one completion is preferred over another.  

- Beyond preference reward models, two popular variants for reasoning
tasks include outcome reward models (ORMs) that predict per-token
correctness in a response and process reward models (PRMs) that score
individual reasoning steps.  

- Reward models are typically implemented by appending a linear head to a
pretrained language model (e.g., via AutoModelForSequenceClassification),
outputting a single scalar score per sequence. Value functions, covered
in the RL chapter, share a similar architecture but differ in what they 
predict and how they are trained.  
  
    
## --------------------------------------------------------------------
## Chapter 6: Reinforcement Learning
## --------------------------------------------------------------------

This chapter covers

- How reinforcement learning is used to optimize human preferences  
- Mathematics and intuitions for policy-gradient algorithms  
- The derivations and trade-offs of different algorithms  
- New algorithms for reasoning models, such as GRPO, GSPO, and CISPO  
- Implementation details of modern RLHF stacks  


### Overview

RLHF Training Loop Overview:

In the RLHF process, the reinforcement learning algorithm slowly updates the model’s
weights with respect to feedback from a reward model.

- The **policy** – the model being trained – generates completions to prompts in the training set,
- then the **reward model** scores them
- then the **reinforcement learning optimizer** takes gradient steps based on this information

DRL Methods
- Value-based: Learn value functionm (Q or V)
- Policy-gradient: directly optimize a parameterized policy Pi(theta)
- These methods often overlap 
  - actor-critic methods, for instance, use value estimates to reduce variance in policy gradients
  
The algorithms typically used in RLHF are policy gradient ones:
- Proximal Policy Optimization (PPO)
- Group Relative Policy Optimization (GRPO)
- REINFORCE

### Policy Gradient Algorithms

- Reinforcement learning algorithms are designed to maximize the future, discounted reward
across a trajectory of states

- The objective of the agent, often called the **return**, discounted future rewards, is the sum of
discounted future rewards at a given time t.

- The discount factor γ ∈ [0, 1] determines the balance between short and long-term rewards.

- This return is the basis for learning a value function V (s)

- The objective sums over every discrete state, weighting each state’s value by how often
  the policy visits that state
  - In MDP the sum is over all states
  - In practice estimate it from data by sampling rollouts from the current policy.

- A rollout, or trajectory τ = (s , a , s , a , …), is a sequence of states and actions sampled
  by the policy.
  
- In RLHF, this typically means sampling prompts x from a dataset and generating completions

- Trajectories are saequences of states and actions
- Each token generation is an action, and the sequence so far is the state.

- The core of policy gradient algorithms is computing the gradient with respect to the finite-
  time expected return over the current policy
- The core implementation detail is how to compute said gradient.

  
### REINFORCE

The name is an acronym for:
- “REward Increment = Nonnegative Factor X Offset Reinforcement X Characteristic Eligibility.”

The three components of this are how to do the reward increment, a.k.a. the policy
gradient step.

It has three pieces to the update rule:

1.**Nonnegative factor**:
  - This is the learning rate (step size) that must be a positive number alpha
  
2.**Offset Reinforcement**:
  - This is a baseline b or other normalizing factor of the reward to improve stability.
  
3.**Characteristic Eligibility**: 
  - This is how the learning becomes attributed per token. It can be a general value,
    e per parameter, but is often log probabilities of the policy in modern equations.
	
REINFORCE is a specific implementation of vanilla policy gradient that uses a Monte Carlo
estimator of the gradient.


### REINFORCE Leave One Out (RLOO)

- The core implementation detail of REINFORCE Leave One Out versus standard REINFORCE
  is that it takes the average reward of the other samples in the batch to compute the
  baseline – rather than averaging over all rewards in the batch  

- This is a simple, low-variance per-prompt advantage estimate that is closely related to the
  group-relative advantage used in Group Relative Policy Optimization, GRPO (discussed
  shortly, after Proximal Policy Optimization, PPO)  
  
  
### Proximal Policy Optimization (PPO)

### Group Relative Policy Optimization (GRPO)

### Group Sequence Policy Optimization (GSPO)

### Clipped Importance Sampling Policy Optimization (CISPO)

### Comparing Algorithms


