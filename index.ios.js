/**
 * @providesModule RCTSFSafariViewController
 * @flow
 */
'use strict';

var React = require('react-native');
var {
  NativeModules: { SFSafariViewController },
  NativeAppEventEmitter,
  DeviceEventEmitter,
  processColor
} = React;

var RCTSFSafariViewControllerExport = {
  open: function(url, options = {}) {
    var parsedOptions = {};

    if (options.tintColor)
      parsedOptions.tintColor = processColor(options.tintColor);

    SFSafariViewController.openURL(url, parsedOptions);
  },

  close: function() {
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
