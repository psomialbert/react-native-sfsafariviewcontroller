#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RCTSFSafariViewController, NSObject)

RCT_EXTERN_METHOD(openURL: (NSString *)urlString
                  params:(NSDictionary *)params)
RCT_EXTERN_METHOD(close)

@end
