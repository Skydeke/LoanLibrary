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
The Database runs within a Docker container and has its [Init-Script](backend/assets/scripts/CreateAutoverleih.sql) provided in
the [Backend-Assets](backend/assets/).

Frontend
--------
We created a component for every side and inside this component we used other compontes.
We have the following pages:

- [billsPage](frontend/src/pages/billsPage.vue) shows past bills
- [homePage](frontend/src/pages/homePage.vue) landing page of the application, shows all cars in the loan_libary
- [loginPage](frontend/src/pages/loginPage.vue) login into your accout
- [reservationsPage](frontend/src/pages/reservationsPage.vue) all your active reservation
- [signUpPage](frontend/src/pages/signUpPage.vue) create a account
- [vehiclePage](frontend/src/pages/vehiclePage.vue) reservate a car and see the details of a car

Then we added the following components:
- [BillComponent](frontend/src/components/BillComponent.vue) represents a single bill inside the billsPage
- [CarComponent](frontend/src/components/CarComponent.vue)  represents a single car inside the homePage
- [DetailedCarComponent](frontend/src/components/DetailedCarComponent.vue) details of a car inside the vehiclePage
- [LoginComponent](frontend/src/components/LoginComponent.vue) login-template inside the loginPage
- [NavigationBar](frontend/src/components/NavigationBar.vue) navigationbar for all of your pages
- [ReservationComponent](frontend/src/components/ReservationComponent.vue) represents a single reservation inside the reservationPage
- [SidebarComponent](frontend/src/components/SidebarComponent.vue) jump directly to a car-category from any page
- [SignupComponent](frontend/src/components/SignupComponent.vue) signUp-template inside the singUpPage

We also used services and plugins in our application.
- [localstorage](frontend/src//services/localstorage.service.js) We used this service to make the login persitent across differnt sessions.
- [vue router](frontend/src/router/index.js) We used the vue router to have a single-side application. We declared oure routes here.
- [vuex store](frontend/src/store/index.js) We used the vuex store to save application states across our components. 

Backend
-------
We used one file for our backend.
- [app.js](backend/app.js) We documented the Api endpoints and categorized them into the following topics
- [Carmodel](backend/documentation/Automodell.pdf)
- [Login](backend/documentation/Login.pdf)
- [Reservation](backend/documentation/Reservierung.pdf)

Platform
-------
We created one Dockerfile for every Service.
- [frontend](frontend/Dockerfile)
- [backend](backend/Dockerfile)

In order to make your Services secure, we used the nginx-server with https-encryption. Therefore, we added a [nginx-config](frontend/nginx/nginx.conf) and a certbot-folder We also used Docker volumes to make our database persistent. 
We summarized all our services in side the [docker-compose](docker-compose.yml) file.



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
cd backend
npm run serve
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
In compliance with our task for this lecture we have to mark every piece of code that we adapted from other sources. We used the template code-below to create your project. We changed all other template code for example from StackOverflow, otherwise it would not have fit into our project.

- [The Datetime-Pickers](https://vue3datepicker.com/props/general-configuration/)
- [E-Mail validation](https://stackoverflow.com/questions/46155/how-can-i-validate-an-email-address-in-javascript)
- [Password Progressbar Reference](https://serversideup.net/password-security-validation-with-vuejs-and-zxcvbn/)

Documentation
=============
In order to implement our application we mostly used the documentations.
For the backend we used the following documentations:
- [Cors](https://expressjs.com/en/resources/middleware/cors.html)
- [Bcrypt](https://openbase.com/js/bcrypt/documentation)
- [Dotenv](https://github.com/motdotla/dotenv)
- [Express](https://expressjs.com/en/api.html)
- [JsonWebToken](https://www.npmjs.com/package/jsonwebtoken)
- [MySql](https://www.npmjs.com/package/mysql)

For the frontend we used the following documentations:
- [Vue.js](https://vuejs.org/guide/introduction.html)
- [Vue Router](https://router.vuejs.org/installation.html)
- [Vuex Store](https://vuex.vuejs.org/guide/)
- [Axios](https://axios-http.com/docs/intro)
- [Vue-Scrollto](https://www.npmjs.com/package/vue-scrollto)
- [JavaScript-Modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)
- [Zxcvbn](https://zxcvbn-ts.github.io/zxcvbn/guide/user-input/)

For the platform we used the following documentations:
- [Docker](https://docs.docker.com/get-started/)
- [Dcoker-Compose](https://docs.docker.com/compose/gettingstarted/)
- [Nginx](https://www.nginx.com/resources/wiki/start/)
- [MySql-Docker](https://hub.docker.com/_/mysql)
- [Certbot-Docker](https://mindsers.blog/post/https-using-nginx-certbot-docker/)


Deployment
==========
As part of the lecture we additionaly deployed our Web-App on our raspberry pis. We did this expirience the whole project chicle. This also makes testing our application easier, because databases sometimes have portability issues. <br>
This is the [Link](https://grabo.duckdns.org/). <br>
This is the alternative [Link](https://autoverleih.dynv6.net/).

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

Certbot
==========
In order to use HTTPS we need a valid TLS certificate. Certbot is an easy way to do tis. 
To test the setup use
```
docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ --dry-run -d example.org
```
If everything succsseds, you can cerate the certificate by ussing:
```
docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d example.org
```
Certbot automatically renews your certificate once it is launches in the background.

Images and Data for DB
======================
Information and pictures of cars: 
- [Link](https://www.autobild.de/marken-modelle/)

User:
- 'Anakin Skywalker Vader', email: 'vader@imperium.org'

All Demo-Users have the same password: "test123". The Demo users are no different from the ones
you can create using the website, but the do have previous reservations and have lent out cars, which means that 
in their bills-section they actually have bills to pay.

Contributers
============

- David Metzler Mat-Nr: 35582
- Niklas Kleiser Mat-Nr: 35579
