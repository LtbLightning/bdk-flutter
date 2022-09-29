
const MIN_WORD_COUNT= 6;
const MAX_WORD_COUNT = 24;
const MIN_ENTROPY_BIT= 128;
const MAX_ENTROPY_BIT = 256;
bool isValidMnemonic(String mnemonic){
 var strLen = mnemonic.split(' ').length;
 return ((strLen>=12)&&(strLen<=24)&&strLen%6==0);
}
bool isBadWordCount(int wordCount){
 final isNotValid = wordCount < MIN_WORD_COUNT || wordCount % 6 != 0 || wordCount > MAX_WORD_COUNT;
 return isNotValid;
}
bool isBadEntropyBitCount(int wordCount){
 final isNotValid = wordCount < MIN_ENTROPY_BIT || wordCount % 64 != 0 || wordCount > MAX_ENTROPY_BIT;
 return isNotValid;
}

bool isUnknownWord(String mnemonic){
 var strLen = mnemonic.split(' ').length;
 return true;
}