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

## Examples

Dry-run to show what will be delete

```bash
./services --threshold="2 days ago" --exclude-names="registrator"
```

and then real deletion

```bash
./services --threshold="2 days ago" --exclude-names="registrator" --destructive
```

In case you want temporary remote connection to `/var/run/docker.sock`  from other host (eg. local machine) you can use 
`socat` (described in [Forwarding TCP-traffic to a UNIX socket](https://coderwall.com/p/c3wyzq/forwarding-tcp-traffic-to-a-unix-socket))
For example, for remote port 11111

```bash
./services --host="http://remote-swarm-host:11111" --threshold="2 days ago" --exclude-names="registrator" --destructive
```
