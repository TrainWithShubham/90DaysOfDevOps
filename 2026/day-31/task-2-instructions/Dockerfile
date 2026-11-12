FROM alpine:latest

WORKDIR /app

COPY host-data.txt .

RUN apk add --no-cache python3 

EXPOSE 8000

CMD ["cat", "host-data.txt"]
