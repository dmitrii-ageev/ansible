# Ansible
Docker container to run Ansible - Agentless Automation Tool

# Usage
```
docker run -it --rm --name ansible -h ansible \
       --cpuset-cpus 0 --memory 2048mb --net host \
       -v $HOME/Downloads:/home/developer/Downlods \
       -v $HOME/Documents/Ansible:/home/developer/ansible \
       dmitriiageev/ansible

```

- GitHub Page: https://github.com/dmitrii-ageev/ansible
- Docker Hub Page: https://hub.docker.com/r/dmitriiageev/ansible
