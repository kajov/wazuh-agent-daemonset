# Wazuh App Copyright (C) 2019 Wazuh Inc. (License GPLv2)
FROM ubuntu:18.04

# Dependencies
RUN apt-get update && \
    apt-get install curl apt-transport-https lsb-release python python-pip openssl -y &&\
    pip install docker \
    pip install kubernetes &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    mkdir /scripts /config

# Install the Wazuh agent
RUN curl -so wazuh-agent.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.0.4-1_amd64.deb && dpkg -i ./wazuh-agent.deb

# Scripts
ADD scripts/manage_agent_key.py /scripts/manage_agent_key.py

# Entrypoint
ADD scripts/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]