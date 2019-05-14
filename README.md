# openvpn-docker

OpenVPN server in a Docker container.

### Prerequisites
sudo apt install wget openvpn docker

### Building
Run `./build.sh`<br>
A docker image named `openvpn` will be build.<br>
You can find client configurations for each operating system in the root of the project directory. For example: `ubuntu.ovpn`

### Pushing the Docker Image
```
docker tag openvpn <registry-host>/<repository>
docker push <registry-host>/<repository>
```

### Running the Server
Connect to the machine you want to run OpenVPN server. Run the below command:
```
docker run -d --restart always --privileged -p 1194:1194/udp <registry-host>/<repository>
```

### Client Configurations
Before copying a client configuration to a client machine you need to add remote server IP to configuration file. Assume your server ip is 1.2.3.4, find the line `remote my-server-1 1194` in `ubuntu.ovpn` replace it with `remote 1.2.3.4 1194`

### Supported Operating Systems
**Windows**: windows.ovpn<br>
**Ubuntu**: ubuntu.ovpn -> Install the `resolvconf` package otherwise the client may not use OpenVPN DNS servers.<br>
`sudo apt install resolvconf`<br>
**iOS**: ios.ovpn

**Note**: ubuntu.ovpn may work with other Debian based systems but it is not tested.
