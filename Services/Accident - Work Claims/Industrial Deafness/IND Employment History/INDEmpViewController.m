//
//  INDEmpViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 14/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "INDEmpViewController.h"
#import "ServicesViewController.h"
#import "NumbersOnly.h"
#import "AcceptedCharacters.h"

@interface INDEmpViewController ()

@end

@implementation INDEmpViewController

@synthesize datePicker;

@synthesize noisePicker;
@synthesize noiseArray;

@synthesize dateFrom;
@synthesize dateTo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set background
    self.view.backgroundColor = [UIColor clearColor];
    
    // Listen for lower-right keyboard hide button
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    // Set navbar title
    self.navigationItem.title = @"Industrial Deafness";
    
    // Create 'Home' navbar button
    UIBarButtonItem *finishBtn = [[UIBarButtonItem alloc]initWithTitle:@"Services"
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(finishBtnPressed:)];
    self.navigationItem.rightBarButtonItem = finishBtn;
    finishBtn.enabled = TRUE;

    // Call datePicker method
    [self datePickerTextField];
    
    // Listen for datePicker changes
    [datePicker addTarget:self
                   action:@selector(updateDateTextField)
         forControlEvents:UIControlEventValueChanged];

    // Noise picker
    self.noisePicker = [[UIPickerView alloc]init];
    [noisePicker setDataSource:self];
    [noisePicker setDelegate:self];
    self.noiseArray = [[NSArray alloc]initWithObjects:@"4: Extreme Noise (Impossible)", @"3: Very Noisy (Loud Shouting)", @"2: Noisy (Shouting)", @"1: Not Noisy (Normally)", nil];
    
    // Call noisePicker method
    [self noisePickerTextField];
    
    // Set textfields delegate to self
    self.empName1.delegate = self;
    self.empName2.delegate = self;
    self.empName3.delegate = self;
    self.empName4.delegate = self;
    self.empName5.delegate = self;
    self.empName6.delegate = self;
    self.empName7.delegate = self;
    self.empName8.delegate = self;
    self.empName9.delegate = self;
    self.empName10.delegate = self;
    
    self.empExposure1.delegate = self;
    self.empExposure2.delegate = self;
    self.empExposure3.delegate = self;
    self.empExposure4.delegate = self;
    self.empExposure5.delegate = self;
    self.empExposure6.delegate = self;
    self.empExposure7.delegate = self;
    self.empExposure8.delegate = self;
    self.empExposure9.delegate = self;
    self.empExposure10.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Dismiss keyboard when user taps anywhere on view
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Dismiss keyboard when 'done' is pressed
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return NO;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // Dismiss keyboard when lower-right hide button is tapped
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Call NumbersOnly subclass on Exposure textfields
    if ([textField isKindOfClass:[NumbersOnly class]]) {
        return [(NumbersOnly *)textField stringIsAcceptable:string inRange:range];
    }
    
    // Call AcceptedCharacters subclass on Employers Name textfields
    if ([textField isKindOfClass:[AcceptedCharacters class]]) {
        return [(AcceptedCharacters *)textField stringIsAcceptable:string inRange:range];
    }
    return YES;
}

- (void)noisePickerTextField {
    // Set input for each textfield
    [self.empNoise1 setInputView:noisePicker];
    [self.empNoise2 setInputView:noisePicker];
    [self.empNoise3 setInputView:noisePicker];
    [self.empNoise4 setInputView:noisePicker];
    [self.empNoise5 setInputView:noisePicker];
    [self.empNoise6 setInputView:noisePicker];
    [self.empNoise7 setInputView:noisePicker];
    [self.empNoise8 setInputView:noisePicker];
    [self.empNoise9 setInputView:noisePicker];
    [self.empNoise10 setInputView:noisePicker];
}

#pragma picker components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [noiseArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [noiseArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // Return first charater of string (1,2,3,4)
    NSString *noiseString = [[NSString alloc]initWithFormat:@"%@", [[noiseArray objectAtIndex:row] substringToIndex:1]];
    
    // Test which textfield is active
    if ([self.empNoise1 isFirstResponder]) {
        self.empNoise1.text = noiseString;
    }
    else if ([self.empNoise2 isFirstResponder]) {
        self.empNoise2.text = noiseString;
    }
    else if ([self.empNoise3 isFirstResponder]) {
        self.empNoise3.text = noiseString;
    }
    else if ([self.empNoise4 isFirstResponder]) {
        self.empNoise4.text = noiseString;
    }
    else if ([self.empNoise5 isFirstResponder]) {
        self.empNoise5.text = noiseString;
    }
    else if ([self.empNoise6 isFirstResponder]) {
        self.empNoise6.text = noiseString;
    }
    else if ([self.empNoise7 isFirstResponder]) {
        self.empNoise7.text = noiseString;
    }
    else if ([self.empNoise8 isFirstResponder]) {
        self.empNoise8.text = noiseString;
    }
    else if ([self.empNoise9 isFirstResponder]) {
        self.empNoise9.text = noiseString;
    }
    else if ([self.empNoise10 isFirstResponder]) {
        self.empNoise10.text = noiseString;
    }
}

