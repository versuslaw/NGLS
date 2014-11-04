//
//  EmaiField.h
//  NGLS
//
//  Created by Ross Humphreys on 04/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmaiField : UITextField

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range;

@end
