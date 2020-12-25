export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../vm4/crypto-config/ordererOrganizations/dfarmorderer.com/orderers/dfarmorderer.com/msp/tlscacerts/tlsca.dfarmorderer.com-cert.pem
export PEER0_Dfarmadmin_CA=${PWD}/crypto-config/peerOrganizations/dfarmadmin.com/peers/peer0.dfarmadmin.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=yngchannel

setGlobalsForPeer0Dfarmadmin(){
    export CORE_PEER_LOCALMSPID="DfarmadminMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Dfarmadmin_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/dfarmadmin.com/users/Admin@dfarmadmin.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1Dfarmadmin(){
    export CORE_PEER_LOCALMSPID="DfarmadminMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Dfarmadmin_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/dfarmadmin.com/users/Admin@dfarmadmin.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

createChannel(){
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Dfarmadmin

    # Replace localhost with your orderer's vm IP address
    peer channel create -o 3.87.212.137:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride dfarmorderer.com \
    -f ./../../artifacts/channel/${CHANNEL_NAME}.tx --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

createChannel

joinChannel(){
    setGlobalsForPeer0Dfarmadmin
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

    setGlobalsForPeer1Dfarmadmin
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

}

# joinChannel

updateAnchorPeers(){
    setGlobalsForPeer0Dfarmadmin
    # Replace localhost with your orderer's vm IP address
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride dfarmorderer.com -c $CHANNEL_NAME -f ./../../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

# updateAnchorPeers

# removeOldCrypto

# createChannel
# joinChannel
# updateAnchorPeers