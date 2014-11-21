//
//  PostcodeField.h
//  NGLS
//
//  Created by Ross Humphreys on 22/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostcodeField : UITextField

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range;

@end
