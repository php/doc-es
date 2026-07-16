.PHONY: *

SHELL = /bin/sh

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)

#
# If doc-en, doc-base, or phd exist as siblings to the current directory,
# add those as volumes to our Docker runs.
#

PATHS := -v ${PWD}:/var/www/es
ifneq ($(wildcard ../doc-en/Makefile),)
	PATHS += -v ${PWD}/../doc-en:/var/www/en
endif
ifneq ($(wildcard ../doc-base/LICENSE),)
	PATHS += -v ${PWD}/../doc-base:/var/www/doc-base
endif
ifneq ($(wildcard ../phd/LICENSE),)
	PATHS += -v ${PWD}/../phd:/var/www/phd
endif

xhtml: .docker/built
	docker run --rm ${PATHS} -w /var/www -u ${CURRENT_UID}:${CURRENT_GID} php/doc-en \
		sh -c "php doc-base/configure.php --with-lang=es && php phd/render.php --docbook doc-base/.manual.xml --output=/var/www/es/output --package PHP --format xhtml"

php: .docker/built
	docker run --rm ${PATHS} -w /var/www -u ${CURRENT_UID}:${CURRENT_GID} php/doc-en \
		sh -c "php doc-base/configure.php --with-lang=es && php phd/render.php --docbook doc-base/.manual.xml --output=/var/www/es/output --package PHP --format php"

build: .docker/built

.docker/built: .docker/Dockerfile
	docker build \
		--build-arg UID=${CURRENT_UID} --build-arg GID=${CURRENT_GID} \
		.docker -t php/doc-en
	touch .docker/built
