.PHONY: help
SHELL                  := /bin/bash
MAKEFILE_PATH          := ./Makefile
MAKEFILES_DIR          := ./@bin/makefiles

PROJECT_SHORT          := bb

LOCAL_OS_USER_ID       := $(shell id -u)
LOCAL_OS_GROUP_ID      := $(shell id -g)
LOCAL_OS_SSH_DIR       := ~/.ssh
LOCAL_OS_GIT_CONF_DIR  := ~/.gitconfig
LOCAL_OS_AWS_CONF_DIR  := ~/.aws/${PROJECT_SHORT}

# localhost aws-iam-profile
#LOCAL_OS_AWS_PROFILE := bb-shared-deploymaster
# ci aws-iam-profile
LOCAL_OS_AWS_PROFILE  :="bb-dev-deploymaster"
LOCAL_OS_AWS_REGION   := us-east-1

TF_PWD_DIR            := $(shell pwd)
TF_VER                := 0.12.28
TF_PWD_CONT_DIR       := "/go/src/project/"
TF_DOCKER_ENTRYPOINT  := /bin/terraform
TF_DOCKER_IMAGE       := binbash/terraform-awscli-terratest-slim

TERRATEST_DOCKER_ENTRYPOINT := dep
TERRATEST_DOCKER_WORKDIR    := /go/src/project/tests

#
# TERRAFORM
#
define TF_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
--entrypoint=${TF_DOCKER_ENTRYPOINT} \
-w ${TF_PWD_CONT_DIR} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

#
# TERRATEST
#
define TERRATEST_GO_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws/${PROJECT_SHORT} \
-e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/${PROJECT_SHORT}/credentials \
-e AWS_CONFIG_FILE=/root/.aws/${PROJECT_SHORT}/config \
-w ${TERRATEST_DOCKER_WORKDIR} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

define TERRATEST_GO_CMD_BASH_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws/${PROJECT_SHORT} \
-e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/${PROJECT_SHORT}/credentials \
-e AWS_CONFIG_FILE=/root/.aws/${PROJECT_SHORT}/config \
-w ${TERRATEST_DOCKER_WORKDIR} \
--entrypoint=bash \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

define TERRATEST_DEP_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
--entrypoint=${TERRATEST_DOCKER_ENTRYPOINT} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# INITIALIZATION                                               #
#==============================================================#
init-makefiles: ## initialize makefiles
	rm -rf ${MAKEFILES_DIR}
	mkdir -p ${MAKEFILES_DIR}
	git clone https://github.com/binbashar/le-dev-makefiles.git ${MAKEFILES_DIR}
	echo "" >> ${MAKEFILE_PATH}
	sed -i '/^#include.*/s/^#//' ${MAKEFILE_PATH}

#
## IMPORTANT: Automatically managed
## Must NOT UNCOMMENT the #include lines below
#
include ${MAKEFILES_DIR}/circleci/circleci.mk
include ${MAKEFILES_DIR}/release-mgmt/release.mk
include ${MAKEFILES_DIR}/terraform12/terraform12.mk
include ${MAKEFILES_DIR}/terratest12/terratest12.mk




