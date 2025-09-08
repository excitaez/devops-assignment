# syntax=docker/dockerfile:1
FROM golang:1.21

# สร้าง working dir
WORKDIR /app

# เติม cache layer ของ dependency ก่อน
COPY go.mod ./
RUN go mod download

# คัดลอกซอร์สโค้ดที่เหลือ
COPY . .

# สร้างไบนารี (ปิด CGO ให้เป็น static; ใช้ได้กับแอปนี้)
ENV CGO_ENABLED=0 GOOS=linux
RUN go build -ldflags="-s -w" -o hello-api .

# เปิดพอร์ตของแอป
EXPOSE 8080

# คำสั่งรัน
CMD ["./hello-api"]
