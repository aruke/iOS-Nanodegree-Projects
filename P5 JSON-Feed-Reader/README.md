# JSON feed reader


## Origin
This app is my Capstone project for the iOS Developer Nanodegree offered by Udacity. This Nanodegree course focuses on iOS app development using Swift, including UIKit Fundamentals, Networking, and Persistence with Code Data.
The app uses JSON Feeds to get contents. I read about JSON feeds in May 2017 and instantly I fall in love with it. I decided to write a dedicated app for it and finally I made it here.

## About the App
JSON fed reader in current context was s simple app that subscribed to blog feed from jsonfeed.org and let users read through it.
Next releases will have subscription to multiple feeds.

## Libraries and Frameworks Used
**iOS Frameworks**:
1. [Foundation](https://developer.apple.com/documentation/foundation)
2. [UIKit](https://developer.apple.com/documentation/uikit)
3. [Core Data](https://developer.apple.com/documentation/coredata) to store images.

**External Library**
6. [JSONFeed](https://github.com/totocaster/JSONFeed) to parse feed data.

## How to Build
The build system uses [CocoaPods](https://cocoapods.org) to integrate dependencies. You should be familiar with CocoaPods and API key and secret from Flickr account.
1. Download zip or fork & clone project on your desktop.
2. Open Terminal and `cd` into project folder. Most of the times the path will be `~/Downloads/JSON-Feed-Reader`.
3. Run `pods install` to install dependencies.
4. Open `JSON Feed Reader.xcworkspace` with Xcode.
5. Now you can build and run the app.

## Licence

```
This project was submitted by Rajanikant Deshmukh as part of the iOS Developer Nanodegree At Udacity.
As part of Udacity Honor code, your submissions must be your work, hence submitting this project
as yours will cause you to break the Udacity Honor Code moreover, the suspension of your account.
Me, the author of the project, allows you to check the code as a reference, but if you submit it,
it is your responsibility if you get expelled.
Besides the above notice, the following license applies, and this license notice must be included
in all works derived from this project.

MIT License

Copyright (c) 2018 Rajanikant Deshmukh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
