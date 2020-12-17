# nslcd

Docker image to run the local LDAP name service daemon.

### Usage
- The image only comes with the software and the default configuration file;
- It should be used in combination with Helm charts (or similar tools for container configuration) to create the custom configuration;
- The default command is `/usr/sbin/nslcd", "--debug`. The `--debug` option is used to keep the process in foreground.

### Exposing NSLCD to other contianers
- It is possible to export the nslcd socket once the process is running;
- To do so, mount `/run/nslcd` as volume;
- Other containers can mount it with the option `--volumes-from <nslcd_server_name>`.

### Providing access to LDAP to other containers
- Typically, `nscd` and `nslcd` are used to access LDAP in order to retrieve information on user accounts;
- In traditional environment, the two services run on the host machine as system daemons. In the world of containers, `nscd` and `nslcd` run in two dedicated containers;
- To allow LDAP access to a third container, proceed as follows:
  1. `nslcd`: Export the `nslcd` socket to a volume;
  2. `nscd`: Mount the volume with the `nslcd` socket into the `nscd` container;
  3. `nscd`: Export the `nscd` socket to a volume;
  4. `other containers`: Mount the volume with the `nscd` socket.

