# Advanced Kubernetes: Security and Large-Scale Deployments

## Module 2: Storage and Data Persistence

### Overview of the Course

### Introduction to Docker Volumes

VOLUME TYPES

	EmptyDir
	Local
	Claims
	Configuration
	Secrets

### Understanding EmptyDir and Local Volumes

**EmptyDir** are ephemeral pod storage  
  
**Local Volumes** are aligned with node lifecycle  

### Lab: Using EmptyDir and Local Volumes

When defining in pod definition need to specify both volume and the mountPath.  

	apiVersion: v1
	kind: Pod
	metadata:
		name: empty-dir-demo
		labels:
			name: empty-dir-demo
	spec:
		containers:
		- name: empty-dir-demo
		  image: busybox:1.36.1
		  command: ["sh", "-c", "sleep 3600"]
		  resources:
			  limits:
				  memory: "128Mi"
				  cpu: "500m"
			  requests:
				  memory: "64Mi"
				  cpu: "250m"
		  volumeMounts:
		  - name: temporary-storage
		    mountPath: /usr/share/temp
	  volumes:
	  - name: temporary-storage
        emptyDir: {}
	
	
EmptyDir storage is tied to pod lifecycle, not to container lifecycle  
Containers can have different mount paths, only names needs to be the same.  
Can specify readOnly flag in volumeMounts to prevent writing for the pod.  

---

### Introduction to Persistent Volume Claims

### Lab: Creating Persistent Volumes and Persistent Volume Claims

Example of defining **PersistentVolume** and matching **PersistentVolumeClaim**.

	apiVersion: v1
	kind: PersistentVolume
	metadata:
		name: local-pv
	spec:
		capacity:
			storage: 1Gi
		volumeMode: Filesystem
		accessModes:
		- ReadWriteOnce
	   	persistentVolumeReclaimPolicy: Retain
		storageClassName: local-storage
		local:
			path: /mnt/disks/local1
		nodeAffinity:
			required:
				nodeSelectorTerms:
				- matchExpressions:
					- key: kubernetes.io/hostname
					  operator: In
					  values: ['minikube']
  
	apiVersion: v1
	kind: PersistentVolumeClaim
	metadata:
		name: local-pvc
	spec:
		accessModes:
		  - ReadWriteOnce
	    storageClassName: local-storage
		resources:
			requests:
				storage: 1Gi

- There is a one-to-one mapping bedtween persistent volumes and persistent volumes claims.  
  
- The **PersistentVolumeClaim** object is saying "find me a volume that matches the criteria in the spec".  
- It will try to dynamically provision it, otherwise it will generate an error.__
    
- *Resource requests* must respect *PersistentVolume capacity* specification.  
	- If caopacity is 1Gi, cannot request 2Gi.  
    - Kubernetes  will fail to provision the request  
	- Claim will be left in a pending state.  


### Lab: Mounting Volumes in Pods and Containers
  
	apiVersion: v1
	kind: Pod
	metadata:
		name: local-vol-pod
		labels:
			name: local-vol-pod
	spec:
		containers:
		  - name: local-vol
		    image: busybox:1.36.1
			command: ["sh", "-c", "sleep 3600"]
			resources:
			  limits:
			    memory: "128Mi"
				cpu: "500m"
			volumeMounts:
			  - name: local-volume
			    mountPath: /mnt/local
	    volumes:
		  - name: local-volume
		    persistentVolumeClaim:
			  claimName: local-volume-claim
  
- We can exec into the pd and create a hello.txt file  
- We can ssh into the node to confirm filer accessible  
- We can delete the pod, recreate it and exec into it and file still there  
- We can create a second pod with same volume name and different mnt point  
  and then exec into it and see the file is accessible   
    
Summary: We were able to decouple pod & container lifecycle from storage.  


### Lab: Deleting Persistent Volumes and Persistent Volume Claims

If policy is **retain** then underlying FS will not be deleted evenm if claim is deleted and recreated. In other words, when the policy is **retain** and you ssh into the node you can still access files even after the claim has been deleted.  
This is true evenm if the persisten volume is deleted as well.  

  
### Lab: Dynamically Provisioning Persistent Volumes
  
Minikube also provides a very convenient way of provisioning dynamic persistent volumes.

	kubectl get storageclass
	
	NAME                 PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE 
	standard (default)   k8s.io/minikube-hostpath   Delete          Immediate

While local is preferred tp hostpath, dynamic provisioning does not support local pv.

	apiVersion: v1
	kind: PersistentVolumeClaim
	metadata:
		name: dynamic-pv-example
	spec:
	  resources:
	    requests:
		  storage: 1Gi
	  volumeMode: Filesystem
	  accessModes:
		- ReadWriteOnce
  
NB: In order to delete the dynamic pv, you need to delete the dynamic pvc.
  
---

### Introduction to StatefulSets in Kubernetes
  
Stateful sets manage stateful applications more effectively.
- Maintain stable pod identity
- Maintain stable persistent storage
- Can specify na PersistentVolumeClaim template
- Provide stable name & DNS for a Pod

### Lab: Creating Persistent Volumes with StatefulSets
  

### Lab: Deploying a StatefulSet
  

### Lab: StatefulSets with Dynamic Volume Provisioning
  

### Lab: Using Headless Services
