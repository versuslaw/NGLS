//
//  LettersOnly.m
//  NGLS
//
//  Created by Ross Humphreys on 28/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "LettersOnly.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-"

@implementation LettersOnly

// Only return letters
- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

@end
