
## Chapter 7: Planning and Reflection for Complex Tasks

### This chapter covers

- The limitations of reactive agents in performing complex tasks
- Planning tools that decompose problems into task lists
- Reflection tools that enable progress checking and failure recovery
- The complementary cycle of planning and reflection
  

### Planning: Setting direction

#### When planning is necessary

#### Implementing the planning tool

#### Planning-tool example

#### Extension directions


### Reflection: Checking and correcting

#### When reflection is necessary

#### Implementing the reflection tool

#### The real value of reflection: Failure recovery

#### Running an agent that uses reflection for research synthesis


### Integrating Planning and Reflection

Planning solves mainly “looking ahead” problems
Reflection solves “looking back” problems.

### Summary

- Planning and reflection give agents time to think. Instead of reacting moment by
moment, agents plan before acting and check after acting. This grants metacog-
nition: the ability to examine their own process.

- Planning decomposes complex problems into clear, manageable units. When
“1. Research Kipchoge’s record, 2. Research Moon distance, 3. Calculate time”
is recorded in the context, the LLM references this plan to maintain direction
across multiple steps.

- Reflection is valuable when problems arise, not when everything goes smoothly.
When tools fail or results are unexpected, reflection enables cause analysis and
alternative strategies instead of repeating the same failures.

- Planning and reflection form a complementary cycle. Planning provides direc-
tion; reflection checks that direction and, when necessary, triggers replanning.
Neither works in isolation.

- From a context-engineering perspective, both strategies are Generation strat-
egies. Planning adds “what to do next” to the context, while reflection adds
“evaluation and direction so far.” These texts influence the LLM’s subsequent
decisions.

---
