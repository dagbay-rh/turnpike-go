build_nginx:
	go build -o ./nginx/turnpike-nginx-go ./nginx/main.go

run_nginx: build_nginx
	./nginx/turnpike-nginx-go

nginx_image:
	podman build -t turnpike-nginx:latest -f ./nginx/Dockerfile ./nginx
	podman run -p 9090:9090 -d --rm --name=turnpike-nginx turnpike-nginx:latest

nginx_image_kill:
	podman kill turnpike-nginx

clean:
	go clean -cache
	rm nginx/turnpike-nginx-go