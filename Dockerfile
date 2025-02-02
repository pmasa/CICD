#FROM kyma/docker-nginx:latest
FROM nginx
COPY ./ /var/www
CMD 'nginx'

