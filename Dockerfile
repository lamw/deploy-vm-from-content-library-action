FROM ubuntu

LABEL "com.github.actions.name"="Deploy VM from vSphere Content Library"
LABEL "com.github.actions.description"="Deploy VM from vSphere Content Library"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/lamw/deploy-vm-from-content-library-action"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="https://github.com/lamw"

RUN apt-get -y update
RUN apt-get -y install curl git vim
COPY setup.sh /setup.sh
RUN /setup.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

