# 1. Minimal, specific base image
FROM golang:1.22.3-alpine3.19

# 2. Metadata
LABEL maintainer="SUMIT" \
      version="1.0" \
      description="Go app - single stage optimized"

# 3. Environment (static build)
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

# 4. Create non-root user early
RUN addgroup -S gogrp && adduser -S gousr -G gogrp

WORKDIR /app

# 5. Install only required packages
RUN apk add --no-cache git

# 6. Cache dependencies first
COPY go.mod ./
RUN go mod download

# 7. Copy source
COPY . .

# 8. Build binary (strip debug symbols to reduce size)
RUN go build -ldflags="-s -w" -o app

# 9. Adjust ownership
RUN chown -R gousr:gogrp /app

# 10. Switch user
USER gousr

# 11. Expose port
EXPOSE 8080

# 12. Exec form
CMD ["./app"]
