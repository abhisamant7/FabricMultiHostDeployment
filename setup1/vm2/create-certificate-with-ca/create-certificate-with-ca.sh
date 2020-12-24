createCertificateForYngadmin() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/yngadmin.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/yngadmin.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.yngadmin.com --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-yngadmin-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-yngadmin-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-yngadmin-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-yngadmin-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/yngadmin.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.yngadmin.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.yngadmin.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.yngadmin.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.yngadmin.com --id.name yngadmin --id.secret yngadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/yngadmin.com/peers
  mkdir -p ../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.yngadmin.com -M ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/msp --csr.hosts peer0.yngadmin.com --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.yngadmin.com -M ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls --enrollment.profile tls --csr.hosts peer0.yngadmin.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/tlsca/tlsca.yngadmin.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer0.yngadmin.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/ca/ca.yngadmin.com-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.yngadmin.com -M ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/msp --csr.hosts peer1.yngadmin.com --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.yngadmin.com -M ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls --enrollment.profile tls --csr.hosts peer1.yngadmin.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/peers/peer1.yngadmin.com/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/yngadmin.com/users
  mkdir -p ../crypto-config/peerOrganizations/yngadmin.com/users/User1@yngadmin.com

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.yngadmin.com -M ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/users/User1@yngadmin.com/msp --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/yngadmin.com/users/Admin@yngadmin.com

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://yngadmin:yngadminpw@localhost:8054 --caname ca.yngadmin.com -M ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/users/Admin@yngadmin.com/msp --tls.certfiles ${PWD}/fabric-ca/yngadmin/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/yngadmin.com/users/Admin@yngadmin.com/msp/config.yaml

}

createCertificateForYngadmin