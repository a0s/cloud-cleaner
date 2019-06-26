# cloud-cleaner

```bash
./services --help

Removes old (after time threshold) docker swarm services. 
Usage: services [options]
        --threshold=[TIME]           (required) Relative time threshold, example: "2 days ago"
        --destructive                Run in destructive mode
        --host=[URI|SOCKET]          Remote docker uri (http://...) or local socket (unix://...), default: unix:///var/run/docker.sock
        --exclude-names=[STRING,STRING]
                                     Exclude name from deletion process
```
