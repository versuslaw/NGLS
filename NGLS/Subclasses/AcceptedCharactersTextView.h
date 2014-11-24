//
//  AcceptedCharactersTextView.h
//  NGLS
//
//  Created by Ross Humphreys on 24/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcceptedCharactersTextView : UITextView

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range;

@end
