package io.bdk.f.bdk_flutter

import android.os.AsyncTask
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

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
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bdk_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "genSeed" -> Bdk.genSeed(null, result)
      "getWallet" -> Bdk.getWallet(result)
      "walletExists" -> handleWalletExists(result)
      "unlockWallet" -> handleUnlockWallet(call, result)
      "createWallet" -> handleCreateWallet(call, result)
      "restoreWallet" -> handleRestoreWallet(call, result)
      "resetWallet" -> handleResetWallet(call, result)
      "getBalance" -> Bdk.getBalance(result)
      "getTransactions" -> Bdk.getTransactions(result)
      "sync" -> Bdk.sync();
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
      val amount = call.argument<Double>("amount")?.toDouble();
      if (amount != null) {
        Bdk.broadcastTx(recipient, amount, result)
      }
    }.execute()
  }

  private fun handleResetWallet(call: MethodCall, result: MethodChannel.Result) {

  }


  private fun handleRestoreWallet(call: MethodCall, result: Result) {
    @Suppress("DEPRECATION")
    DdoAsync {
      val password = call.argument<String>("password").toString()
      val mnemonic = call.argument<String>("mnemonic").toString()
      Bdk.restoreWallet(mnemonic, password, result)
    }.execute()
  }

  private fun handleCreateWallet(call: MethodCall, result: Result) {
    @Suppress("DEPRECATION")
    DdoAsync {
      val password = call.argument<String>("password").toString()
      val mnemonic = call.argument<String>("mnemonic").toString()
      Bdk.createWallet(mnemonic, password, result)
    }.execute()
  }


  private fun handleUnlockWallet(call: MethodCall, result: Result) {
     // TODO
    @Suppress("DEPRECATION")
    DdoAsync {
      val password = call.argument<String>("password").toString()
      val mnemonic = call.argument<String>("mnemonic").toString()
      Bdk.restoreWallet(mnemonic, password, result)
    }.execute()
  }

  private fun handleWalletExists( result: Result) {
   result.success(null == Bdk.getWallet(result))
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
