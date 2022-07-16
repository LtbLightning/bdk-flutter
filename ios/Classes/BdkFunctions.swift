import Foundation
class BdkProgress : Progress {
    func update(progress: Float, message: String?) {
        print("progress", progress, message as Any)
    }
}


let TAG = "BDK-F"


class BdkFunctions: NSObject {
     var wallet: Wallet
     var blockChain: Blockchain
     let databaseConfig = DatabaseConfig.memory
     let  defaultBlockChainConfigUrl:String = "ssl://electrum.blockstream.info:60002"
     let defaultBlockChain = "ELECTRUM"
     let blockchainConfig = BlockchainConfig.electrum(
                                            config: ElectrumConfig(
                                                                  url: "ssl://electrum.blockstream.info:60002",
                                                                  socks5: nil,
                                                                  retry: 5,
                                                                  timeout: nil,
                                                                  stopGap: 10))
    let defaultNodeNetwork = "testnet"
    let defaultDescriptor = "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)"
    let defaultChangeDescriptor = "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/1/*)"
    
    
    override init() {
        self.blockChain = try! Blockchain(config: blockchainConfig)

        self.wallet = try! Wallet.init(descriptor: defaultDescriptor, changeDescriptor: defaultChangeDescriptor, network: Network.testnet, databaseConfig: databaseConfig)

        try? self.wallet.sync(blockchain: blockChain, progress: BdkProgress())

    }

    
    func sync(config:BlockchainConfig?) {
        try? self.wallet.sync(blockchain: Blockchain.init(config: config ?? blockchainConfig), progress: BdkProgress())
    }


    private func _seed(
        recover: Bool = false,
        mnemonic: String?,
        password: String? = nil
    ) throws -> ExtendedKeyInfo {
        do {
            if(!recover){ return try generateExtendedKey(network: wallet.getNetwork() , wordCount: WordCount.words12, password: password) }
            else {return try restoreExtendedKey(network: wallet.getNetwork() , mnemonic: mnemonic ?? "", password: password) }
        } catch {
            throw error
        }
    }

    private func setNetwork(networkStr: String?)-> Network {
        switch (networkStr) {
        case "TESTNET" : return  Network.testnet
        case "BITCOIN" : return Network.bitcoin
        case  "REGTEST": return  Network.regtest
        case  "SIGNET":return Network.signet
        default : return Network.testnet

        }
    }
    
    
    private func createDefaultDescriptor(keys: ExtendedKeyInfo)-> String {
            return ("wpkh(" + keys.xprv + "/84'/1'/0'/0/*)")
        }

        private func createDefaultChangeDescriptor(keys: ExtendedKeyInfo)-> String {
            return ("wpkh(" + keys.xprv + "/84'/1'/0'/1/*)")
        }
    
    
    private  func createRestoreWallet(keys: ExtendedKeyInfo, network:String, blockChainConfigUrl: String?, blockChainSocket5: String?,retry: String?, timeOut: String?, blockChain: String?, walletDescriptor: String?) throws -> Wallet {
        do{
            let descriptor: String = walletDescriptor ?? createDefaultDescriptor(keys: keys)
            let changeDescriptor: String = createDefaultChangeDescriptor(keys: keys)
            print(keys.xprv )
            let config: BlockchainConfig = createDatabaseConfig(blockChainConfigUrl: blockChainConfigUrl, blockChainSocket5: blockChainSocket5, retry: retry, timeOut: timeOut, blockChain: blockChain)
            let walletNetwork: Network = setNetwork(networkStr: network)
            self.wallet = try Wallet.init(
                descriptor: defaultDescriptor,
                changeDescriptor: defaultChangeDescriptor,
                network: walletNetwork,
                databaseConfig: databaseConfig)
            self.sync(config: config)
            return self.wallet
        } catch {
            throw error
        }
    }
    
    
    private func createDatabaseConfig(
        blockChainConfigUrl: String?, blockChainSocket5: String?,
        retry: String?, timeOut: String?, blockChain: String?
    )-> BlockchainConfig {
        switch (blockChain) {
        case  "ELECTRUM" : return  BlockchainConfig.electrum(config:
                                                                ElectrumConfig(
                                                                    url: blockChainConfigUrl ?? self.defaultBlockChainConfigUrl, socks5: blockChainConfigUrl,
                                                                    retry: UInt8(retry ?? "") ?? 5, timeout: UInt8(timeOut ?? "") ?? 5,
                                                                    stopGap: 5
                                                                )
        )
        case "ESPLORA" :return  BlockchainConfig.esplora(config:
                                                            EsploraConfig(
                                                                baseUrl: blockChainConfigUrl ?? self.defaultBlockChainConfigUrl, proxy: nil,
                                                                concurrency: UInt8(retry ?? "") ?? 5, stopGap: UInt64(timeOut ?? "") ?? 5,
                                                                timeout: 5
                                                            )
        )
        default: return blockchainConfig


        }
    }


