FROM golang:1.27 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .

EXPOSE 8080

FROM alpine:latest AS runtime

WORKDIR /production

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/myapp .

RUN chown appuser:appgroup myapp

CMD ["./myapp"]








