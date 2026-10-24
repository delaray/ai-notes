# Advanced Kubernetes: Security and Large-Scale Deployments

## Module 1: Managing Kubernetes Resources

### Introduction to the Course

### Full Specialization Resources

![Resource Management](images/advanced-kubernetes--M1-01-resource-management.png)

### Introduction to the Section

### Understanding Labels and Selectors

![Labels and Selectors 1](images/advanced-kubernetes--M1-02-labels-and-selectors-1.png)

![Labels and Selectors 2](images/advanced-kubernetes--M1-02-labels-and-selectors-2.png)

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

	apiVersion: apps/v1
	kind: Deployment
	metadata:
		name: color-api
	spec:
		replicas: 3
		selector:
			matchLabels:
				app: color-api
				environment: local
				tier: backend
			matchExpressions: 
				- key: managed
				  operator: Exists
	    template:
			metadata:
				labels:
					app: color-api
					environment: local
					tier: backend
					managed: deployment
			spec:
				containers:
					- name: color-api
					  image: delaray/color-api:1.1.0

### Understanding Annotations

Used by external systems or Kubernetes itself to manage metadata or configure services and tools.  

[Annotations]()  
  

### Introduction to Kubernetes Namespaces

Improve the isolation of groups of resources.  

Four default namesapces created automatically upon cluster creation

	default
	kube-public
	kube-system
	kube-node-lease
  
---
  
### Lab: Creating and Managing Namespaces

	apiVersion: v1
	kind: Namespace
	metadata:
		name: dev

---

If no namespace specified kubewrnetes uses *default* namespace.  

	kubectl get pod --namespace kube-system
	
	NAME                               READY   STATUS    RESTARTS      AGE
	coredns-7d764666f9-8q5rr           1/1     Running   0             13d
	coredns-7d764666f9-nwcfv           1/1     Running   0             13d
	etcd-minikube                      1/1     Running   0             13d
	kube-apiserver-minikube            1/1     Running   0             13d
	kube-controller-manager-minikube   1/1     Running   0             13d
	kube-proxy-6lrkq                   1/1     Running   0             13d
	kube-scheduler-minikube            1/1     Running   0             13d
	storage-provisioner                1/1     Running   2 (13d ago)   13d

---

Setting the current namespace  

	kubectl config current-context
	--> minikube
	
	kubectl config set-context --current --namespace=dev 
	--> Context "minikube" modified.
	
	kubectl config view
	
If you delete a namespace, all resources in the namespaces are deleted.
	
### Lab: Cross-Namespace Service Communication

Need to specify a fully qualified resource path to reference objects in a different namespace.  

### Introduction to Resource Quotas, Requests, and Limits

**Resource Quotas** are applied at the namespace level  
**Request Limits** are applied at the pod level  

### Lab: Setting Up Resource Quotas

Defining a namespace and resourcequota

	apiVersion: v1
	kind: Namespace
	metadata:
      name: prod
	---
	apiVersion: v1
	kind: ResourceQuota
	metadata:
		name: prod-quota
		namespace: prod
	spec:
		hard:
			requests.cpu: "2"
			requests.memory: "2Gi"
			limits.cpu: "4"
			limits.memory: "4Gi"

Accessing resourcequota information in CLI

	kubectl get resourcequota -A
	
	kubectl describe resourcequota prod-quota -n prod
	
### Setting Resource Requests and Limits

	apiVersion: v1
	kind: Pod
	metadata:
		name: color-api
		namespace: dev
		labels:
			app: color-api
	spec:
		containers:
		- name: color-api
		  image: delaray/color-api:1.1.0
		  resources:
			  requests:
				  cpu: "200m"
				  memory: "250Mi"
			  limits:
				  cpu: "500m"
				  memory: "512Mi"
	     ports:
		  - containerPort: 80
		  
  
### Managing Rollouts, Resource Requests and Limits

Create a deployment resource for color-api and specify image version 1.0.0  

