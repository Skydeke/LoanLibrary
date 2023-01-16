FROM node:16

# Create app directory, similar to cd all commands are relative to the workdir
WORKDIR /usr/src/app

#Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

EXPOSE 8081


CMD ["npm", "run", "serve"]