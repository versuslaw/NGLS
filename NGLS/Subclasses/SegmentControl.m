//
//  SegmentControl.m
//  NGLS
//
//  Created by Ross Humphreys on 17/10/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "SegmentControl.h"

@implementation SegmentControl

// Respond to touches on UISegmentControl
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesEnded:touches withEvent:event];
    
    if (previousSelectedSegmentIndex == self.selectedSegmentIndex) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
