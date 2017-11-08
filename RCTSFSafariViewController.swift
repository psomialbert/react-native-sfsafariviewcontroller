//
//  RCTSFSafariViewController.swift
//  RCTSFSafariViewController
//
//  Created by Albert Schapiro on 08/11/2017.
//  Copyright © 2017 Albert Schapiro. All rights reserved.
//

import Foundation
import SafariServices
import React

@objc(RCTSFSafariViewController)
class RCTSFSafariViewController: NSObject {

    @objc var bridge: RCTBridge!

    fileprivate var viewController: UIViewController?

    fileprivate override init() {
        super.init()
        bridge = RCTBridge(delegate: self, launchOptions: nil)
    }

    @objc(openURL:params:)
    func openURL(_ urlString: String, params: [AnyHashable: Any]) -> Void {
        guard let url = URL(string:urlString) else {
            print("couldn't create URL")
            return
        }
        DispatchQueue.main.async {
            var rootViewController = UIApplication.shared.delegate?.window??.rootViewController
            if rootViewController == nil {
                print("error couldn't get window.rootViewController!")
                return
            }

            while(rootViewController?.presentedViewController != nil) {
                rootViewController = rootViewController?.presentedViewController
            }

            if #available(iOS 9, *) {
                let safariViewController = SFSafariViewController(url: url)
                self.viewController = safariViewController

                let navigationController = UINavigationController(rootViewController: safariViewController)
                navigationController.setNavigationBarHidden(true, animated: false)
                safariViewController.delegate = self

                if (params["tintColor"] != nil) {
                    if let tintColor = RCTConvert.uiColor(params["tintColor"]) {
                        if #available(iOS 10.0, *) {
                            safariViewController.preferredControlTintColor = tintColor
                        } else {
                            safariViewController.view.tintColor = tintColor
                        }
                    }
                }

                rootViewController?.present(navigationController, animated: true, completion: nil)
            }
            //            rootViewController.present(navigationController, animated: true, completion: { () -> Void in
            //                self.bridge.eventDispatcher.sendDeviceEventWithName("SFSafariViewControllerDidLoad", body: nil)
            //            })
        }
    }

    @objc(close)
    func close() {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: true, completion: {
                print("dismissed safariViewController")
                if #available(iOS 9, *) {
                    if let safariViewController = self.viewController as? SFSafariViewController {
                        safariViewController.delegate = nil
                    }
                }
                self.viewController = nil
            })
        }
    }
}

extension RCTSFSafariViewController: RCTBridgeModule {

    static func moduleName() -> String! {
        return "RCTSFSafariViewController"
    }

    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

extension RCTSFSafariViewController: RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge!) -> URL! {
        #if IOS_SIMULATOR && DEBUG
            return URL(string: "http://localhost:8081/index.ios.bundle?platform=ios")
        #endif
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    }
}

extension RCTSFSafariViewController : SFSafariViewControllerDelegate {
    /*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the view controller is dismissed modally. */
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("safariViewControllerDidFinish")
        controller.delegate = nil
        self.bridge.eventDispatcher().sendAppEvent(withName: "SFSafariViewControllerDismissed", body:nil)
        viewController = nil
    }


    /*! @abstract Invoked when the initial URL load is complete.
     @param didLoadSuccessfully YES if loading completed successfully, NO if loading failed.
     @discussion This method is invoked when SFSafariViewController completes the loading of the URL that you pass
     to its initializer. It is not invoked for any subsequent page loads in the same SFSafariViewController instance.
     */
    @available(iOS 9.0, *)
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("safariViewController didLoadSuccessfully: \(didLoadSuccessfully)")

        bridge.eventDispatcher().sendAppEvent(withName: "SFSafariViewControllerDidLoad", body: ["success": didLoadSuccessfully])
    }


    /*! @abstract Called when the browser is redirected to another URL before the first page load finishes.
     @param URL The new URL to which the browser was redirected.

     */
    @available(iOS 11.0, *)
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print("safariViewController initialLoadDidRedirectTo: \(URL.absoluteString)")
        bridge.eventDispatcher().sendAppEvent(withName: "SFSafariViewControllerDidRedirectTo", body: ["url": URL.absoluteString])
    }

}
