#!/bin/bash

version=$1
now=$( date '+%F__%H-%M-%S' )

if [[ -z "$version" ]]; then
  echo "Must provide version as first argument" 1>&2
  echo "is it this?"
  curl --silent https://www.minecraft.net/en-us/download/server/bedrock -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:107.0) Gecko/20100101 Firefox/107.0" | ~/.cargo/bin/htmlq --attribute href ".downloadlink[data-platform='serverBedrockLinux']"
  exit 1
fi

#if [[ ! "$version" =~ ^\d+\.\d+\.\d+\.\d+$ ]]; then
#  echo "Version format should mimic 1.19.30.04" 1>&2
#  exit 1
#fi


# stop server
sudo systemctl stop minecraft

# backup server
mkdir -p ./minecraft-backups/bedrock
mkdir -p /opt/minecraft
echo "backing up server"
sudo zip -q -r ./minecraft-backups/bedrock/bedrock_backup_$now.zip /opt/minecraft
echo "world backed up"

# temp directory
mkdir -p _bedrock
cd _bedrock

# download new bedrock server zip
echo "download latest server"
curl -LO https://minecraft.azureedge.net/bin-linux/bedrock-server-$version.zip

echo "unzipping latest server"
unzip -q ./bedrock-server-*.zip -d ./bedrock-server
rm \
  ./bedrock-server/server.properties \
  ./bedrock-server/permissions.json \
  ./bedrock-server/allowlist.json \
  ./bedrock-server-*.zip

echo "updating server files"
sudo cp -R ./bedrock-server/* /opt/minecraft/
sudo chown -R minecraft:minecraft /opt/minecraft/

echo "starting server"
sudo systemctl start minecraft
#systemctl status minecraft-bedrock

cd ..

rm -rf ./_bedrock

echo "done!"
echo "journalctl -u minecraft -f"
