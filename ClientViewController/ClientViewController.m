//
//  ClientViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "ClientViewController.h"
#import "NGLSAppDelegate.h"
#import "ServicesViewController.h"
#import "Model.h"
#import "AcceptedCharacters.h"
#import "PostcodeField.h"
#import "PhoneNumber.h"

@interface ClientViewController ()

@end

@implementation ClientViewController

@synthesize datePicker;

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

    // Listen for lower-right keyboard hide button
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // Create new managed object using the NGLS entity description
    NSManagedObject *ManagedObjectNGLS;
    ManagedObjectNGLS = [NSEntityDescription insertNewObjectForEntityForName:@"NGLS"
                                                      inManagedObjectContext:context];
    self.managedObjectNGLS = ManagedObjectNGLS;
    
    // Set navbar title
    self.navigationItem.title = @"Client Details";
    
    // Create 'next' navbar item
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc]initWithTitle:@"Next"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                              action:@selector(nextBtnPressed:)];
    self.navigationItem.rightBarButtonItem = nextBtn;
    nextBtn.enabled = TRUE;
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    // Set delegate on textfields
    self.forenameField.delegate = self;
    self.surnameField.delegate = self;
    self.addLine1Field.delegate = self;
    self.addLine2Field.delegate = self;
    self.addLine3Field.delegate = self;
    self.addLine4Field.delegate = self;
    self.addLine5Field.delegate = self;
    self.postcodeField.delegate = self;
    self.telLandField.delegate = self;
    self.telMobField.delegate = self;
    self.emailField.delegate = self;
    self.dobField.delegate = self;
    self.niNumField.delegate = self;
    
    // Call datePicker
    [self datePickerTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Dismiss keyboard when user taps anywhere on view
    [self dismissKeyboard];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Dismiss keyboard when 'done' is pressed
    [self dismissKeyboard];
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return NO;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // Dismiss keyboard when lower-right hide button is tapped
    [self.view endEditing:YES];
    [self dismissKeyboard];
}

