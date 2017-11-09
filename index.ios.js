/**
 * @providesModule RCTSFSafariViewController
 * @flow
 */
'use strict';

const React = require('react-native');

const {
  NativeModules: { SFSafariViewController },
  NativeAppEventEmitter,
  DeviceEventEmitter,
  processColor
} = React;

const RCTSFSafariViewControllerExport = {
  open(url, options = {}) {
    const parsedOptions = Object.assign({}, options);

    if (options.tintColor)
      parsedOptions.tintColor = processColor(options.tintColor);

    SFSafariViewController.openURL(url, parsedOptions);
  },

  close() {
    SFSafariViewController.close();
  },

  addEventListener(eventName, listener) {
    if (eventName == 'onLoad')
      NativeAppEventEmitter.addListener(
        'SFSafariViewControllerDidLoad',
        listener
      );

    if (eventName == 'onDismiss')
      NativeAppEventEmitter.addListener(
        'SFSafariViewControllerDismissed',
        listener
      );

    if (eventName == 'onRedirectTo')
      NativeAppEventEmitter.addListener(
        'SFSafariViewControllerDidRedirectTo',
        listener
      );
  },

  removeEventListener(eventName, listener) {
    if (eventName == 'onLoad')
      NativeAppEventEmitter.removeListener(
        'SFSafariViewControllerDidLoad',
        listener
      );

    if (eventName == 'onDismiss')
      NativeAppEventEmitter.removeListener(
        'SFSafariViewControllerDismissed',
        listener
      );

    if (eventName == 'onRedirectTo')
      NativeAppEventEmitter.addListener(
        'SFSafariViewControllerDidRedirectTo',
        listener
      );
  }
};

module.exports = RCTSFSafariViewControllerExport;
