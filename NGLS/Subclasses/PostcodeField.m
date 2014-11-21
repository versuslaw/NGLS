//
//  PostcodeField.m
//  NGLS
//
//  Created by Ross Humphreys on 22/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "PostcodeField.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define CHARACTER_LIMIT 8

@implementation PostcodeField

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSUInteger newLength = [self.text length] + [string length] - range.length;
    // Check text meets character limit
    if (newLength <= CHARACTER_LIMIT) {
        // Convert characters to uppercase and return acceptable characters
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        [self setText:[self.text stringByReplacingCharactersInRange:range withString:[filtered uppercaseString]]];
    }
    return NO;
}

@end
