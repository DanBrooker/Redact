//
//  NCRedact.m
//  Demo
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import "NCRedact.h"

/**
 Methods in this category are heavily influenced by NSString+Ruby.h
 When included as a dependancy something wasn't working with the string class cluster and caused the category methods to error
 */
@interface NSMutableString (Redact)

- (void)substituteAll:(NSDictionary *)dict;
- (void)substituteAll:(NSString *)regexp with:(NSString *)string;

@end

@interface NCRedact ()

@property (nonatomic, strong) NSMutableDictionary *redactionary;
@property (nonatomic, strong) NSMutableDictionary *redacthesaurus;

@end

@implementation NCRedact

- (instancetype)init
{
    if((self = [super init]))
    {
        [self reset];
    }
    return self;
}

- (void)reset
{
    _redacthesaurus = [[NSMutableDictionary alloc] init];
    _redactionary = [[NSMutableDictionary alloc] init];
    for(NSString *defaults in @[@"password"])
        [_redactionary setValue:@"[REDACTED]" forKey:defaults];
}

+ (void)reset
{
    [NCRedact.sharedInstance reset];
}

+ (NCRedact *)sharedInstance
{
    static NCRedact *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NCRedact alloc] init];
    });
    return instance;
}

+ (void)addRedactedKey:(NSString *)key
{
    [self addRedactedKey:key with:@"[REDACTED]"];
}

+ (void)addRedactedKey:(NSString *)key with:(NSString *)string
{
    NCRedact.sharedInstance.redactionary[key] = string;
}

+ (void)addRedactedString:(NSString *)string
{
    [self addRedactedString:string with:@"[REDACTED]"];
}

+ (void)addRedactedString:(NSString *)string with:(NSString *)differentString
{
    NCRedact.sharedInstance.redacthesaurus[string] = differentString;
}

+ (NSString *)redactString:(NSString *)string
{
    //    char *xcode_colors = getenv("XcodeColors");
    //    BOOL colours = (xcode_colors && (strcmp(xcode_colors, "YES") == 0));
    
    NSMutableString *mutable =  [string mutableCopy];
    
    // Simple find and replace for word swaps
    [mutable substituteAll:NCRedact.sharedInstance.redacthesaurus];
    
    // Slightyl more complex search for key value pairs
    [NCRedact.sharedInstance.redactionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // NSDictionary description format
        NSString *regexp = [NSString stringWithFormat:@"\"%@\" = .*?;",key];
        [mutable substituteAll:regexp with:[NSString stringWithFormat:@"%@ = %@;",key,obj]];
        
//        // CoreData description format
//        regexp = [NSString stringWithFormat:@"\"%@\" = .*?;",key];
//        [mutable substituteAllInPlace:regexp with:[NSString stringWithFormat:@"%@ = %@;",key,obj]];
        
        // key = value; and key=value,
        regexp = [NSString stringWithFormat:@"%@ ?= ?.*?[;,]",key];
        [mutable substituteAll:regexp with:[NSString stringWithFormat:@"%@ = %@;",key,obj]];
        
        // key = value and key=value
        regexp = [NSString stringWithFormat:@"%@ ?= ?.*?$",key];
        [mutable substituteAll:regexp with:[NSString stringWithFormat:@"%@ = %@",key,obj]];
        
        // key: value; and key : value,
        regexp = [NSString stringWithFormat:@"%@ ?: ?.*?[;,]",key];
        [mutable substituteAll:regexp with:[NSString stringWithFormat:@"%@: %@;",key,obj]];
        
        // key: value and key : value
        regexp = [NSString stringWithFormat:@"%@ ?: ?.*?$",key];
        [mutable substituteAll:regexp with:[NSString stringWithFormat:@"%@: %@",key,obj]];
    }];
    
    return [mutable copy];
}

@end

void RedactedLog(NSString *format, ...)
{
	va_list args;
	va_start(args, format);
    RedactedLogv(format,args);
    va_end(args);
}

void RedactedLogv(NSString *format, va_list args)
{
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    
    NSString *redacted = [NCRedact redactString:string];
    fprintf(stderr,"%s\n",[redacted UTF8String]);
}

@implementation NSMutableString (Redact)

- (void)substituteAll:(NSDictionary *)dict
{
    NSString *result = self;
    for(NSString *key in [dict allKeys])
    {
        NSRange range = [self rangeOfString:key];
        if(range.location != NSNotFound)
            result = [result stringByReplacingOccurrencesOfString:key withString:[dict objectForKey:key]];
    }
    
    [self setString:result];
}

- (void)substituteAll:(NSString *)pattern with:(NSString *)sub
{
    NSString *result = self;
    NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];
    if(error == nil)
    {
        NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
        for(NSTextCheckingResult *match in matches)
            result = [result stringByReplacingCharactersInRange:match.range withString:sub];
    }
    [self setString:result];
}

@end
