//
//  NCRedact.m
//  Demo
//
//  Created by Daniel Brooker on 23/03/14.
//  Copyright (c) 2014 Nocturnal Code. All rights reserved.
//

#import "NCRedact.h"
#import "NSMutableString+Ruby.h"

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

+ (void)addRedactKey:(NSString *)key
{
    [self addRedactKey:key with:@"[REDACTED]"];
}

+ (void)addRedactKey:(NSString *)key with:(NSString *)string
{
    NCRedact.sharedInstance.redactionary[key] = string;
}

+ (void)addRedactString:(NSString *)string
{
    [self addRedactString:string with:@"[REDACTED]"];
}

+ (void)addRedactString:(NSString *)string with:(NSString *)differentString
{
    NCRedact.sharedInstance.redacthesaurus[string] = differentString;
}

+ (NSString *)redactString:(NSString *)string
{
    //    char *xcode_colors = getenv("XcodeColors");
    //    BOOL colours = (xcode_colors && (strcmp(xcode_colors, "YES") == 0));
    
    NSMutableString *mutable = [string mutableCopy];
//    NSDictionary *dict = NCRedact.sharedInstance.redacthesaurus;
    [mutable substituteAllInPlace:NCRedact.sharedInstance.redacthesaurus];
    
    [NCRedact.sharedInstance.redactionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *format = [NSString stringWithFormat:@"%%@%@%%@ = %%@;\n",key];
        NSString *regexp = [NSString stringWithFormat:format,@"\"?",@"\"?",@".*?"];
        
        [mutable substituteAllInPlace:regexp with:[NSString stringWithFormat:format,@"",@"",obj]];
    }];
    
    return [mutable copy];
}

@end
