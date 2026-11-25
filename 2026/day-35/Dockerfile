
# ---------- Stage 1: Builder ----------

FROM golang:1.20-alpine AS builder 

WORKDIR /app

# Copy code
COPY main.go .

# Build the app (CGO_ENABLED=0 is a pro-tip to make it run anywhere without C dependencies)
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp main.go 

# ---------- Stage 2: Production ----------

# Best practice 1: Use specific base image tag (not 'latest')
FROM alpine:3.18

# Best Practice 2: Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /home/appuser/

# Copy ONLY the built binary from the 'builder' stage
COPY --from=builder /app/myapp .

# Best Practice 3: Switch to the non-root user
USER appuser

# Expose port and run 
EXPOSE 8080

CMD ["./myapp"]