    func genSeed(password: String? = nil) throws -> ExtendedKeyInfo {
            do {
                let seed = try _seed(recover: false, mnemonic: "" )
                return seed

            } catch {
                throw error
            }
        }


    func createWallet(mnemonic: String? = "", password: String? = nil, network:String?, blockChainConfigUrl: String?, blockChainSocket5: String?,retry: String?, timeOut: String?, blockChain: String?, walletDescriptor: String? ) throws -> [String: Any?] {
            do {
                let keys: ExtendedKeyInfo = try _seed(recover: false, mnemonic: mnemonic, password: password)
               try createRestoreWallet(keys: keys, network: network!, blockChainConfigUrl: blockChainConfigUrl, blockChainSocket5: blockChainSocket5, retry:retry, timeOut: timeOut, blockChain: blockChain ?? defaultBlockChain, walletDescriptor: walletDescriptor)

                let responseObject = [
                    "address": self.wallet.getNewAddress() ,
                    "balance": try! self.wallet.getBalance(),
                    "mnemonic": mnemonic ?? "",
                ] as [String : Any]
                return responseObject
            }
            catch {
                throw error
            }
        }

    
        func restoreWallet(mnemonic: String? = "", password: String? = nil, network:String?, blockChainConfigUrl: String?, blockChainSocket5: String?,retry: String?, timeOut: String?, blockChain: String?, walletDescriptor: String? ) throws -> [String: Any?] {
            do {
                let keys: ExtendedKeyInfo = try _seed(recover:  true, mnemonic: mnemonic, password: password)
                let wallet = try createRestoreWallet(keys: keys, network: network!, blockChainConfigUrl: blockChainConfigUrl!, blockChainSocket5: blockChainSocket5!, retry:retry!, timeOut: timeOut!, blockChain: blockChain ?? defaultBlockChain, walletDescriptor: walletDescriptor)
                let responseObject = [
                    "address": wallet.getNewAddress() ,
                    "balance": try! wallet.getBalance(),
                    "mnemonic": mnemonic ?? "",
                ] as [String : Any]
                return responseObject
            }
            catch {
                throw error
            }
        }

    
    func getWallet()throws -> [String: Any?]{
        do {
           
            let responseObject = [
                "address": wallet.getNewAddress() ,
                "balance": try self.getBalance()
            ] as [String : Any]
            return responseObject
        }
        catch {
            throw error
        }
    }
        

    func getNewAddress() -> String{
        return self.wallet.getNewAddress()
    }
    func getLastUnusedAddress() -> String{
        return self.wallet.getLastUnusedAddress()
    }
    
    func getNetwork() -> Network{
            return self.wallet.getNetwork()
    }

    
 func getBalance() throws -> String {
     do {
        
         try! self.wallet.sync(blockchain: Blockchain.init(config: blockchainConfig), progress: BdkProgress())
                
         let balance = try self.wallet.getBalance()
         return String(balance)
            }
            catch {
                throw error
            }
        }
    
    /// Todo the following functions correct
    func confirmedTransactionsList() throws -> Array<[String: Any?]> {
        return []
    }
    
    
    func pendingTransactionsList() throws -> Array<[String: Any?]> {
        //            do {
        //                let wallet_transactions: Transaction = try wallet.getTransactions()
        //                Transaction.unconfirmed(details: )
        ////                var transactions = wallet_transactions.sorted(by: {
        ////                    switch $0 {
        ////                    case .confirmed(_, let confirmation_a):
        ////                        switch $1 {
        ////                        case .confirmed(_, let confirmation_b): return confirmation_a.timestamp > confirmation_b.timestamp
        ////                        default: return false
        ////                        }
        ////                    default:
        ////                        switch $1 {
        ////                        case .unconfirmed(_): return true
        ////                        default: return false
        ////                        }
        ////                    } })
        //
        //
        //                if (wallet_transactions.isEmpty) {
        //
        //                    return []
        //                } else {
        //                    var unconfirmedTransactions : Array<[String: Any?]>
        //                    for var transaction:Transaction  in wallet_transactions {
        //                        var responseObject = [String: Any?]()
        //                        responseObject["received"] = transaction.
        //                        responseObject["sent"] = item.details.sent.toString()
        //                        responseObject["fees"] = item.details.fees.toString()
        //                        responseObject["txid"] = item.details.txid
        //                        unconfirmedTransactions.add(responseObject)
        //                    }
        //
        //                    return unconfirmedTransactions
        //                }
        //            } catch (error: Throwable) {
        //                throw(error)
        //            }

        return []
    }

    
    func broadcastTx(_ recipient: String, amount: NSNumber)  throws -> String {
           do {
               let txBuilder = TxBuilder().addRecipient(address: recipient, amount: UInt64(truncating: amount))
               let psbt = try txBuilder.finish(wallet: wallet)
               try wallet.sign(psbt: psbt)
               try blockChain.broadcast(psbt: psbt)
               let txid = psbt.txid()
               return  txid;
           }   catch {
               throw error
           }
       }
   }


