//
//  NumbersOnly.h
//  NGLS
//
//  Created by Ross Humphreys on 17/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumbersOnly : UITextField 

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range;

@end
