FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:ansible/ansible
RUN apt update
RUN apt install -y ansible git python-apt python-pip
RUN mkdir /playbooks
COPY roles/ /etc/ansible/roles/
COPY *.yml /playbooks/
RUN ln -s /etc/ansible/roles /playbooks/roles
RUN echo "localhost ansible_connection=local" >> /etc/ansible/hosts
WORKDIR /playbooks
RUN ansible-playbook local.yml --tags image_build -e "operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua" -e run_upstream=true
#RUN ansible-playbook local.yml --tags image_build -e "operator_dir=/tmp/operator-dir-dummy" -e "ansible_distribution=Ubuntu"
CMD ["/bin/bash"]