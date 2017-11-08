react-native-sfsafariviewcontroller
=======================
An SFSafariViewController wrapper for React Native presenting Safari View in a modal, written in Swift.

## Installation

1. Run `npm install react-native-sfsafariviewcontroller --save` in your project directory.
- Make sure you have the `UIKit` framework included in your XCode project
- Add dependency in `Podfile` to `node_modules/react-native-sfsafariviewcontroller`
- Whenever you want to use it within your React code - `import RCTSFSafariViewController from 'react-native-sfsafariviewcontroller'`

## Usage

```
// at the top of your file near the other imports
import RCTSFSafariViewController from 'react-native-sfsafariviewcontroller';

...

// wherever you want to trigger a browser modal appearing
RCTSFSafariViewController.open('https://google.com/');

// or with custom options
RCTSFSafariViewController.open('https://google.com/', {
  tintColor: '#90c3d4',
});

// Close the browser modal from your React Native code if needed
RCTSFSafariViewController.close();

```

## Events

```
// onLoad (when the modal has fully appeared)
RCTSFSafariViewController.addEventListener('onLoad', () => console.log('RCTSafariViewController is now visible!'));

// onDismiss (when the user has tapped on 'Done')
RCTSFSafariViewController.addEventListener('onDismiss', () => console.log('RCTSafariViewController will now disappear'));

// remove listeners once you don't need them anymore
RCTSFSafariViewController.removeEventListener('onLoad',    this.someLoadListenerReference);
RCTSFSafariViewController.removeEventListener('onDismiss', this.someDismissListenerReference);
```

## License
(The MIT License)

Copyright (c) 2017 Albert Schapiro

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