- (void)datePickerTextField {
    // Open date picker when textfield is tapped
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    // Set default date to 01/01/1980
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setDay:1];
    [components setMonth:1];
    [components setYear:1980];
    NSDate *defaultDate = [calendar dateFromComponents:components];
    [datePicker setDate:defaultDate];
    
    // Set max date to today
    [datePicker setMaximumDate:[NSDate date]];
//    [datePicker addTarget:self
//                   action:@selector(updateDateTextField:)
//         forControlEvents:UIControlEventValueChanged];
    datePicker.backgroundColor = [UIColor clearColor];
    
    // Set input for each textfield
    [self.empFrom1 setInputView:datePicker];
    [self.empTo1 setInputView:datePicker];
    [self.empFrom2 setInputView:datePicker];
    [self.empTo2 setInputView:datePicker];
    [self.empFrom3 setInputView:datePicker];
    [self.empTo3 setInputView:datePicker];
    [self.empFrom4 setInputView:datePicker];
    [self.empTo4 setInputView:datePicker];
    [self.empFrom5 setInputView:datePicker];
    [self.empTo5 setInputView:datePicker];
    [self.empFrom6 setInputView:datePicker];
    [self.empTo6 setInputView:datePicker];
    [self.empFrom7 setInputView:datePicker];
    [self.empTo7 setInputView:datePicker];
    [self.empFrom8 setInputView:datePicker];
    [self.empTo8 setInputView:datePicker];
    [self.empFrom9 setInputView:datePicker];
    [self.empTo9 setInputView:datePicker];
    [self.empFrom10 setInputView:datePicker];
    [self.empTo10 setInputView:datePicker];
}

- (void)updateDateTextField {
    // Format date
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:datePicker.date];
    
    UIAlertView *validDate = [[UIAlertView alloc]initWithTitle:@"Error"
                                                       message:@"Please check dates"
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
    
    // Check active textfield, update & validate date
    if ([self.empFrom1 isFirstResponder]) {
        self.empFrom1.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo1 isFirstResponder]) {
        self.empTo1.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom2 isFirstResponder]) {
        self.empFrom2.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo2 isFirstResponder]) {
        self.empTo2.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom3 isFirstResponder]) {
        self.empFrom3.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo3 isFirstResponder]) {
        self.empTo3.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom4 isFirstResponder]) {
        self.empFrom4.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo4 isFirstResponder]) {
        self.empTo4.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom5 isFirstResponder]) {
        self.empFrom5.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo5 isFirstResponder]) {
        self.empTo5.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom6 isFirstResponder]) {
        self.empFrom6.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo6 isFirstResponder]) {
        self.empTo6.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom7 isFirstResponder]) {
        self.empFrom7.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo7 isFirstResponder]) {
        self.empTo7.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom8 isFirstResponder]) {
        self.empFrom8.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo8 isFirstResponder]) {
        self.empTo8.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
        }
    }
    
    else if ([self.empFrom9 isFirstResponder]) {
        self.empFrom9.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo9 isFirstResponder]) {
        self.empTo9.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
    
    else if ([self.empFrom10 isFirstResponder]) {
        self.empFrom10.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateFrom = datePicker.date;
    } else if ([self.empTo10 isFirstResponder]) {
        self.empTo10.text = [NSString stringWithFormat:@"%@", stringFromDate];
        self.dateTo = datePicker.date;
        if ([self.dateFrom timeIntervalSinceDate:self.dateTo] > 0) {
            [validDate show];
            [datePicker setDate:dateFrom];
            [self updateDateTextField];
        }
    }
}

