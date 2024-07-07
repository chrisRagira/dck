# Use an official Ubuntu image as the base
FROM ubuntu:latest

# Set the maintainer information
LABEL maintainer="Your Name <your@email.com>"

# Install Squid and other dependencies
RUN apt-get update && \
    apt-get install -y squid && \
    apt-get clean

# Create the Squid configuration file
RUN rm /etc/squid/squid.conf
COPY . /etc/squid
RUN sudo chown -R proxy:proxy /var/cache/squid3 
# Expose the Squid port
EXPOSE 3128

# Set the default command to run when the container starts
CMD ["squid", "-N", "-d", "1"]
