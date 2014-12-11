//
//  AcceptedCharacters.m
//  NGLS
//
//  Created by Ross Humphreys on 21/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "AcceptedCharacters.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'&-_."

@implementation AcceptedCharacters

// Only return acceptable characters
- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

@end
