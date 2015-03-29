An ONBUILD Docker image for nginx and confd.

Expects the `confd` configurations files and templates to be located in
`./confd` of the inheriting image.

```
confd/
├── conf.d
│   └── nginx.toml
└── templates
    └── nginx.conf.tmpl
```

The image is based on information from [this blog post](https://www.digitalocean.com/community/tutorials/how-to-use-confd-and-etcd-to-dynamically-reconfigure-services-in-coreos)

To create a new image base on this one, all you need in your Dockerfile is
the `FROM` tag and an `EXPOSE` tag to expose the nginx port.

```
FROM andersjanmyr/nginx-conf
EXPOSE 80
```

`confd-watch.sh`, the script that is listening to `etcd` is configured with the
following environment variables and con be overridden when starting the
container with `docker run -e "ETCD_NODE=$MY_IP:4001" -it lifelog/nginx-confd`

```
export ETCD_NODE=172.17.42.1:4001
```
