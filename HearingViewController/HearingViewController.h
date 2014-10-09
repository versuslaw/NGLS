//
//  HearingViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 11/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface HearingViewController : UIViewController

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (weak, nonatomic) IBOutlet UISegmentedControl *q1Seg;
@property (weak, nonatomic) IBOutlet UITextField *q1More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *q2Seg;
@property (weak, nonatomic) IBOutlet UITextField *q2More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *q3Seg;
@property (weak, nonatomic) IBOutlet UITextField *q3More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *q4Seg;
@property (weak, nonatomic) IBOutlet UITextField *q4More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *noisyWork;

@property (strong, nonatomic) IBOutlet UIAlertView *infoAlert;

@end
