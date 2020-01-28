# Configuration

LANG := en_US.UTF-8 # `make list` is language sensitive
BINARY := maintenance
IMAGE_NAME := maintenance
DEVELOPER := civilcode
DOCKERHUB_REPO := maintenance

# Targets

list:
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

# Deployment is a two step process. See the README for more information.
deploy.push: docker.build docker.push
deploy.release: docker.pull

docker.build:
	docker image build --rm --no-cache -t $(DEVELOPER)/$(IMAGE_NAME) .

docker.push:
	docker login
	docker push $(DEVELOPER)/$(DOCKERHUB_REPO)

docker.pull:
	docker pull $(DEVELOPER)/$(DOCKERHUB_REPO)

docker.restart: docker.stop docker.run

docker.run:
	docker run --name $(IMAGE_NAME) -d -p 80:80 \
		--env-file .env.maintenance \
		--restart=unless-stopped \
		-v $(pwd):/web \
		$(DEVELOPER)/$(DOCKERHUB_REPO)

docker.stop:
	docker stop $(IMAGE_NAME)
	docker rm --force $(IMAGE_NAME)

docker.log:
	docker logs $(IMAGE_NAME)

docker.bash:
	docker exec -it $(IMAGE_NAME) bash