There's one trap to be weary of in this type of setup after we've specified this sort of setup. Now, in the terminal:  

	kubectl apply -f dev-ns.yaml 
	kubectl apply -f color-api-depl.yaml
	
	kubectl get pods -n dev
	
	NAME                              READY   STATUS    RESTARTS   AGE
	color-api-depl-64b575bff4-2k628   1/1     Running   0          17s
	color-api-depl-64b575bff4-dpjdw   1/1     Running   0          17s
	color-api-depl-64b575bff4-mxttn   1/1     Running   0          17s
	color-api-depl-64b575bff4-xs885   1/1     Running   0          17s
	
We have 4 replica pods as requested that respect the resourcequota of the namespace.  

Now let's update the color-api image version to color-api:1.1.0  

	kubectl apply -f color-api-depl.yaml
	--> deployment.apps/color-api-depl configured
	
	kubectl get pods -n dev
	-->
	NAME                              READY   STATUS    RESTARTS   AGE
	color-api-depl-64b575bff4-2k628   1/1     Running   0          2m6s
	color-api-depl-64b575bff4-dpjdw   1/1     Running   0          2m6s
	color-api-depl-6d47bdbb77-gg7s8   1/1     Running   0          4s

Because the rollout needs to create additional pods before deleting the older one, the resourcequotas have been exceeded and we have only 3 pods instead of 4.  

So if we examine the status of thew rollout:  

	kubectl rollout status deploy/color-api-depl -n dev
	-->
	Waiting for deployment "color-api-depl" rollout to finish: 1 out of 4
	new replicas have been updated...

By describing the replicaset we can see that we are getting a "forbidden" error and that the quota has been exceeded. This is visible in the replicaset describe because the replicaset object is responsible for creating/deleting (i.e replacing) the current podsd duriong the rollout.  

Need to anticiapted resourcequota needs and manage allocations and requestsz appropriately.  

### Startup, Liveliness and Readiness Probes

Probes are managed by Kubernetes and check the status of pods at various points in their lifecycle. If the probes fail Kubernetes attemps to restart the container or waiut for it to be ready depending on the probe type.

There are three types of probes:

**Startup Probe**
**Liveness Probe**
**Readiness probe**


### Lab: Color API - Adding Health Endpoints

Added health endpoints to color-api index.js and bumped version 1.2.0  
Built and pushed image to docker hub.  

### Lab: Working with Startup Probes

	apiVersion: v1
	kind: Pod
	metadata:
		name: color-api-pod
		labels:
			name: color-api-pod
	spec:
		containers:
		  - name: color-api-pod
		    image: delaray/color-api:latest
		    ports:
		      - containerPort: 80
		    resources:
			  limits:
			    cpu: "500m"
				memory: "512Mi"
		    env:
			  - name: DELAY_STARTUP
			    value: "true"
			startupProbe:
			  httpGet:
			    path: /health
				port: 80
			  failureThreshold: 2
			  periodSeconds: 3
  
Now back in the terminal we can see the effect of the startup probe:  

	kb apply -f color-api-pod.yaml 
	--> pod/color-api-pod created

	kubectl get pod --watch

	NAME            READY   STATUS    RESTARTS   AGE
	color-api-pod   0/1     Running   0          2s
	color-api-pod   0/1     Running   1 (0s ago)   7s
	color-api-pod   0/1     Running   2 (0s ago)   13s
	color-api-pod   0/1     CrashLoopBackOff   2 (0s ago)   19s

### Lab: Color API - Adding a Dedicated Startup Endpoint

Added a **/up** endpoint to color-api/src/index.js

	app.get('/up', (req, res) => {
		return res.send('OK');
	});


### Lab: Working with Liveliness Probes

Very similar in syntax to startup probe.

    livenessProbe:
      httpGet:
        path: /health
        port: 80
      failureThreshold: 3
      periodSeconds: 10

### Lab: Working with Readiness Probes


