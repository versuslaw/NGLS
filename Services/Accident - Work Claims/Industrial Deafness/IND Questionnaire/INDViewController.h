//
//  INDViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 11/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface INDViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (weak, nonatomic) IBOutlet UISegmentedControl *indQ1Seg;
@property (weak, nonatomic) IBOutlet UITextField *indQ1More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *indQ2Seg;
@property (weak, nonatomic) IBOutlet UITextField *indQ2More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *indQ3Seg;
@property (weak, nonatomic) IBOutlet UITextField *indQ3More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *indQ4Seg;
@property (weak, nonatomic) IBOutlet UITextField *indQ4More;

@property (weak, nonatomic) IBOutlet UISegmentedControl *noisyWork;

@property (strong, nonatomic) IBOutlet UIAlertView *infoAlert;

@end
