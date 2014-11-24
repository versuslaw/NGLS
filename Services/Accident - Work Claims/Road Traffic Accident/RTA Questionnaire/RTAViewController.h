//
//  RTAViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 24/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTAViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (strong, nonatomic) IBOutlet UITextView *rtaDetails;

@end
