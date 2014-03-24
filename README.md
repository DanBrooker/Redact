# redact

[![Version](http://cocoapod-badges.herokuapp.com/v/redact/badge.png)](http://cocoadocs.org/docsets/redact)
[![Platform](http://cocoapod-badges.herokuapp.com/p/redact/badge.png)](http://cocoadocs.org/docsets/redact)

Redact sensitive strings from your logs with `[obj redactedDescription]`, similar to Rails filter_parameters.

By default redacts the password property for dictionaries and basic key value styled logs.

Redact a dictionary
```
[@{@"password": "secret",@"username": @"user01"} redactedDescription]
-> {
     password: [REDACTED];
     username: "user01";
   }
```

Redact a string
```
[@"password = secret; username = user01" redactedDescription]
-> password = [REDACTED]; username = user01
```

## Usage

To run the test cases; clone the repo, and run `pod install` from the Example directory first.

## Installation

redact is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "redact"

## Author

Daniel Brooker, dan@nocturnalcode.com, @DraconisNZ

## License

redact is available under the MIT license. See the LICENSE file for more info.

