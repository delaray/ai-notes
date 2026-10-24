# Advanced Kubernetes: Security and Large-Scale Deployments

## Module 1: Managing Kubernetes Resources

### Introduction to the Course

### Full Specialization Resources

![Resource Management](images/advanced-kubernetes--M1-01-resource-management)

### Introduction to the Section

### Understanding Labels and Selectors

![Labels and Selectors 1](images/advanced-kubernetes--M1-02-labels-and-selectors-1)

![Labels and Selectors 2](images/advanced-kubernetes--M1-02-labels-and-selectors-2)

### Lab: Using Labels and Selectors in Kubectl

	kubectl get pods -L app -L tier
	
	NAME             READY   STATUS    RESTARTS   AGE   APP         TIER
	color-backend    1/1     Running   0          91s   color-api   backend
	color-frontend   1/1     Running   0          91s   color-api   frontend

	kubectl get pod -l tier=frontend -L tier
	
	NAME             READY   STATUS    RESTARTS   AGE     TIER
	color-frontend   1/1     Running   0          4m21s   frontend
	
	kubectl get pod -l 'tier notin (frontend)' -L tier
	
	NAME            READY   STATUS    RESTARTS   AGE     TIER
	color-backend   1/1     Running   0          7m21s   backend
	
	kubectl get pod -l 'tier in (frontend, backend)' -L tier
	
	NAME             READY   STATUS    RESTARTS   AGE     TIER
	color-backend    1/1     Running   0          8m43s   backend
	color-frontend   1/1     Running   0          8m43s   frontend


### Lab: Selecting Objects with MatchLabels and MatchExpressions

### Understanding Annotations

### Introduction to Kubernetes Namespaces

### Lab: Creating and Managing Namespaces


