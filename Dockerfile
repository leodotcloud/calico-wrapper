FROM debian:jessie
MAINTAINER leodotcloud@gmail.com

RUN apt-get update && \
    apt-get install -y vim wget curl

RUN mkdir -p /opt/rancher/bin /opt/calico/bin && \
    wget https://github.com/projectcalico/calico-cni/releases/download/v1.3.1/calico \
         https://github.com/projectcalico/calico-cni/releases/download/v1.3.1/calico-ipam \
        -P /opt/calico/bin && \
	chmod +x /opt/calico/bin/calico /opt/calico/bin/calico-ipam

ADD new_entry.sh /opt/rancher/bin/new_entry.sh
ADD entry.sh /opt/rancher/bin/entry.sh
ADD invoke-actual-cni-plugin.sh /opt/rancher/bin/invoke-actual-cni-plugin.sh

ADD 10-calico.conf /opt/calico/10-calico.conf

# This is for the calico-node to change the entrypoint
VOLUME /opt/rancher

# This is for host volume mount to communicate with rancher-k8s-cni-adapter
VOLUME /opt/rancher/cni

ENTRYPOINT ["/opt/rancher/bin/entry.sh"]
