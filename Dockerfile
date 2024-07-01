# Use an official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y sudo openssl

# Add the script and the users file to the container
COPY create_users.sh /usr/local/bin/create_users.sh
COPY users.txt /usr/local/bin/users.txt

# Make sure the script is executable
RUN chmod +x /usr/local/bin/create_users.sh

# Run the user creation script
# CMD ["/usr/local/bin/create_users.sh", "/usr/local/bin/users.txt"]
CMD tail -f /dev/null
