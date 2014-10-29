//
//  LettersOnly.h
//  NGLS
//
//  Created by Ross Humphreys on 28/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LettersOnly : UITextField

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range;

@end
