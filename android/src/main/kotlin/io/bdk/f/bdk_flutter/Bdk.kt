package io.bdk.f.bdk_flutter

import android.util.Log
import io.flutter.plugin.common.MethodChannel.Result
import org.bitcoindevkit.*
import org.bitcoindevkit.Wallet as BdkWallet

object Bdk {
    private lateinit var wallet: BdkWallet
    private lateinit var path: String
    private const val externalDescriptor =
        "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)"
    private const val internalDescriptor =
        "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/1/*)"
    private val databaseConfig = DatabaseConfig.Memory
    private val blockchainConfig =
        BlockchainConfig.Electrum(
            ElectrumConfig("ssl://electrum.blockstream.info:60002", null, 5u, null, 10u)
        )
    private var nodeNetwork = Network.TESTNET

    object ProgressLog : BdkProgress {
        override fun update(progress: Float, message: String?) {
            Log.i(progress.toString(), "Progress Log")
        }
    }

    fun setPath(path: String) {
        Bdk.path = path
    }

    //Init wallet
    init {
        this.wallet = BdkWallet(
            externalDescriptor,
            internalDescriptor,
            nodeNetwork,
            databaseConfig,
            blockchainConfig
        )
        sync()
    }

    private fun createDescriptor(keys: ExtendedKeyInfo): String {
        return "wpkh(" + keys.xprv + "/84'/1'/0'/0/*)"
    }

    private fun createChangeDescriptor(keys: ExtendedKeyInfo): String {
        return "wpkh(" + keys.xprv + "/84'/1'/0'/1/*)"
    }
    private fun _seed(
        recover: Boolean = false,
        mnemonic: String = "",
        password: String? = null
    ): ExtendedKeyInfo {
        return if (!recover) generateExtendedKey(
            nodeNetwork,
            WordCount.WORDS12,
            password
        ) else restoreExtendedKey(nodeNetwork, mnemonic, password)
    }


    fun sync(maxAddress: UInt?=null): Unit {
        Log.i("Wallet", "Wallet is syncing")
        this.wallet.sync(ProgressLog, maxAddress)
    }


    private fun createRestoreWallet(keys: ExtendedKeyInfo) {
        try {
            val descriptor: String = createDescriptor(keys)
            val changeDescriptor: String = createChangeDescriptor(keys)
            wallet = BdkWallet(
                descriptor,
                changeDescriptor,
                nodeNetwork,
                databaseConfig,
                blockchainConfig
            )
            sync();
        } catch (error: Error) {
            throw error
        }
    }

    fun getWallet(result: Result) {
        try {
            result.success(wallet.toString())
        } catch (error: Throwable) {
            return result.error("Get Wallet Error", error.localizedMessage, error)
        }
    }

    fun genSeed(password: String?, result: Result) {
        try {
            val seed = _seed(false)
            result.success(seed.mnemonic)
        } catch (error: Throwable) {
            return result.error("Gen Seed Error", error.localizedMessage, error)
        }
    }

    fun createWallet(mnemonic: String, password: String?, result: Result) {
        return try {
            val keys: ExtendedKeyInfo = _seed(false, mnemonic, password)
            createRestoreWallet(keys)
            val responseObject = mutableMapOf<String, Any?>()
            responseObject["address"] = wallet.getNewAddress()
            responseObject["mnemonic"] = keys.mnemonic
            responseObject["balance"] = wallet.getBalance().toLong()
            Log.i(responseObject.toString(), "Progress Log Create Success")
            result.success(responseObject)
        } catch (error: Throwable) {
            return result.error("Create Wallet Error", error.localizedMessage, error)
        }

    }

    fun restoreWallet(mnemonic: String, password: String? = null, result: Result) {
        try {
            val keys: ExtendedKeyInfo = _seed(true, mnemonic, password)
            createRestoreWallet(keys)
            val responseObject = mutableMapOf<String, Any?>()
            responseObject["address"] = wallet.getNewAddress()
            responseObject["balance"] = wallet.getBalance().toString()
            responseObject["transactions"] = wallet.getTransactions();
            result.success(responseObject);
            Log.i(responseObject.toString(), "Progress Log Restore Success")
        } catch (error: Throwable) {
            Log.i(error.toString(), "Progress Log Restore Failure")
            return result.error("Restore Wallet Error", error.localizedMessage, error)
        }
    }

    fun getNewAddress(result: Result) {
        Log.i(wallet.getNewAddress(), "Progress Log Address")
        result.success(wallet.getNewAddress())
    }

    fun getBalance(result: Result) {
        try {
            sync()
            val balance = this.wallet.getBalance().toString()
            result.success(balance)
        } catch (error: Throwable) {
            return result.error("Get Balance Error", error.localizedMessage, error)
        }
    }

    fun broadcastTx(recipient: String, amount: Double, result: Result) {
        try {
            val longAmt: Long = amount.toLong()
            val psbt = PartiallySignedBitcoinTransaction(wallet, recipient, longAmt.toULong(), null)
            wallet.sign(psbt)
            val transaction: String = wallet.broadcast(psbt)
            result.success(transaction)
        } catch (error: Throwable) {
            return result.error("Transaction Error", error.localizedMessage, error)
        }
    }



    fun getTransactions(result: Result) {
        try {
            sync()
            val transactions = wallet.getTransactions().toList();
            result.success(transactions)
        } catch (error: Throwable) {
            return result.error("Get Transactions Error", error.localizedMessage, error)
        }
    }
    fun getLastUnusedAddress(): String = wallet.getLastUnusedAddress()
}