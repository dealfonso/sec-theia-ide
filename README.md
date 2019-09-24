# Security layer for theia-ide

[theia-ide](https://hub.docker.com/r/theiaide/theia) is a powerful mechamism for remote development in your servers. Their authors define it as "VS Code for the cloud". The problem is that it has not authentication mechanism, so if anyone knows your server and port, your code will be exposed.

This image enables to add a security layer for the standard image of theia-ide. It adds token authentication and a https layer to make your coding sessions more secure. The security is added by means of [gen-http-proxy](https://www.npmjs.com/package/gen-http-proxy), which is a generic http proxy that enables https and token authentication.

## Usage

If you want to create a theia-ide server for the current folder (with https and token authentication), you can issue the next command:

```
$ docker run -u $(id -u) --rm -it -p 10443:10443 -e server=:10443 -e secure=1 -e staticfolder=/usr/local/lib/node_modules/gen-http-proxy/static -v $(pwd):/home/theia/project calfonso/sec-theia-ide /home/theia/project
```
The output will be something like that:

```
generating key file for https
generating cert file for https
root INFO Theia app listening on http://localhost:3000.
redirecting to localhost:3000
access url: https://0.0.0.0:10443?token=c44613c77dc82171242033e6da35c6a2
token: c44613c77dc82171242033e6da35c6a2
use cookies: true
expiration: 60
```

And now you are able to point to your browser to your 10443 port, using https and use the token in the output to log in into your code server.

The repository for [sec-theia-ide](https://github.com/dealfonso/sec-theia-ide) also contains a script called `theiahere` that wraps this command to ease the usage. You are invited to copy it to `/usr/local/bin` to be able to use it from any folder.

## Issues

If you have issues, please report them in the repositories:

- repository for **gen-http-proxy** at github: https://github.com/dealfonso/gen-http-proxy
- repository for **sec-theia-ide** at github: https://github.com/dealfonso/sec-theia-ide