//
//  PhoneNumber.m
//  NGLS
//
//  Created by Ross Humphreys on 22/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "PhoneNumber.h"
#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 11

@implementation PhoneNumber

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSUInteger newLength = [self.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
}

@end
