FROM debian:bullseye-slim

# Start and enable SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server postgresql-client \
    && rm -rf /var/lib/apt/lists/* \
    && echo "root:Docker!" | chpasswd

COPY sshd_config /etc/ssh/

# Expose SSH port 2222
EXPOSE 2222 8000

# Create SSH host keys and run directory
RUN mkdir -p /var/run/sshd

# Start SSH server and keep container alive
CMD ["/usr/sbin/sshd", "-D"]