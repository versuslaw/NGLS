//
//  INDEmpViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 14/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INDEmpViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) NSDate *dateFrom;
@property (nonatomic, strong) NSDate *dateTo;

@property (weak, nonatomic) IBOutlet UITextField *empName1;
@property (weak, nonatomic) IBOutlet UITextField *empFrom1;
@property (weak, nonatomic) IBOutlet UITextField *empTo1;
@property (weak, nonatomic) IBOutlet UITextField *empNoise1;
@property (weak, nonatomic) IBOutlet UITextField *empExposure1;

@property (weak, nonatomic) IBOutlet UITextField *empName2;
@property (weak, nonatomic) IBOutlet UITextField *empFrom2;
@property (weak, nonatomic) IBOutlet UITextField *empTo2;
@property (weak, nonatomic) IBOutlet UITextField *empNoise2;
@property (weak, nonatomic) IBOutlet UITextField *empExposure2;

@property (weak, nonatomic) IBOutlet UITextField *empName3;
@property (weak, nonatomic) IBOutlet UITextField *empFrom3;
@property (weak, nonatomic) IBOutlet UITextField *empTo3;
@property (weak, nonatomic) IBOutlet UITextField *empNoise3;
@property (weak, nonatomic) IBOutlet UITextField *empExposure3;

@property (weak, nonatomic) IBOutlet UITextField *empName4;
@property (weak, nonatomic) IBOutlet UITextField *empFrom4;
@property (weak, nonatomic) IBOutlet UITextField *empTo4;
@property (weak, nonatomic) IBOutlet UITextField *empNoise4;
@property (weak, nonatomic) IBOutlet UITextField *empExposure4;

@property (weak, nonatomic) IBOutlet UITextField *empName5;
@property (weak, nonatomic) IBOutlet UITextField *empFrom5;
@property (weak, nonatomic) IBOutlet UITextField *empTo5;
@property (weak, nonatomic) IBOutlet UITextField *empNoise5;
@property (weak, nonatomic) IBOutlet UITextField *empExposure5;

@property (weak, nonatomic) IBOutlet UITextField *empName6;
@property (weak, nonatomic) IBOutlet UITextField *empFrom6;
@property (weak, nonatomic) IBOutlet UITextField *empTo6;
@property (weak, nonatomic) IBOutlet UITextField *empNoise6;
@property (weak, nonatomic) IBOutlet UITextField *empExposure6;

@property (weak, nonatomic) IBOutlet UITextField *empName7;
@property (weak, nonatomic) IBOutlet UITextField *empFrom7;
@property (weak, nonatomic) IBOutlet UITextField *empTo7;
@property (weak, nonatomic) IBOutlet UITextField *empNoise7;
@property (weak, nonatomic) IBOutlet UITextField *empExposure7;

@property (weak, nonatomic) IBOutlet UITextField *empName8;
@property (weak, nonatomic) IBOutlet UITextField *empFrom8;
@property (weak, nonatomic) IBOutlet UITextField *empTo8;
@property (weak, nonatomic) IBOutlet UITextField *empNoise8;
@property (weak, nonatomic) IBOutlet UITextField *empExposure8;

@property (weak, nonatomic) IBOutlet UITextField *empName9;
@property (weak, nonatomic) IBOutlet UITextField *empFrom9;
@property (weak, nonatomic) IBOutlet UITextField *empTo9;
@property (weak, nonatomic) IBOutlet UITextField *empNoise9;
@property (weak, nonatomic) IBOutlet UITextField *empExposure9;

@property (weak, nonatomic) IBOutlet UITextField *empName10;
@property (weak, nonatomic) IBOutlet UITextField *empFrom10;
@property (weak, nonatomic) IBOutlet UITextField *empTo10;
@property (weak, nonatomic) IBOutlet UITextField *empNoise10;
@property (weak, nonatomic) IBOutlet UITextField *empExposure10;

@property (retain, nonatomic) IBOutlet UIPickerView *noisePicker;
@property (retain, nonatomic) NSArray *noiseArray;

@end
