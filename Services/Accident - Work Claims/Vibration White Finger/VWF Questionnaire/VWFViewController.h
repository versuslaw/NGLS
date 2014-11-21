//
//  VWFViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 21/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface VWFViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (strong, nonatomic) IBOutlet UISegmentedControl *vwfQ1;
@property (strong, nonatomic) IBOutlet UITextField *vwfQ2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *vwfQ3;
@property (strong, nonatomic) IBOutlet UISegmentedControl *vwfQ4;
@property (strong, nonatomic) IBOutlet UISegmentedControl *vwfQ5;
@property (strong, nonatomic) IBOutlet UITextField *vwfQ6;
@property (strong, nonatomic) IBOutlet UITextField *vwfQ7;
@property (strong, nonatomic) IBOutlet UITextView *vwfQ8;
@property (strong, nonatomic) IBOutlet UITextField *vwfQ9;


@property (strong, nonatomic) IBOutlet UIAlertView *infoAlert;

@end
