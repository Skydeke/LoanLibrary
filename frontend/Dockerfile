FROM node:16 as build-stage

# Create app directory
WORKDIR /usr/src/app

#Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

RUN npm run build

#docker image is only built from the last state, from means that a new stage beginns
FROM nginx:stable-alpine as production-stage 
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html 

COPY nginx/nginx.conf /etc/nginx/nginx.conf


EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]