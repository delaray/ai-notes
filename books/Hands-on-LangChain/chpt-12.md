# Chapter 12: Agentic Web Search

	pip install ddgs requests beautifulsoup4 langchain-openai
		python-dotenv -q
		

In this chapter we explore the difference between a traditional search-and-scrape  
approach and a modern agentic search workﬂow, using one simple, practical  
example: asking for the weather in San Francisco and whether it’s a good day to  
travel.  

## Regular search and web scraping

Let’s ﬁrst try to solve the weather problem like a basic program might: ﬁnd a  
relevant webpage and scrape it for information.  
  
Step 1 — ﬁnd a relevant URL. We use ddgs (the DuckDuckGo search library) to  
submit a query and get back a list of URLs.  
  
Step 2 — scrape the page. We take the ﬁrst URL, download its HTML with  
requests, and pull the text out of the heading and paragraph tags with Beauti-  
fulSoup.  
  
The output is cleaner than raw HTML, but look closely: it is an unstructured  
block of text, and it is not even about San Francisco’s weather — it’s the National  
Weather Service’s generic national summary. An AI would have to do complex  
natural-language processing just to ﬁnd a temperature, and there isn’t a usable  
one here at all.  


## Agentic Search 

Step 1 — deﬁne the structure we want. This is the key design move. Instead of  
accepting whatever text the web returns, we deﬁne the ﬁelds the agent actually  
needs: location, temperature, conditions, wind, and travel advice.  
  
  
Step 2 — gather context with a free search, then ask the model for a structured  
answer. Notice how much simpler this is than scraping — we aren’t cleaning  
HTML, we’re just asking. The search snippets become raw evidence, and the  
model’s job is to normalize that evidence into the schema.  

![Langraph Agentic Search](images/Hand-on-LC--C12-01--LangGraph-Agentic-Search.png)


## Summary

• LLMs have static knowledge, so real-world tasks need live web information.

• Search-and-scrape (ﬁnd a URL, then parse its HTML) returns unstructured,
  often off-target text and is brittle — it breaks when pages or results change.

• Agentic search returns a structured, machine-readable answer an agent
  can act on directly. Dedicated services (such as Tavily) provide this; the
  same result is achievable with no API key by pairing a free search with the
  LLM’s with_structured_output.

• Humans want a readable page; agents want keys and values.
