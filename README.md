# LoanLibrary
A Web-Application written in Javascript using Vue.js and Node.js as A project for the winter semester 22/23 at the RWU.

Graphical User Interfaces
=========================
As part of this lecture we are supposed to come up with an idea for a Web Application, which we will have to write using Java-Script and the two librarys Vue.js and Node.js specifically. A self-written backend is not required, since we are allowed to use [public-api](https://github.com/public-apis/public-apis). We have decided to Work on an online loan service that will loan out books, videos and games.

Project Structure
=================
We will try to avoid using JS, inside HTML. We will also try to seperate our Web-App in a frontend part and a backend part.
Inside the README we will have a section that describes what the specific files are supposed to do / manage.

What does file name here do?
==============================

[`frontend/index.html`](frontend/index.html)
-----------------------
This is the page you land on when opening the Website.

Installation
============
```
git clone https://github.com/Skydeke/LoanLibrary.git
cd LoanLibary

cd backend
npm install

cd ..

cd frontend
npm install
```

Launch Servers
==============
Launch the node.js server

```
cd backend
node app.js
```

Launch the vue.js in testing mode

```
cd frontend
npm run serve
```
Compile vue.js for deployment and publish dist directory

```
cd frontend
npm run build
```

Adapted Code
============
In compliance with our task for this lecture we have to mark every piece of code that we adapted from other sources.

[`frontend/index.html`](frontend/index.html)
-----------------------
[`Lines x-y`](https://stackoverflow.com/)
[`Lines a-b`](https://stackoverflow.com/)


Cloud
=====
As part of the lecture we also have to deploy our Web-App into a Cloud-Service of our choice.
The [Link](www.google.com) will be provided here.

Docker
======
Launch Vue Container on port 8080 on localhost and express Container on port 8081

```
docker-compose build
docker compose up
```


Contributers
============

- David Metzler Mat-Nr: 35582
- Niklas Kleiser Mat-Nr: 35579


