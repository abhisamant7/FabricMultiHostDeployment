
chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block yngchannel.tx
rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
# cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "yngchannel"
CHANNEL_NAME="yngchannel"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile yngchannel -configPath . -outputCreateChannelTx ./yngchannel.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for DfarmadminMSP  ##########"
configtxgen -profile yngchannel -configPath . -outputAnchorPeersUpdate ./DfarmadminMSPanchors.tx -channelID $CHANNEL_NAME -asOrg DfarmadminMSP

echo "#######    Generating anchor peer update for YngadminMSP  ##########"
configtxgen -profile yngchannel -configPath . -outputAnchorPeersUpdate ./YngadminMSPanchors.tx -channelID $CHANNEL_NAME -asOrg YngadminMSP
