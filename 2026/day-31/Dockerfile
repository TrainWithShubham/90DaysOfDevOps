FROM node:20

WORKDIR /app

COPY package.json ./
# after rebuilduing
COPY . .

RUN npm install --no-cache


CMD ["npm","start"]