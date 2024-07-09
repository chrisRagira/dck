# Use an official Ubuntu image as the base
FROM ubuntu:latest

# Set the maintainer information
LABEL maintainer="Your Name <your@email.com>"

# Install Squid and other dependencies
RUN apt-get update && \
    apt-get install -y squid && \
    apt-get clean

# Create the Squid configuration file
RUN > /etc/squid/squid.conf
COPY . .
RUN cat squid2.conf > /etc/squid/squid.conf
RUN sudo service squid restart
# Expose the Squid port
EXPOSE 8888

# Set the default command to run when the container starts
CMD ["squid", "-N", "-d", "1"]
