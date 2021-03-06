//
//  Bdk.swift
//  bdk_flutter
//

import Foundation
class Bdk {
    let bdkFunctions = BdkFunctions()
    let TAG = "BDK-F"
    func sync() {
        print("Wallet Syncing")
        bdkFunctions.sync(config: nil)
    }

    
    func getNewAddress(result: FlutterResult) {
        print("Getting new address")
        let address = bdkFunctions.getNewAddress()
        return  result(address)

    }
    
    
    func getLastUnusedAddress(result: FlutterResult) {
        print("Getting new address")
        let address = bdkFunctions.getLastUnusedAddress()
        return  result(address)

    }

    
    func getWallet(result: FlutterResult) {
        do{
            return  try result(bdkFunctions.getWallet())

        } catch let error {
            result(FlutterError( code: "Get Balance Error",
                                 message: error.localizedDescription,
                                 details: error ))
        }
    }

    
    func getBalance(result: FlutterResult) {
        do{
            return  try result(bdkFunctions.getBalance())

        } catch let error {
            result(FlutterError( code: "Get Balance Error",
                                 message: error.localizedDescription,
                                 details: error ))
        }
    }
    

    func genSeed( result: @escaping FlutterResult) {
        do{
            return  try result(bdkFunctions.genSeed(password:nil))

        } catch let error {
            result(FlutterError( code: "Generate Seed Error",
                                 message: error.localizedDescription,
                                 details: error ))
        }
    }

    func createWallet(
        arguments:Dictionary<String,Any?>, result: @escaping FlutterResult
    ) {
        let mnemonic = arguments["mnemonic"]  ?? ""
        let password  = arguments["password"]  ?? ""
        let network  = arguments["network"]  ?? ""
        let blockChainConfigUrl = arguments["network"]  ?? ""
        let blockChainSocket5 = arguments["blockChainSocket5"]  ?? ""
        let retry = arguments["retry"] ?? ""
        let timeOut = arguments["timeOut"] ?? ""
        let blockChain = arguments["blockChain"]  ?? ""
        let walletDescriptor = arguments["walletDescriptor"]  ?? ""

        do{
            let responseObject =   try bdkFunctions.createWallet(mnemonic: (mnemonic as? String), password: password as? String, network: network as? String, blockChainConfigUrl: blockChainConfigUrl as? String, blockChainSocket5: blockChainSocket5 as? String, retry: (retry as? String), timeOut:timeOut as? String, blockChain: (blockChain as? String), walletDescriptor: walletDescriptor as? String)

            return result(responseObject)
        } catch let error {
            result(FlutterError( code: "Create Wallet Error",
                                 message: error.localizedDescription,
                                 details: error ))
        }
    }

    func restoreWallet(
        arguments:Dictionary<String,Any?>, result: @escaping FlutterResult
    ) {
        let mnemonic = arguments["mnemonic"]  ?? ""
        let password  = arguments["password"]  ?? ""
        let network  = arguments["network"]  ?? ""
        let blockChainConfigUrl = arguments["network"]  ?? ""
        let blockChainSocket5 = arguments["blockChainSocket5"]  ?? ""
        let retry = arguments["retry"] ?? ""
        let timeOut = arguments["timeOut"] ?? ""
        let blockChain = arguments["blockChain"]  ?? ""
        let walletDescriptor = arguments["walletDescriptor"]  ?? ""

        do{
            let responseObject =   try bdkFunctions.restoreWallet(
                mnemonic: (mnemonic as? String),
                password: password as? String,
                network: network as? String,
                blockChainConfigUrl: blockChainConfigUrl as? String,
                blockChainSocket5: blockChainSocket5 as? String, retry: (retry as? String),
                timeOut:timeOut as? String,
                blockChain: (blockChain as? String),
                walletDescriptor: walletDescriptor as? String)

            return result(responseObject)
        } catch let error {
            result(FlutterError( code: "Retore Wallet Error",
                                 message: error.localizedDescription,
                                 details: error ))
        }
    }
           
    func broadcastTx(arguments:[String:Any], result: @escaping FlutterResult ) {
               let recipient = arguments["recipient"]  ?? ""
               let amount  = arguments["amount"]  ?? 0
                         
               do{
                   let responseObject =  try bdkFunctions.broadcastTx(recipient as! String, amount: amount as! NSNumber)
                   print(responseObject)

                   return result(responseObject)
               } catch let error {
                   print(error)
                   result("Broadcast Error")
               }
           }
    //
    //
    //            fun getConfirmedTransactions(result: FlutterResult) {
    //                try {
    //                    val transactions = BdkFunctions.confirmedTransactionsList()
    //                    Log.i("Progress Log Confirmed Transactions Success", transactions.toString())
    //                    result.success(transactions)
    //
    //                } catch (error: Throwable) {
    //                    return result.error("Get confirmed Transactions Error", error.localizedMessage, error)
    //                }
    //            }
    //
    //            fun getPendingTransactions(result: FlutterResult) {
    //                try {
    //                    val transactions = BdkFunctions.pendingTransactionsList()
    //                    Log.i("Progress Log Pending Transactions Success", transactions.toString())
    //                    result.success(transactions)
    //                } catch (error: Throwable) {
    //                    return result.error("Get Pending TransactionsError", error.localizedMessage, error)
    //                }
    //            }
    //


    func handleMethodCalls(arguments:[String:Any], result: @escaping FlutterResult, method:String ) {
        print(arguments)
        switch (method) {
        case "genSeed" : self.genSeed(result:result)
        case "getWallet":  self.getWallet(result: result)
        case "walletExists":  result(true)
        case "unlockWallet":  self.getWallet(result: result)
        case "resetWallet":  self.getWallet(result: result)
        case "createWallet":  self.createWallet(arguments: arguments, result: result)
        case "restoreWallet":  self.restoreWallet(arguments: arguments, result: result)
        case "getNewAddress":  self.getNewAddress(result: result)
        case "getLastUnusedAddress":  self.getLastUnusedAddress(result: result)
        case "getBalance":  self.getBalance(result: result)
        case "getPendingTransactions":  try? bdkFunctions.pendingTransactionsList()
        case "getConfirmedTransactions":  try? bdkFunctions.confirmedTransactionsList()
        case"broadcastTx":     self.broadcastTx( arguments: arguments, result:result)
        case "sync":  self.sync()
        
        default :  result("No method Found for" + method)
        }
    }
}

