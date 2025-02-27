# Base Image 
#FROM nginx
#Copy the index.html file /usr/share/nginx/html/
#COPY index.html /usr/share/nginx/html/

# -------- new ---------

# Set the base image
FROM balenalib/raspberry-pi

# File Author / Maintainer
MAINTAINER Pedro 


## BEGIN INSTALLATION

# Install nginx
# Separate nginx user not required, as www-data account is already being used
RUN apt-get update && apt-get install -y nginx && apt-get -y clean

# Copy start script
#COPY start-nginx.sh /opt/


## IMAGE CONFIGURATION

# Expose HTTP & HTTPS
EXPOSE 81 443

# Update (optional) & start nginx
#CMD ["bash", "/opt/start-nginx.sh"]
CMD ["nginx", "-g", "daemon off;"]