- (void)dismissKeyboard {
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.15f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // Animate frame up if lower textfields are tapped
    if (([textField isEqual:_emailField]) || ([textField isEqual:_dobField]) || ([textField isEqual:_niNumField])) {
        [UIView beginAnimations:nil
                    context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = -210;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    } else {
        // Return frame to original position if other textfields are tapped
        [self dismissKeyboard];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Call AcceptedCharacters subclass on Name/Address textfields
    if ([textField isKindOfClass:[AcceptedCharacters class]]) {
        return [(AcceptedCharacters *)textField stringIsAcceptable:string inRange:range];
    }
    
    // Call UpperCaseConvert subclass on Postcode textfield
    if ([textField isKindOfClass:[PostcodeField class]]) {
        return [(PostcodeField *)textField stringIsAcceptable:string inRange:range];
    }
    
    // Call PhoneNumber subclass on telephone textfields
    if ([textField isKindOfClass:[PhoneNumber class]]) {
        return [(PhoneNumber *)textField stringIsAcceptable:string inRange:range];
    }
    
    return YES;
}

- (void)dateStamped {
    // Convert date to string
    NSDate *sysDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateStamp = [formatter stringFromDate:sysDate];
    [self.managedObjectNGLS setValue:dateStamp forKey:@"dateStamp"];
}

- (void)titleSelected {
    // Set client title
    NSString *titleText = [self.titleSeg titleForSegmentAtIndex:self.titleSeg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:titleText forKey:@"clientTitle"];
}

- (void)clientName {
    // If fields are blank
    if ((self.forenameField.text.length == 0) || (self.surnameField.text.length == 0)) {
        _nameError = [[UIAlertView alloc]initWithTitle:@"Error"
                                               message:@"Please enter a valid name"
                                              delegate:self
                                     cancelButtonTitle:@"Dismiss"
                                     otherButtonTitles:nil];
        // Only display one error message
        if ((!_addError.visible) && (!_phoneError.visible)) {
            [_nameError show];
        }
    } else {
        [self.managedObjectNGLS setValue:self.forenameField.text forKey:@"clientForename"];
        [self.managedObjectNGLS setValue:self.surnameField.text forKey:@"clientSurname"];
    }
}

- (void) clientAddress {
    // If fields are blank
    if ((self.addLine1Field.text.length == 0) || (self.postcodeField.text.length == 0)) {
        _addError = [[UIAlertView alloc]initWithTitle:@"Error"
                                              message:@"Please enter a valid address"
                                             delegate:self
                                    cancelButtonTitle:@"Dismiss"
                                    otherButtonTitles:nil];
        // Only display one error message
        if ((!_nameError.visible) && (!_phoneError.visible)) {
            [_addError show];
        }
    } else {
        [self.managedObjectNGLS setValue:self.addLine1Field.text forKey:@"addLine1"];
        [self.managedObjectNGLS setValue:self.addLine2Field.text forKey:@"addLine2"];
        [self.managedObjectNGLS setValue:self.addLine3Field.text forKey:@"addLine3"];
        [self.managedObjectNGLS setValue:self.addLine4Field.text forKey:@"addLine4"];
        [self.managedObjectNGLS setValue:self.addLine5Field.text forKey:@"addLine5"];
        [self.managedObjectNGLS setValue:self.postcodeField.text forKey:@"clientPost"];
    }
}

- (void)clientTel {
    // If both phone numbers are blank
    if ((self.telLandField.text.length == 0) && (self.telMobField.text.length == 0)) {
        _phoneError = [[UIAlertView alloc]initWithTitle:@"Error"
                                                message:@"Please enter either a landline or mobile phone number"
                                               delegate:self
                                      cancelButtonTitle:@"Dismiss"
                                      otherButtonTitles:nil];
        // Only display one error message
        if((!_nameError.visible) && (!_addError.visible) && (!_emailError.visible)) {
            [_phoneError show];
        }
    } else {
        [self.managedObjectNGLS setValue:self.telLandField.text forKey:@"clientTelLand"];
        [self.managedObjectNGLS setValue:self.telMobField.text forKey:@"clientTelMob"];
    }
}

- (void) clientEmail {
    // Set predicate test for valid email
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if (_emailField.text.length > 0) {
        if ([emailTest evaluateWithObject:self.emailField.text] == NO) {
            _emailError = [[UIAlertView alloc] initWithTitle:@"Error"
                                                     message:@"Please enter a valid email address"
                                                    delegate:nil
                                           cancelButtonTitle:@"Dismiss"
                                           otherButtonTitles:nil];
            // Only display one error message
            if((!_nameError.visible) && (!_addError.visible) && (!_phoneError.visible)) {
                [_emailError show];
            }
        }
    }
}

- (void)datePickerTextField {
    // Open date picker when textfield is tapped
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker setMaximumDate:[NSDate date]];
    // Update textfield when picker is scrolled
    [datePicker addTarget:self
                   action:@selector(updateDateTextField:)
         forControlEvents:UIControlEventValueChanged];
    [self.dobField setInputView:datePicker];
    datePicker.backgroundColor = [UIColor clearColor];
}

- (void)updateDateTextField:(id)sender {
    // Update DoB textfield when date picker is scrolled
    datePicker = (UIDatePicker *) self.dobField.inputView;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:datePicker.date];
    self.dobField.text = [NSString stringWithFormat:@"%@", stringFromDate];
}

- (void)contactHours {
    // 0 = Morning, 1 = Afternoon, 2 = Evening
    NSString *contactNumber = [NSString stringWithFormat:@"%ld", (long)self.contactSeg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:contactNumber forKey:@"contactHours"];
}

- (void)nextBtnPressed:(UIButton *)sender {
    // Call methods
    [self dateStamped];
    [self titleSelected];
    [self clientName];
    [self clientAddress];
    [self clientEmail];
    [self clientTel];
    [self contactHours];
    
    [self.managedObjectNGLS setValue:self.dobField.text forKey:@"dateOfBirth"];
    [self.managedObjectNGLS setValue:self.emailField.text forKey:@"clientEmail"];
    [self.managedObjectNGLS setValue:self.niNumField.text forKey:@"clientNI"];
    NSLog(@"%@", self.managedObjectNGLS);
    
    // If no error messages are showing
    if ((!_nameError.visible) && (!_addError.visible) && (!_phoneError.visible) && (!_emailError.visible)) {

        // Allocate & initialise ServicesViewController
        ServicesViewController *services = [[ServicesViewController alloc]initWithNibName:@"ServicesViewController"
                                                                                   bundle:nil];
        
        // Pass managedObject to view
        services.managedObjectNGLS = self.managedObjectNGLS;
        services.managedObjectAdmin = self.managedObjectAdmin;

        // Push next view
        [self.navigationController pushViewController:services animated:YES];
    }
}

@end
