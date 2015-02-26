# ------------------------------------------------------------------------------
# Based on a work at https://github.com/docker/docker.
# ------------------------------------------------------------------------------
# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER AshDev <ashdevfr@gmail.com>

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

COPY content /var/www/html
COPY conf /etc/nginx
ADD nginx-env.sh /etc/nginx/nginx-env.sh
  
# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command. CMD ["/bin/bash"]
CMD ["/bin/bash", "/etc/nginx/nginx-env.sh"]

# Expose ports.
EXPOSE 80
EXPOSE 443
