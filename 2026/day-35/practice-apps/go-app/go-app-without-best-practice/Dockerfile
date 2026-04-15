FROM golang:1.22

WORKDIR /app

# 1. Copy only the module files first
COPY go.mod ./
# 2. Download dependencies (this layer is cached)
RUN go mod download

# 3. NOW copy the source code
COPY . .

# 4. Build the binary (now the files actually exist!)
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

EXPOSE 8080

# Recommended: use the full path or ./ to be explicit
CMD ["./main"]
