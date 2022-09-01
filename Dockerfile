# Pull base image.
FROM ubuntu:bionic

# Define software download URLs.
ARG FDM_URL=https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb

ENV DEBIAN_FRONTEND=noninteractive

# Download & Install Free Download Manager
RUN \
    apt update -y && \
    apt install -y curl libpulse-mainloop-glib0 && \
    curl -# -L -o /tmp/fdm.deb ${FDM_URL} && \
    apt install -y /tmp/fdm.deb

RUN \
    mkdir /config && \
    mkdir -p /root/.local/share/Softdeluxe/ && \
    ln -s /config "/root/.local/share/Softdeluxe/Free Download Manager"

RUN \
    apt install -y novnc supervisor

COPY . /app

ENTRYPOINT ["supervisord", "-c", "/app/supervisord.conf"]