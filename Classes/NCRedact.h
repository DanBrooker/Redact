//
//  NCRedact.h
//  Demo
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCRedact : NSObject

+ (void)addRedactKey:(NSString *)key;
+ (void)addRedactKey:(NSString *)key with:(NSString *)string;
+ (void)addRedactString:(NSString *)string;
+ (void)addRedactString:(NSString *)string with:(NSString *)differentString;

+ (NSString *)redactString:(NSString *)string;

@end
