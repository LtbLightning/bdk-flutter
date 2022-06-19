package io.bdk.f.bdk_flutter
import io.flutter.plugin.common.MethodChannel.Result
import android.os.AsyncTask
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** BdkPlugin */
@Suppress("DEPRECATION")
class DdoAsync(val handler: () -> Unit) : AsyncTask<Void, Void, Void>() {
    @Deprecated("Deprecated in Java")
    override fun doInBackground(vararg params: Void?): Void? {
        handler()
        return null
    }
}

class BdkPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bdk_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "genSeed" -> Bdk.genSeed(null, result)
            "getWallet" -> Bdk.getWallet(result)
            "walletExists" -> handleWalletExists(result)
            "unlockWallet" -> handleUnlockWallet(call, result)
            "createWallet" -> handleCreateWallet(call, result)
            "restoreWallet" -> handleRestoreWallet(call, result)
            "resetWallet" -> Bdk.resetWallet(result)
            "getBalance" -> Bdk.getBalance(result)
            "getPendingTransactions" -> Bdk.getPendingTransactions(result)
            "getConfirmedTransactions" -> Bdk.getConfirmedTransactions(result)
            "sync" -> Bdk.sync()
            "broadcastTx" -> handleBroadcastTx(call, result)
            "getNewAddress" -> Bdk.getNewAddress(result)
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun handleBroadcastTx(call: MethodCall, result: Result) {

        @Suppress("DEPRECATION")
        DdoAsync {
            val recipient = call.argument<String>("recipient").toString()
            val amount = call.argument<Double>("amount")?.toDouble()
            if (amount != null) {
                Bdk.broadcastTx(recipient, amount, result)
            }
        }.execute()
    }


    private fun handleRestoreWallet(call: MethodCall, result: Result) {
        @Suppress("DEPRECATION")
        DdoAsync {
            val password = call.argument<String>("password").toString()
            val mnemonic = call.argument<String>("mnemonic").toString()
            val network = call.argument<String>("network").toString()
            val blockChainConfigUrl = call.argument<String>("blockChainConfigUrl").toString()
            val blockChainSocket5 = call.argument<String>("blockChainSocket5").toString()
            val retry = call.argument<String>("retry").toString()
            val timeOut = call.argument<String>("timeOut").toString()
            val blockChain = call.argument<String>("blockChain").toString()

            Bdk.restoreWallet(
                mnemonic, password, network, blockChainConfigUrl, blockChainSocket5, retry,
                timeOut, blockChain, result
            )
        }.execute()
    }

    private fun handleCreateWallet(call: MethodCall, result: Result) {
        @Suppress("DEPRECATION")
        DdoAsync {
            val password = call.argument<String>("password").toString()
            val mnemonic = call.argument<String>("mnemonic").toString()
            val network = call.argument<String>("network").toString()
            val blockChainConfigUrl = call.argument<String>("blockChainConfigUrl").toString()
            val blockChainSocket5 = call.argument<String>("blockChainSocket5").toString()
            val retry = call.argument<String>("retry").toString()
            val timeOut = call.argument<String>("timeOut").toString()
            val blockChain = call.argument<String>("blockChain").toString()

            Bdk.createWallet(
                mnemonic, password, network, blockChainConfigUrl, blockChainSocket5, retry,
                timeOut, blockChain, result
            )
        }.execute()
    }


    private fun handleUnlockWallet(call: MethodCall, result: Result) {
        // TODO
        @Suppress("DEPRECATION")
        DdoAsync {
            Bdk.resetWallet(result)
        }.execute()
    }

    private fun handleWalletExists(result: Result) {
        result.success(null == Bdk.getWallet(result))
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
