//
//  NumbersOnly.m
//  NGLS
//
//  Created by Ross Humphreys on 17/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "NumbersOnly.h"

@implementation NumbersOnly

// Only return numbers
- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
        return NO;
    }
    return YES;
}


@end
