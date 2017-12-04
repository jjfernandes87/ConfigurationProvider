# ConfigurationProvider

[![CI Status](http://img.shields.io/travis/jjfernandes87/ConfigurationProvider.svg?style=flat)](https://travis-ci.org/jjfernandes87/ConfigurationProvider)
[![Version](https://img.shields.io/cocoapods/v/ConfigurationProvider.svg?style=flat)](http://cocoapods.org/pods/ConfigurationProvider)
[![License](https://img.shields.io/cocoapods/l/ConfigurationProvider.svg?style=flat)](http://cocoapods.org/pods/ConfigurationProvider)
[![Platform](https://img.shields.io/cocoapods/p/ConfigurationProvider.svg?style=flat)](http://cocoapods.org/pods/ConfigurationProvider)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.3+
- Xcode 9.0+
- Swift 4.0+

## Installation

ConfigurationProvider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ConfigurationProvider'
```
Then you need to create a plist file called Configuration

```ruby
Configuration.plist
```

The Configuration.plist is type Dictionary and you need to create the following struct

```swift
[your environment: 'dev']: [
    'your settings'
]
```

After to create your Configuration.plist you need to add a new key in your info.plist app, called Scheme

```swift
Scheme = [your environment: 'dev']
]
```

## Author

jjfernandes87, julio.fernandes87@gmail.com

## License

ConfigurationProvider is available under the MIT license. See the LICENSE file for more info.
