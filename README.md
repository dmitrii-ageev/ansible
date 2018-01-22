# Ansible
Docker container to run Ansible - Automation Tool

# Usage
```
docker run -d --rm --name ansible -h ansible \
       --cpuset-cpus 0 --memory 2048mb --net host \
       -v $HOME/Documents/Ansible:/home/developer/ansible \
       -v $HOME/Downloads:/home/developer/Downlods \
       dmitriiageev/ansible

```

GitHub Page: https://github.com/dmitrii-ageev/ansible
Docker Hub Page: https://hub.docker.com/r/dmitriiageev/ansible
