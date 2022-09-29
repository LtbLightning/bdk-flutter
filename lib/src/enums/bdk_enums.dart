enum Blockchain {
 ELECTRUM,
 ESPLORA
}
enum Descriptor{
 P2PK,
 P2PKH,
 P2WPKH,
 P2SHP2WPKH,
 P2SHP2WSHP2PKH,
 MULTI
}
/// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
enum Entropy{
 Entropy128, //16
 Entropy160, // 20
 Entropy192, //24
 Entropy224, //28
 Entropy256, // 32
}
enum Network {
 TESTNET,
 BITCOIN,
 REGTEST,
 SIGNET,
}
enum WordCount {
 Words12,
 Words15,
 Words18,
 Words21,
 Words24
}