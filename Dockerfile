FROM alpine:3.4
MAINTAINER leodotcloud@gmail.com

RUN apk update && \
	apk add wget curl

RUN mkdir -p /opt/rancher/bin /opt/calico/bin && \
    wget https://github.com/projectcalico/calico-cni/releases/download/v1.3.1/calico \
         https://github.com/projectcalico/calico-cni/releases/download/v1.3.1/calico-ipam \
        -P /opt/calico/bin && \
	chmod +x /opt/calico/bin/calico /opt/calico/bin/calico-ipam

ADD new_entry.sh /opt/rancher/bin/new_entry.sh
ADD entry.sh /opt/rancher/bin/entry.sh
ADD plugin.sh /opt/rancher/bin/plugin.sh

ADD 10-calico.conf /opt/calico/10-calico.conf

# This is for the calico-node to change the entrypoint
VOLUME /opt/rancher

ENTRYPOINT ["/usr/rancher/bin/entry.sh"]