- (IBAction)finishBtnPressed:(UIButton *)sender {
    // Save all data
    [self.managedObjectNGLS setValue:self.empName1.text forKey:@"emp1Name"];
    [self.managedObjectNGLS setValue:self.empFrom1.text forKey:@"emp1From"];
    [self.managedObjectNGLS setValue:self.empTo1.text forKey:@"emp1To"];
    [self.managedObjectNGLS setValue:self.empNoise1.text forKey:@"emp1Noise"];
    [self.managedObjectNGLS setValue:self.empExposure1.text forKey:@"emp1Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName2.text forKey:@"emp2Name"];
    [self.managedObjectNGLS setValue:self.empFrom2.text forKey:@"emp2From"];
    [self.managedObjectNGLS setValue:self.empTo2.text forKey:@"emp2To"];
    [self.managedObjectNGLS setValue:self.empNoise2.text forKey:@"emp2Noise"];
    [self.managedObjectNGLS setValue:self.empExposure2.text forKey:@"emp2Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName3.text forKey:@"emp3Name"];
    [self.managedObjectNGLS setValue:self.empFrom3.text forKey:@"emp3From"];
    [self.managedObjectNGLS setValue:self.empTo3.text forKey:@"emp3To"];
    [self.managedObjectNGLS setValue:self.empNoise3.text forKey:@"emp3Noise"];
    [self.managedObjectNGLS setValue:self.empExposure3.text forKey:@"emp3Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName4.text forKey:@"emp4Name"];
    [self.managedObjectNGLS setValue:self.empFrom4.text forKey:@"emp4From"];
    [self.managedObjectNGLS setValue:self.empTo4.text forKey:@"emp4To"];
    [self.managedObjectNGLS setValue:self.empNoise4.text forKey:@"emp4Noise"];
    [self.managedObjectNGLS setValue:self.empExposure4.text forKey:@"emp4Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName5.text forKey:@"emp5Name"];
    [self.managedObjectNGLS setValue:self.empFrom5.text forKey:@"emp5From"];
    [self.managedObjectNGLS setValue:self.empTo5.text forKey:@"emp5To"];
    [self.managedObjectNGLS setValue:self.empNoise5.text forKey:@"emp5Noise"];
    [self.managedObjectNGLS setValue:self.empExposure5.text forKey:@"emp5Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName6.text forKey:@"emp6Name"];
    [self.managedObjectNGLS setValue:self.empFrom6.text forKey:@"emp6From"];
    [self.managedObjectNGLS setValue:self.empTo6.text forKey:@"emp6To"];
    [self.managedObjectNGLS setValue:self.empNoise6.text forKey:@"emp6Noise"];
    [self.managedObjectNGLS setValue:self.empExposure6.text forKey:@"emp6Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName7.text forKey:@"emp7Name"];
    [self.managedObjectNGLS setValue:self.empFrom7.text forKey:@"emp7From"];
    [self.managedObjectNGLS setValue:self.empTo7.text forKey:@"emp7To"];
    [self.managedObjectNGLS setValue:self.empNoise7.text forKey:@"emp7Noise"];
    [self.managedObjectNGLS setValue:self.empExposure7.text forKey:@"emp7Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName8.text forKey:@"emp8Name"];
    [self.managedObjectNGLS setValue:self.empFrom8.text forKey:@"emp8From"];
    [self.managedObjectNGLS setValue:self.empTo8.text forKey:@"emp8To"];
    [self.managedObjectNGLS setValue:self.empNoise8.text forKey:@"emp8Noise"];
    [self.managedObjectNGLS setValue:self.empExposure8.text forKey:@"emp8Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName9.text forKey:@"emp9Name"];
    [self.managedObjectNGLS setValue:self.empFrom9.text forKey:@"emp9From"];
    [self.managedObjectNGLS setValue:self.empTo9.text forKey:@"emp9To"];
    [self.managedObjectNGLS setValue:self.empNoise9.text forKey:@"emp9Noise"];
    [self.managedObjectNGLS setValue:self.empExposure9.text forKey:@"emp9Exposure"];
    
    [self.managedObjectNGLS setValue:self.empName10.text forKey:@"emp10Name"];
    [self.managedObjectNGLS setValue:self.empFrom10.text forKey:@"emp10From"];
    [self.managedObjectNGLS setValue:self.empTo10.text forKey:@"emp10To"];
    [self.managedObjectNGLS setValue:self.empNoise10.text forKey:@"emp10Noise"];
    [self.managedObjectNGLS setValue:self.empExposure10.text forKey:@"emp10Exposure"];
    
    NSLog(@"%@", self.managedObjectNGLS);
    
    // Allocate & initialise OtherInfoViewController
    ServicesViewController *services = [[ServicesViewController alloc]initWithNibName:@"ServicesViewController"
                                                                                      bundle:nil];
    
    // Pass managedObject to view
    services.managedObjectNGLS = self.managedObjectNGLS;
    
    // Push next view
    [self.navigationController pushViewController:services animated:YES];
}

@end
