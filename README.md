# container-minecraft <a href="https://github.com/yellowmegaman/container-minecraft/actions"><img src="https://github.com/yellowmegaman/container-minecraft/workflows/container/badge.svg" alt="Build Status"></a> <a href="https://hub.docker.com/r/yellowmegaman/container-minecraft"><img src="https://img.shields.io/docker/pulls/yellowmegaman/container-minecraft?style=flat-square" alt="Docker pulls"></a>

Debian docker image with minecraft server and Forge

```
docker run -d --name=mc -p 25565:25565 -e "EULA=true" -v /opt/minecraft/mods:/opt/minecraft/mods -v /opt/minecraft/world:/opt/minecraft/world -v /opt/minecraft/server.properties:/opt/minecraft/server.properties yellowmegaman/container-minecraft:1.12.2-14.23.5.2844

```
