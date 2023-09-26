# just start nginx in a container with a hello world endpoint

FROM registry.access.redhat.com/ubi8-minimal

RUN microdnf module enable nginx:1.22 && \
    microdnf install -y nginx && \
    chmod g+rwx /var/log/nginx && \
    rm -rf /var/lib/dnf /var/cache/dnf

# run the go app to build the backends
COPY ./turnpike-nginx-go ./turnpike-nginx-go

# run nginx server
COPY . /etc/nginx
RUN chgrp -R root /etc/nginx && chmod -R g+rwX /etc/nginx
CMD ["nginx", "-g", "daemon off;"]