import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bdk_flutter/bdk_flutter.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatefulWidget {
 const MyApp({super.key});

 @override
 State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 String walletBalance = 'error';
 String wallet = '';
 String address = '';
 final _bdkFlutterPlugin = BdkFlutter();

 @override
 void initState() {
   super.initState();
   initPlatformState();
  // getNewAddress();
 }

 Future<void> initPlatformState() async {
   try {
     walletBalance = (await _bdkFlutterPlugin.getBalance())!;
     wallet = (await _bdkFlutterPlugin.getWallet())!;
     setState(()  {

     });

   } catch (e) {
     print(e);
     walletBalance = 'Error Balance';
   }

 }

 createWallet() async {
   await _bdkFlutterPlugin.createWallet(mnemonic: "test", password: "test")
       .then((i) => print(i));
   setState(() {

   });
 }
 sync() async {
   await _bdkFlutterPlugin.sync()
       .then((i) => print(i));
   setState(() {
     initPlatformState();
   });
 }

 getNewAddress() async {
   await _bdkFlutterPlugin.getNewAddress()
       .then((i) {
     setState(() {
       address= i.toString();
     });
         print(i);
   });
 }
 getTransactions() async {
   await _bdkFlutterPlugin.getConfirmedTransactions()
       .then((i) {
     print(i);
   });
 }


 sendBit() async {
   await _bdkFlutterPlugin.broadcastTransaction(recipient: 'tb1ql7w62elx9ucw'
       '4pj5lgw4l028hmuw80sndtntxt', amount:  9000)
       .then((i) {
     setState(() {
       initPlatformState();
     });
   });
 }

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: const Text('Plugin example app'),
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(wallet),
             Text('Balance: $walletBalance\n'),
             Text('Address: $address\n'),
             TextButton(onPressed: () => createWallet(),
                 child: const Text('Press to create new Wallet')),
             TextButton(onPressed: () => getNewAddress(),
                 child: const Text('Press to create new Address')),
             TextButton(onPressed: () => sendBit(),
                 child: const Text('Press to  send 0.00001 satoshi')),
             TextButton(onPressed: () => sync(),
                 child: const Text('Press to  sync')),
             TextButton(onPressed: () => getTransactions(),
                 child: const Text('Get Transactions')),
           ],
         ),
       ),
     ),
   );
 }


}
