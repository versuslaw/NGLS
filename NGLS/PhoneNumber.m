//
//  PhoneNumber.m
//  NGLS
//
//  Created by Ross Humphreys on 22/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "PhoneNumber.h"
#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 11

@implementation PhoneNumber

// Only return numbers, limit to 11 characters
- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
    //NSUInteger newLength = [self.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered]) /*&& (newLength <= CHARACTER_LIMIT)*/);
}

#pragma - force user to enter specific telephone number format
//- (BOOL)stringIsAcceptable:(NSString *)string inRange:(NSRange)range {
//    NSString *filter = @"(####) ### - ####";
//    
//    if(!filter) return YES; // No filter provided, allow anything
//    
//    NSString *changedString = [self.text stringByReplacingCharactersInRange:range withString:string];
//    
//    if(range.length == 1 && // Only do for single deletes
//       string.length < range.length &&
//       [[self.text substringWithRange:range] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location == NSNotFound)
//    {
//        // Something was deleted.  Delete past the previous number
//        NSInteger location = changedString.length-1;
//        if(location > 0)
//        {
//            for(; location > 0; location--)
//            {
//                if(isdigit([changedString characterAtIndex:location]))
//                {
//                    break;
//                }
//            }
//            changedString = [changedString substringToIndex:location];
//        }
//    }
//    
//    self.text = filteredPhoneStringFromStringWithFilter(changedString, filter);
//    
//    return NO;
//}
//
//NSMutableString *filteredPhoneStringFromStringWithFilter(NSString *string, NSString *filter)
//{
//    NSUInteger onOriginal = 0, onFilter = 0, onOutput = 0;
//    char outputString[([filter length])];
//    BOOL done = NO;
//    
//    while(onFilter < [filter length] && !done)
//    {
//        char filterChar = [filter characterAtIndex:onFilter];
//        char originalChar = onOriginal >= string.length ? '\0' : [string characterAtIndex:onOriginal];
//        switch (filterChar) {
//            case '#':
//                if(originalChar=='\0')
//                {
//                    // We have no more input numbers for the filter.  We're done.
//                    done = YES;
//                    break;
//                }
//                if(isdigit(originalChar))
//                {
//                    outputString[onOutput] = originalChar;
//                    onOriginal++;
//                    onFilter++;
//                    onOutput++;
//                }
//                else
//                {
//                    onOriginal++;
//                }
//                break;
//            default:
//                // Any other character will automatically be inserted for the user as they type (spaces, - etc..) or deleted as they delete if there are more numbers to come.
//                outputString[onOutput] = filterChar;
//                onOutput++;
//                onFilter++;
//                if(originalChar == filterChar)
//                    onOriginal++;
//                break;
//        }
//    }
//    outputString[onOutput] = '\0'; // Cap the output string
//    return [NSMutableString stringWithUTF8String:outputString];
//}

@end
