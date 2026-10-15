FROM alpine:latest 
WORKDIR /app

RUN apk add --no-cache curl 

COPY app.js .

CMD ["cat", "app.js"]

