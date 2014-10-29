//
//  NINumber.m
//  NGLS
//
//  Created by Ross Humphreys on 29/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "NINumber.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@implementation NINumber

// Disable cut/copy/paste menu on UITextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    NSString *text = self.text;
    
    // Limit character length
    if ([text length] == 13 && range.location > 12) {
        return NO;
    }
    
    // Add string with uppercase characters
    text = [text stringByReplacingCharactersInRange:range withString:[filtered uppercaseString]];
    
    // Remove spaces (as they get automatically added below)
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableString *mutableText = [text mutableCopy];

    // Every 3rd char will be a "."
    for (NSUInteger i = 2; i < mutableText.length; i += 3) {
        [mutableText insertString:@" " atIndex:i];
    }
    
    // Filter characters for correct format: XX-##-##-##-X
    for (NSUInteger i = 0; i < [mutableText length]; i++)
    {
        if (isdigit([mutableText characterAtIndex:i]))
        {
            if (i < 2 || i > 10) {
                NSLog(@"Number found: %d", i);
                return NO;
            }
        }
        
        if (isalpha([mutableText characterAtIndex:i]))
        {
            if (i > 2 && i < 12) {
                NSLog(@"Alpha found: %d", i);
                return NO;
            }
        }
    }
    
    // Set text to new string
    text = mutableText;
    
    // Set textfield to new string
    self.text = text;
    
    return NO;
}


@end
