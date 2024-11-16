# Minecraft for bears

- setup
  - create a `minecraft` user to run the server
  - create `/opt/minecraft` to contain the server files
  - copy `/etc/` to the file system
  - make `update_bedrock.sh` executable
  - make `/opt/minecraft/run_bedrock.sh` executable
- update
  - `/update^TAB`
  - it'll give you a version number, copy it and use it as the arg for the above update script
- commands
  - `echo 'say hello' >> /run/minecraft.stdin`
  - echo in a string to /run/minecraft.stdin
  - when using usernames, wrap in double quotes for spaces
