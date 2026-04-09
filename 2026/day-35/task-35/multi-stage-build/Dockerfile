#stage:1:build
FROM node:18 AS builder

WORKDIR /app

COPY package.json .

RUN npm install

#The builder stage image is NOT part of the final image. 
#It is discarded (not included) after the build — only selected files are copied forward.

#stage:2:production
FROM node:18-alpine

WORKDIR /app


#It allows us to copy only the required built artifacts and 
#dependencies from the build stage into a lightweight production image, reducing size and improving security.
COPY --from=builder /app /app 

COPY . .

EXPOSE 3000

CMD [ "node", "app.js" ]

