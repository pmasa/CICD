FROM kyma/docker-nginx:latest
COPY ./ /var/www
CMD 'nginx'

