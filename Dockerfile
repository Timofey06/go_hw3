FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
WORKDIR /app/cmd/service
RUN go build -o /app/myapp main.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/myapp .
COPY --from=builder /app/data.csv .
CMD ["./myapp"]