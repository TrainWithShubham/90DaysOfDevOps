##STAGE 1##
##--BUILD--##

# taking the base image
FROM node:18-alpine AS BUILD
# creating the directory for the container 
WORKDIR /app
# Copy the package.json in container directory from local to avoid repeating the downloads of dependencies
COPY package.json .
# Run the commands to install all
RUN npm install 
# Copy the code from my local 
COPY . .
# This create /app/build folder containing pure HTML, CSS, JS files — no Node.js needed anymore!
RUN npm run build 

##STAGE 2##
##SERVE##

# Start fresh with a tiny Nginx image. Everything from Stage 1 is thrown away except what we copy!
FROM nginx:alpine
# Copy ONLY the built files from Stage 1 into Nginx
COPY --from=BUILD /app/build /usr/share/nginx/html
# Nginx serves on port 80. 
EXPOSE 80
