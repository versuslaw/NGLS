//
//  UpperCaseConvert.m
//  NGLS
//
//  Created by Ross Humphreys on 22/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "PostcodeField.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_."

@implementation PostcodeField

// Convert characters to uppercase and return acceptable characters
- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    [self setText:[self.text stringByReplacingCharactersInRange:range withString:[filtered uppercaseString]]];
    return NO;
}

@end
