### turnpike

# build binaries
build: build_nginx

# build podman images
build_gobuilder:
	podman build -t turnpike-gobuilder:latest -f ./Dockerfile.gobuilder .

build_images: build_gobuilder build_nginx_image

# misc
clean: nginx_clean
	go clean -cache

### nginx
build_nginx:
	go build -o ./turnpike-nginx-go ./nginx/main.go

nginx: build_nginx
	./nginx/turnpike-nginx-go

build_nginx_image: build_gobuilder
	podman build -t turnpike-nginx:latest -f ./Dockerfile.nginx .

nginx_image: build_nginx_image
	podman run -p 9090:9090 -d --name=turnpike-nginx turnpike-nginx:latest

nginx_clean:
	-rm nginx/turnpike-nginx-go
	-podman rm turnpike-nginx -f

### go web service