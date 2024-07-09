# Use an official Ubuntu image as the base
FROM ubuntu:latest

# Install Dante and other dependencies
RUN apt-get update && \
    apt-get install -y dante-server && \
    rm -rf /var/lib/apt/lists/*

# Create a configuration file for Dante
RUN echo "logoutput: /var/log/danted.log" >> /etc/danted.conf
RUN echo "internal: 0.0.0.0 port = 1080" >> /etc/danted.conf
RUN echo "external:" $(ip -o -4 route show to default | awk '{print $5}') >> /etc/danted.conf
RUN echo "socksmethod: none" >> /etc/danted.conf

# Expose the SOCKS4 port
EXPOSE 1080

# Start the Dante service when the container starts
CMD ["danted"]