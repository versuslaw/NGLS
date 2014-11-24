//
//  BPViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 24/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (strong, nonatomic) IBOutlet UITextView *bpDetails;

@end
