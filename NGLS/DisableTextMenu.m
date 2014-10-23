//
//  DisableTextMenu.m
//  NGLS
//
//  Created by Ross Humphreys on 14/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "DisableTextMenu.h"

@implementation DisableTextMenu

// Disable cut/copy/paste menu on UITextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
