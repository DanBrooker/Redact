# Redact

[![Version](http://cocoapod-badges.herokuapp.com/v/redact/badge.png)](http://cocoadocs.org/docsets/redact)
[![Platform](http://cocoapod-badges.herokuapp.com/p/redact/badge.png)](http://cocoadocs.org/docsets/redact)

Redact sensitive strings from your logs with `[obj redactedDescription]`, similar to Rails filter_parameters.

By default redacts the password property for dictionaries and basic key value styled logs.

Redact a dictionary

    [@{@"password": "secret",@"username": @"user01"} redactedDescription]
    -> {
         password: [REDACTED];
         username: "user01";
       }

Redact a string

    [@"password = secret; username = user01" redactedDescription]
    -> password = [REDACTED]; username = user01


## Usage

    #import "Redact.h"

Then use `[obj redactedDescription];` 

or use RedactedLog() instead of NSLog() by adding the following macro into your .pch file

    #import "Redact.h"
    #define NSLog RedactedLog


By default `password` is a redacted key, but it's easy to add more.

    [NCRedact addRedactedKey:@"secret_key"];
or use redact to trim your logs down

    NSString *path = [[NSBundle mainBundle] bundlePath];
    [NCRedact addRedactedString:path with:@"[BUNDLE]"];

## Tests

To run the test cases; clone the repo, and run `pod install` from the Example directory. Then open the workspace and run the tests.

## Installation

redact is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "redact"

## Author

Daniel Brooker, dan@nocturnalcode.com, @DraconisNZ

## License

redact is available under the MIT license. See the LICENSE file for more info.
