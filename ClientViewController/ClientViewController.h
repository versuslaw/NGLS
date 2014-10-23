//
//  ClientViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Model.h"

@interface ClientViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (strong, nonatomic) NSManagedObject *managedObjectAdmin;

@property (weak, nonatomic) IBOutlet UISegmentedControl *titleSeg;
@property (weak, nonatomic) IBOutlet UITextField *forenameField;
@property (weak, nonatomic) IBOutlet UITextField *surnameField;

@property (weak, nonatomic) IBOutlet UITextField *addLine1Field;
@property (weak, nonatomic) IBOutlet UITextField *addLine2Field;
@property (weak, nonatomic) IBOutlet UITextField *addLine3Field;
@property (weak, nonatomic) IBOutlet UITextField *addLine4Field;
@property (weak, nonatomic) IBOutlet UITextField *addLine5Field;
//@property (weak, nonatomic) IBOutlet UITextField *addLine6Field;
@property (weak, nonatomic) IBOutlet UITextField *postcodeField;

@property (weak, nonatomic) IBOutlet UITextField *telLandField;
@property (weak, nonatomic) IBOutlet UITextField *telMobField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *dobField;
@property (weak, nonatomic) IBOutlet UITextField *niNumField;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UISegmentedControl *contactSeg;

@property (strong, nonatomic) IBOutlet UIAlertView *nameError;
@property (strong, nonatomic) IBOutlet UIAlertView *addError;
@property (strong, nonatomic) IBOutlet UIAlertView *phoneError;
@property (strong, nonatomic) IBOutlet UIAlertView *emailError;

@end
