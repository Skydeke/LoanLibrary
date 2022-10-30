FROM node:16

# Create app directory
WORKDIR usr/src/app

#Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

RUN npm run build

#Nginx for azure pls
#This is in deploment mode, because of nginx 
FROM nginx:stable-alpine as production-stage
COPY  ./dist /usr/share/nginx/html 
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]