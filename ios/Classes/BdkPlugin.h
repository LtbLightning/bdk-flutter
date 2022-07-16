#import <Flutter/Flutter.h>

@interface BdkPlugin : NSObject<FlutterPlugin>
@end



char *rust_greeting(const char *to);

