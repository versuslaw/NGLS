//
//  NumbersOnly.m
//  NGLS
//
//  Created by Ross Humphreys on 17/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "NumbersOnly.h"

@implementation NumbersOnly

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    
//    self.delegate = self;
//    [self setKeyboardType:UIKeyboardTypeNumberPad];
//    
//}

//// Set UITextField to numbers only
//- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"NumbersOnly");
//    if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
//        return NO;
//    }
//    return YES;
//}

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
        return NO;
    }
    return YES;
}


@end
