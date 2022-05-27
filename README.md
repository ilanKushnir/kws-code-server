# kws-code-server
A docker image of VS-Code with a pre-configured settings and pre-installed extensions and OS packages
> <b>PLEASE NOTE!</b>
> <br /> This image of code-server was hacked to use MS marketplace - use it for personal use only!


### Build image for RPI server
update `[VERSION]`
```
docker buildx build --platform linux/arm64 -t ilankushnir/kws-code-server:latest -t ilankushnir/kws-code-server:[VERSION] --push .
```

### How to deploy?
Please see the example helm-release in the repo
<li>docker-compose example will be added soon</li>
