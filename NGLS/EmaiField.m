//
//  EmaiField.m
//  NGLS
//
//  Created by Ross Humphreys on 04/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "EmaiField.h"

@implementation EmaiField

// Force user to enter lowercase string
// Predicate test for valid email is implemented on ClientViewController.m
- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    [self setText:[self.text stringByReplacingCharactersInRange:range withString:[string lowercaseString]]];
    return NO;
}

@end
