FROM golang:1.19 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /full-cycle-rocks

FROM scratch
WORKDIR /app

COPY --from=builder /full-cycle-rocks .

CMD ["/app/full-cycle-rocks"]
