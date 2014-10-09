//
//  AdminViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 12/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AdminViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIApplicationDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (strong, nonatomic) NSManagedObject *managedObjectAdmin;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *siteLocationField;

@property (retain, nonatomic) IBOutlet UIPickerView *namePicker;
@property (retain, nonatomic) NSArray *usernameArray;

@property (retain, nonatomic) IBOutlet UIPickerView *sitePicker;
@property (retain, nonatomic) NSArray *siteArray;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *exportBtn;

@property (retain, strong) UIAlertView *loginRequired;

@end
