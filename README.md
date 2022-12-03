# LoanLibrary
A Web-Application written in Javascript using Vue.js and Node.js as A project for the winter semester 22/23 at the RWU.

Graphical User Interfaces
=========================
As part of this lecture we are supposed to come up with an idea for a Web Application, 
which we will have to write using Java-Script and the two libraries Vue.js and Node.js specifically.
A self-written backend is not required, since we are allowed to use [public-api](https://github.com/public-apis/public-apis). 
We have decided to Work on an online loan service that will loan out cars.

Project Structure
=================
We will try to separate our Web-App in a frontend part and a backend part.
Inside the README we will have a section that describes what the specific files are supposed to do / manage.

Installation
============
Cloning the project
```
git clone https://github.com/Skydeke/LoanLibrary.git
cd LoanLibary
```
Installing the necessary dependencies
```
cd backend
npm install

cd ..

cd frontend
npm install
```

Launch Servers
==============
To launch the node.js server it is required that the database is running, 
here the command using our standard environment values as defined in [docker-compose.yml](docker-compose.yml).
For the Commands to work you need to be in the main directory LoanLibrary.

The Backend requires the Database:
```
docker-compose up -d database
DB_HOST=localhost DB_USER=root DB_PASSWORD=root DB_NAME=car_share node backend/app.js
```

Launch the vue.js in testing mode, it requires the Backend to run to function properly

```
cd frontend
npm run serve
```
Compile vue.js for deployment and publish dist directory, it requires the Backend to run to function properly

```
cd frontend
npm run build
```

Adapted Code
============
In compliance with our task for this lecture we have to mark every piece of code that we adapted from other sources.

Cloud
=====
As part of the lecture we also have to deploy our Web-App into a Cloud-Service of our choice.
The [Link](https://grabo.azurewebsites.net/) will be provided here.

Docker
======
Launch Vue Container on port 8080 on localhost, the Express Container on port 8081 and the MySQL Container on Port 3306
```
docker-compose build
docker compose up
```
The containers can also be launched separately from each other using the docker-compose -d Container command.

Docker Hub
==========
In oder to get the Docker Images on Azure we needed to push on the docker images for frontend and backend on docker hub. 

The two image repositories are provided below.
 - [Frontend-Container](https://hub.docker.com/repository/docker/xxfiestadeamonxx/loan-libary-frontend)
 - [Backend-Container](https://hub.docker.com/repository/docker/xxfiestadeamonxx/loan-libary-backend)


Contributers
============

- David Metzler Mat-Nr: 35582
- Niklas Kleiser Mat-Nr: 35579

Images and Data for DB
======================
[Link](https://www.autobild.de/marken-modelle/)

