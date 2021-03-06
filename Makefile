PROJECT_NAME = tech-radar
WL           = ./wl
VERSION      =  $(shell git describe --always --dirty)

export VERSION

$(WL):
	curl -sSLfo $(WL) https://downloads.jimdo-platform.net/wl/latest/wl_latest_$(shell uname -s | tr A-Z a-z)_$(shell uname -m | sed "s/x86_64/amd64/")
	chmod +x $(WL)

build:
	docker build -t registry.jimdo-platform.net/${PROJECT_NAME}:${VERSION} .

run:
	docker run -t -p 8080:8080 registry.jimdo-platform.net/${PROJECT_NAME}

push: $(WL) build
	$(WL) docker push registry.jimdo-platform.net/${PROJECT_NAME}:${VERSION}

deploy: $(WL)
	$(WL) deploy ${PROJECT_NAME}
