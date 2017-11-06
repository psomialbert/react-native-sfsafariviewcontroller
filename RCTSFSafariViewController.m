#import "RCTSFSafariViewController.h"

@implementation RCTSFSafariViewController

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
  controller.delegate = nil;
  [self.bridge.eventDispatcher sendAppEventWithName:@"SFSafariViewControllerDismissed" body:nil];
}

RCT_EXPORT_METHOD(openURL: (NSString *)urlString params:(NSDictionary *)params) {
  NSURL *url = [[NSURL alloc] initWithString: urlString];

    dispatch_async(dispatch_get_main_queue(), ^{
      UIViewController *rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
      while(rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
      }

      SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:safariViewController];

      [navigationController setNavigationBarHidden:YES animated:NO];
      safariViewController.delegate = self;

      if ([params objectForKey:@"tintColor"]) {
        UIColor *tintColor = [RCTConvert UIColor:params[@"tintColor"]];

        if([safariViewController respondsToSelector:@selector(setPreferredControlTintColor:)]) {
          safariViewController.preferredControlTintColor = tintColor;
        } else {
          safariViewController.view.tintColor = tintColor;
        }
      }

    [rootViewController presentViewController:navigationController animated:YES completion:^{
      [self.bridge.eventDispatcher sendDeviceEventWithName:@"SFSafariViewControllerDidLoad" body:nil];
    }];
  });
}

RCT_EXPORT_METHOD(close) {
    dispatch_async(dispatch_get_main_queue(), ^{
      UIViewController *rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        UIViewController *rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        while(rootViewController.presentedViewController) {
            rootViewController = rootViewController.presentedViewController;
        }
        if(rootViewController == nil || rootViewController.childViewControllers.count == 0) {
            return;
        }
        SFSafariViewController *safariViewController = (SFSafariViewController*)rootViewController.childViewControllers[0];
        safariViewController.delegate = nil;
        [rootViewController dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
