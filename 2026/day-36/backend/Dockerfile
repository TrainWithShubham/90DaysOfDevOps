# Taking the base image
FROM node:18-alpine 
# Set the working directory
WORKDIR /app
#Copy the package 
COPY package.json . 
# Run the code to install all 
RUN npm install
# Copy the code in my container directory from the local 
COPY . .
# Expose the port 
EXPOSE 5000
# Serve the code 
CMD ["node","index.js"]
