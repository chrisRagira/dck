# Use the official Ubuntu as a base image
FROM ubuntu:latest

# Update packages and install necessary tools
RUN apt-get update && \
    apt-get install -y squid openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for Squid logs and SSL certificates
RUN mkdir -p /var/log/squid /etc/squid/ssl_cert

# Generate a self-signed SSL certificate for HTTPS support
RUN openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=myproxy.example.com" \
    -keyout /etc/squid/ssl_cert/proxy.key \
    -out /etc/squid/ssl_cert/proxy.crt

# Adjust Squid configuration to enable HTTPS support and allow all HTTP access
RUN sed -i 's/#\(https_port 3128 cert=.\+\)/\1/' /etc/squid/squid.conf && \
    sed -i 's/http_access deny all/http_access allow all/' /etc/squid/squid.conf

# Expose Squid proxy ports (HTTP and HTTPS)
EXPOSE 3128/tcp

# Copy custom Squid configuration (if needed)
# COPY squid.conf /etc/squid/squid.conf

# Run Squid in the foreground
CMD ["squid", "-N"]
