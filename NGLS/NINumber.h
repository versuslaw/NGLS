//
//  NINumber.h
//  NGLS
//
//  Created by Ross Humphreys on 29/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NINumber : UITextField

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range;

@end
