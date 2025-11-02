# ====== Build Stage ======
FROM golang:1.19 as build
WORKDIR /go/src/tasky
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/src/tasky/tasky .

# ====== Release Stage ======
FROM alpine:3.17.0
WORKDIR /app
COPY --from=build /go/src/tasky/tasky .
COPY --from=build /go/src/tasky/assets ./assets
RUN echo "Yuta Furuya" > /app/wizexercise.txt

EXPOSE 8080
CMD ["./tasky"]

