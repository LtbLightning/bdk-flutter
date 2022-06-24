package io.bdk.f.bdk_flutter
import android.util.Log
import io.flutter.plugin.common.MethodChannel.Result

object Bdk {
    const val TAG = "BDK-F"
    fun sync(maxAddress: UInt? = null): Unit {
        BdkFunctions.sync()
    }

    fun getWallet(result: Result) {
        try {
            val wallet  = BdkFunctions.getWallet()
            Log.i(wallet.toString(), "Progress Log Get Wallet")
            result.success(wallet)
        } catch (error: Throwable) {
            return result.error("Get Wallet Error", error.localizedMessage, error)
        }
    }
    fun restoreWallet(
            mnemonic: String, password: String?, network: String?,
            blockChainConfigUrl: String, blockChainSocket5: String?,
            retry: String?, timeOut: String?, blockChain: String?, result: Result
    ) {
        try {
            val responseObject = BdkFunctions.restoreWallet(
                    mnemonic, password, network,
                    blockChainConfigUrl, blockChainSocket5, retry, timeOut, blockChain, null
            )
            Log.i(responseObject.toString(), " Progress Log Restore Success")
            result.success(responseObject)
        } catch (error: Throwable) {
            Log.i(error.toString(), "Progress Log Restore Failure")
            return result.error("Restore Wallet Error", error.localizedMessage, error)
        }
    }

    fun getNewAddress(result: Result) {
        try {
            val address: String = BdkFunctions.getNewAddress()
            Log.i(address, "Progress Log Address")
            result.success(address)
        } catch (error: Throwable) {
            return result.error("Get address Error", error.localizedMessage, error)
        }
    }

    fun getBalance(result: Result) {
        try {
            val balance: String = BdkFunctions.getBalance()
            result.success(balance)
        } catch (error: Throwable) {
            return result.error("Get Balance Error", error.localizedMessage, error)
        }
    }

    fun genSeed(password: String?, result: Result) {
        try {
            val seed = BdkFunctions.seed(false)
            result.success(seed.mnemonic)
        } catch (error: Throwable) {
            return result.error("Gen Seed Error", error.localizedMessage, error)
        }
    }

    fun createWallet(
            mnemonic: String, password: String?, network: String?,
            blockChainConfigUrl: String, blockChainSocket5: String?,
            retry: String?, timeOut: String?, blockChain: String?, result: Result
    ) {
        return try {
            val responseObject = BdkFunctions.createWallet(
                    mnemonic, password, network,
                    blockChainConfigUrl, blockChainSocket5, retry, timeOut, blockChain, null
            )
            Log.i(responseObject.toString(), "Progress Log Create Wallet Success")
            result.success(responseObject)
        } catch (error: Throwable) {
            return result.error("Create Wallet Error", error.localizedMessage, error)
        }

    }




    fun broadcastTx(recipient: String, amount: Double, result: Result) {
        try {
            val transaction: String = BdkFunctions.broadcastTx(recipient, amount)
            Log.i(TAG, "Successfully broadcast $amount")
            result.success(transaction)
        } catch (error: Throwable) {
            return result.error("Broadcast Transaction Error", error.message, error.cause)
        }
    }
    fun createAndSign(recipient: String, amount: Double, result: Result) {
        try {
            val psbt: String = BdkFunctions.createPartiallySignedBitcoinTransaction(recipient, amount)
            Log.i(TAG, "Successfully Psbt $psbt")
            result.success(psbt)
        } catch (error: Throwable) {
            return result.error("Psbt Error", error.message, error.cause)
        }
    }


    fun getConfirmedTransactions(result: Result) {
        try {
            val transactions = BdkFunctions.confirmedTransactionsList()
            Log.i("Progress Log Confirmed Transactions Success", transactions.toString())
            result.success(transactions)

        } catch (error: Throwable) {
            return result.error("Get confirmed Transactions Error", error.localizedMessage, error)
        }
    }

    fun getPendingTransactions(result: Result) {
        try {
            val transactions = BdkFunctions.pendingTransactionsList()
            Log.i("Progress Log Pending Transactions Success", transactions.toString())
            result.success(transactions)
        } catch (error: Throwable) {
            return result.error("Get Pending TransactionsError", error.localizedMessage, error)
        }
    }

    fun resetWallet(result: Result) {
        try {
            Log.i(BdkFunctions.resetWallet().toString(), "Progress Log resetWallet Success")
            result.success(BdkFunctions.resetWallet())

        } catch (error: Throwable) {
            return result.error("Progress Log resetWallet Error", error.localizedMessage, error)
        }
    }

//    private fun handleWalletExists(result: Result) {
//        result.success(null == getWallet(result))
//    }
//    fun handleMethodCall(@NonNull method: String, @NonNull result: Result, arguments: Map<String, Any>?) {
//        when (method) {
//            "genSeed" -> genSeed(null, result)
//            "getWallet" -> getWallet(result)
//            "walletExists" -> handleWalletExists(result)
//            "createWallet" -> handleCreateWallet(call, result)
//            "restoreWallet" -> handleRestoreWallet(call, result)
//            "resetWallet" -> Bdk.resetWallet(result)
//            "getBalance" -> Bdk.getBalance(result)
//            "getPendingTransactions" -> Bdk.getPendingTransactions(result)
//            "getConfirmedTransactions" -> Bdk.getConfirmedTransactions(result)
//            "sync" -> Bdk.sync()
//            "broadcastTx" -> handleBroadcastTx(call, result)
//            "getNewAddress" -> Bdk.getNewAddress(result)
//            else -> {
//                result.notImplemented()
//            }
//        }


}
