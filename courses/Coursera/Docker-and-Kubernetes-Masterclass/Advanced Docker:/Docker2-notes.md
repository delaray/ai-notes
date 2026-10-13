# Advanced Docker: Persistence and Security

## Module 1: Volumnes and Data Persistence

**BIND MOUNTS**

	docker run -d -p 3000:300 -v src:/app/src -v public:/app/public <image-name>
	
**NAMED VOLUMES**

	docker volume create <volume-name>
	
	docker run ... -v <volume-name> ... <image-name>

## Module 2: Advanced Topics: Resource Limits, Restart Policies & Networking

### LAB: Setting CPU limits for containers

	--cpu-period int                   Limit CPU CFS (Completely Fair Scheduler) period
    --cpu-quota int                    Limit CPU CFS (Completely Fair Scheduler) quota
    --cpu-rt-period int                Limit CPU real-time period in microseconds
    --cpu-rt-runtime int               Limit CPU real-time runtime in microseconds
	--cpu-shares int (-c)              CPU shares (relative weight)
    --cpus decimal                     Number of CPUs
    --cpuset-cpus string               CPUs in which to allow execution (0-3, 0,1)
    --cpuset-mems string               MEMs in which to allow execution (0-3, 0,1)


### LAB: Setting Memory limits for containers

	--memory bytes (-m)                Memory limit
    --memory-reservation bytes         Memory soft limit
    --memory-swap bytes                Swap limit equal to memory plus swap: 
	--memory-swappiness int            Tune container memory swappiness (0 to 100)


### LAB: Working with Restart Policies

	-- restart no, on_failure:<int>, always, unless_stopped

### Introduction to Networking in Docker


Docker creates 3 networks by default:

**bridge**
**host**
**none**

	-- docker network ls
	-- docker network inspect <network-name>

### Using the Default Bridge Network

Cannot use container names in bridge network.

### Wortking with User-Defrined Networks

**docker network** COMMAND

Manage networks

	connect     Connect a container to a network
	create      Create a network
	disconnect  Disconnect a container from a network
	inspect     Display detailed information on one or more networks
	ls          List networks
	prune       Remove all unused networks
	rm          Remove one or more networks

Run 'docker network COMMAND --help' for more information on a command.

**docker network create** <network-name>

docker network create --help

	--attachable            Enable manual container attachment
    --aux-address map       Auxiliary IPv4 or IPv6 addresses used by Network driver
    --config-from string    The network from which to copy the configuration
    --config-only           Create a configuration only network
    --driver string (-d)    Driver to manage the Network (default "bridge")
	--gateway ipSlice       IPv4 or IPv6 Gateway for the master subnet (default [])
    --ingress               Create swarm routing-mesh network
    --internal              Restrict external access to the network
    --ip-range ipNetSlice   Allocate container ip from a sub-range (default [])
    --ipam-driver string    IP Address Management Driver (default "default")
    --ipam-opt map          Set IPAM driver specific options (default map[])
    --ipv4                  Enable or disable IPv4 address assignment (default true)
    --ipv6                  Enable or disable IPv6 address assignment
    --label list            Set metadata on a network
    --opt map (-o)         Set driver specific options (default map[])
    --scope string          Control the network's scope
    --subnet strings        Subnet in CIDR format that represents a network segment

Attaching a container to a user-defined network

	docker network create web-app
	docker -it --network web-app nginx:alpine
	
### LAB: Using the Host Network


## Module 3: Code & Deploy a Key-Value App

### Running a MongoDB Server

We will use Docker Hub Image: **mongodb/mongodb-community-server:7.0-ubuntu2204**
	
	docker run -d --name mongodb mongodb/mongodb-community-server:7.0-ubuntu2204
	
	docker exec -it mongodb mongosh 
	
		test> show dbs;
		test> use admin;
		
		admin> show collections;
		admin> exit
		
	docker rm -f mongodb
	
	docker ps -a
	
**NB**: Absolutely no **auth** or **security** in this example.

