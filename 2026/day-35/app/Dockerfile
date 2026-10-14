FROM golang:1.27 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .

EXPOSE 8080

FROM alpine:latest AS runtime

WORKDIR /production

COPY --from=builder /app/myapp .

CMD ["./myapp"]







