# Test with CLI
```bash
sudo docker build -t temp . && \
sudo docker run -it \
    --name temp \
    -e DB_HOST=`ifconfig docker0 | grep "inet\b" | awk '{print $2}'` \
    -e DB_USER=postgres \
    -e DB_PASSWORD=" " \
    temp /bin/sh; \
sudo docker rm `sudo docker ps -aq`
```

# Test container
```
(
    sudo docker build -t temp . && \
    sudo docker run \
        --name temp \
        -e DB_HOST=`ifconfig docker0 | grep "inet\b" | awk '{print $2}'` \
        -e DB_USER=postgres \
        -e DB_PASSWORD=" " \
        temp; \
    sudo docker rm `sudo docker ps -aq`
) | tee output.txt

```