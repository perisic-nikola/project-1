FROM ubuntu:24.04

# 1. Install dependencies non-interactively and clean up apt cache to keep image small
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Create a non-root service user (DevOps security standard)
RUN useradd -m -s /bin/bash devops

# 3. Copy our health-check script and lock down permissions
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod 755 /usr/local/bin/healthcheck.sh

# 4. Drop root privileges before running the container
USER devops
WORKDIR /home/devops

CMD ["/usr/local/bin/healthcheck.sh"]
