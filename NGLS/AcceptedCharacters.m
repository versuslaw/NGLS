//
//  AcceptedCharacters.m
//  NGLS
//
//  Created by Ross Humphreys on 21/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "AcceptedCharacters.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_."

@implementation AcceptedCharacters

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    
//    if (self) {
//        NSLog(@"Delegate = self");
//        self.delegate = self;
//    }
//}

//#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"AcceptedCharacters");
//    // Restrict special characters
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    
//    return [string isEqualToString:filtered];
//}

- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    return [string isEqualToString:filtered];
}

@end
