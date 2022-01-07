# openvpn-docker

OpenVPN server in a Docker container.

### Prerequisites
- [Docker Engine](https://docs.docker.com/engine/install/)

### Building
```
docker build -t openvpn .
```
A docker image named `openvpn` will be build.<br>
You can find client configurations for each operating system in the recently build container's `/build/ovpns` directory.<br>
**Important note**: Each time you build the image new keys, certificates and connection files will be generated for both client and server.

### Running the Server
Connect to the machine you want to run OpenVPN server. Run the below command:
```
docker run -d --name openvpn --restart always -p 1194:1194/udp --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun openvpn
```

### Client Configurations
```
id=$(docker create openvpn) # Create container from image named openvpn
docker cp $id:/build/ovpns/ . # Copy /build/ovpns/ directory from container to current directy.
docker rm -v $id # Remove the container previously created
```
Before copying a client configuration to a client machine you need to add remote server IP to configuration file. Assume your server IP is 1.2.3.4, find the line `remote my-server-1 1194` in `ubuntu.ovpn` replace it with `remote 1.2.3.4 1194`

### Supported Operating Systems
**Windows**: windows.ovpn<br>
**Ubuntu**: ubuntu.ovpn<br>
Install the `resolvconf` package otherwise the client may not use OpenVPN DNS servers. `sudo apt install resolvconf`<br>
**iOS**: ios.ovpn

**Note**: ubuntu.ovpn may work with other distros but it is not tested.
