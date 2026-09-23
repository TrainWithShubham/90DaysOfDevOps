# Node.js lightweight image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json
COPY package.json ./

# Install dependencies
RUN npm install

# Copy rest of the app files
COPY . .

# Expose app port
EXPOSE 3030

# Start the app
CMD ["node", "index.js"]