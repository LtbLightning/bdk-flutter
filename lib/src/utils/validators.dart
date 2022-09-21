import 'package:bdk_flutter/src/utils/exceptions/key_exceptions.dart';

bool isValidMnemonic(String mnemonic){
 var strLen = mnemonic.split(' ').length;
 return ((strLen>=12)&&(strLen<=24)&&strLen%6==0);
}