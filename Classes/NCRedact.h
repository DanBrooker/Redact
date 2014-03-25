//
//  NCRedact.h
//  Redact
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `NCRedact` is the core of Redact and performs string redactions using simple substitution and also more fancy key value pair redactions
 
 Redacting strings isn't just for security purposes, it can cleanup long strings e.g. 
 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/Developer/usr/bin
 Could be snipped to [Simulator7.1]/usr/bin
 
 By default "password" is added as a redacted key
 */
@interface NCRedact : NSObject

/**
 Add a key for which you want the value to be redacted
 This calls addRedactedKey:key with:@"[REDACTED]"
 
 @param key The key for which you want values to be redacted
 */
+ (void)addRedactedKey:(NSString *)key;

/**
 Add a key for which you want the value to be redacted
 
 @param key The key for which you want values to be redacted
 @param string The string to substitute for the redacted value
 */
+ (void)addRedactedKey:(NSString *)key with:(NSString *)string;

/**
 Add a string to be redacted (found and replaced)
 
 @param string The string to found and replaced
 */
+ (void)addRedactedString:(NSString *)string;

/**
 Add a string to be redacted (found and replaced)
 
 @param string The string to found
 @param replacement The string to be the replacement
 */
+ (void)addRedactedString:(NSString *)string with:(NSString *)replacement;

/**
 Redact a string
 
 @param string The string that needs to be redacted
 
 @return A redacted string
 */
+ (NSString *)redactString:(NSString *)string;

@end

/**
 NSLog replacement that will redact and the log to stderr
 */
extern void RedactedLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

/**
 NSLogv replacement that will redact and the log to stderr
 */
extern void RedactedLogv(NSString *format, va_list args) NS_FORMAT_FUNCTION(1,0);
