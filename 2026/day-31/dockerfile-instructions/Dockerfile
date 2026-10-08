FROM ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY message.txt .

EXPOSE 8082

CMD ["cat", "message.txt"]