### Adding Root Credentials to MongoDB

	# Mongo Docker Hub Image and Tag
	MONGODB_IMAGE="mongodb/mongodb-community-server"
	MONGODB_TAG="7.0-ubuntu2204"
	CONTAINER_NAME="mongodb"
	
	# Root credentials
	ROOT_USER="root-user"
	ROOT_PASSWORD="root-password"

	# Key-value credentials
	KEY_VALUE_DB="key-value-db"
	KEY_VALUE_USER="key-value-user"
	KEY_VALUE_PASSWORD="key-value-password"

	# Start container with envs and bind mount
	docker run --rm -d --name $CONTAINER_NAME \
       -e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
       -e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
       -e KEY_VALUE_DB=$KEY_VALUE_DB \
       -e KEY_VALUE_USER=$KEY_VALUE_USER \
       -e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
       -v ./db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro \
       $MONGODB_IMAGE:$MONGODB_TAG


### Setting Credentials fro the Key-Value DB

MongoDB JavaScipt Init script

	const keyValueDb = process.env.KEY_VALUE_DB;
	const keyValueUser = process.env.KEY_VALUE_USER;
	const keyValuePassword = process.env.KEY_VALUE_PASSWORD;


	db = db.getSiblingDB(keyValueDb);

	db.createUser(
		{
			user: keyValueUser,
			pwd: keyValuePassword,
			roles: [
				{
					role: 'readWrite',
					db: keyValueDb
				} 
			]
		}
	);


### Defining Ports, Networks and Volumes


### Enhancing the Structure of Utility Scripts


### Setting Up the Express App


### Dockerizing the Express App


### Creating Scripts for the Backend Container


## Module 4: Docker Compose

### Overview of Docker Compose

### Comparing Docker-Compose & Compose CLI

### Lab: Running MongoDB with Docker Compose

### Lab: Using Environment Variables in Docker Compose

### Lab: Wosking with Bind Mounts in Docker Compose

### Lab: Managing Volumes and Networks in Docker Compose


Connect to running container DB with second container. 
NB: Verify network name and DB name after user/pwd in mongosh command.

	docker run --rm --name mongosh -it --network compose_key-value-net
		mongodb/mongodb-community-server:7.0-ubuntu2204 
		mongosh mongodb://key-value-user:key-value-password@key-value-db 



### Lab: Adding a Backend Service to the Docker Compose File

	backend:
		build:
			context: backend
			dockerfile: Dockerfile.dev
		ports:
			- "3000:3000"
		env_file:
			- .env.db-key-value
		networks:
			- key-value-net
		depends_on:
			- db


### Lab: Handling Service Dependencies in Docker Compose

    depends_on:
      - db
 

### Lab: Hot Reloading and File Watching

    develop:
      watch:
        action: sync
        path: ./backend/src
        target: /app/src
 

### Lab: Using Docker Compose CLI

Many of the same docker commands available.
Commands only affect containers in compose file.

	docker compose --help

## Module 5: Project - Code and Deploy a Notes App with Docker Compose

### Project Overview

### Setting Up NPM Projects

### Dockerizing Notebooks Backend

### Configuring Docker Compose for Notebook Services

### Setting Up Docker Compose for Notes Services

### Using Multistage Builds for Our Images

	FROM node:22-alpine AS development
	...
	FROM node:22-alpine AS prod-dependencies
	...
	FROM node:22-alpine AS production

### Merging Multiple Projects in Docker Compose

In a toplevel *compose.yaml*

	include:
	- notebooks-backend/compose.yaml
	- notes-backend/compose.yaml


### Implementing the NGINX Reverse Proxy

Need to create and define:

	nginx.conf

### Establishing Connections Between Services

Can override services or enhance compose project merge
Can connect included projects to newly defined network

	compose.override.yaml
	
### Setting Up Models and Routes for Notebooks Service

### Refactoring the Code

Express middleware can be used to chain functions dsuring requests

	const A = (req, res, next) => {
		Some validation...
		
		next(err)

	const B = (req, res, next) => {
		Some business logic...
	
		next(err)

	const C = (req, res, next) => {
		Some error processing...
		
		next(err);
	
	notebookRouter.post('/', A, B, C)'

Validators for example can be inserted before the request logic processing code using the example above.

The chaining relies on the *next* function being invoked in each middleware layer.

### Implementing Routes and Business Logic in the notes backend.


	
