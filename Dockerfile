FROM ubuntu:latest

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip wireguard-tools curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ip link add dev ens18 type dummy || true

RUN ip addr add 192.168.1.100/24 dev ens18 || true

RUN ip link set dev ens18 up || true

ENV LANG C.UTF-8

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV VARIABLE_NAME=value

CMD ["python3", "main.py"]
