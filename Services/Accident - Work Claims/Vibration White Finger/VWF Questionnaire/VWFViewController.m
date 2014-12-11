//
//  VWFViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 21/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "VWFViewController.h"
#import "ServicesViewController.h"
#import "AcceptedCharactersTextView.h"

@interface VWFViewController ()

@end

@implementation VWFViewController

@synthesize datePicker;

- (void)viewDidLoad {
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
    self.navigationItem.title = @"Vibration White Finger";
    
    // Create 'next' navbar item
    UIBarButtonItem *servicesBtn = [[UIBarButtonItem alloc]initWithTitle:@"Services"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(servicesBtnPressed:)];
    self.navigationItem.rightBarButtonItem = servicesBtn;
    servicesBtn.enabled = TRUE;
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    // Default all segments to 'no'
    self.vwfQ1.selectedSegmentIndex = 1;
    self.vwfQ2.selectedSegmentIndex = 1;
    self.vwfQ3.selectedSegmentIndex = 1;
    self.vwfQ4.selectedSegmentIndex = 1;
    self.vwfQ5.selectedSegmentIndex = 1;
    
    // Set textView delegate
    self.vwfQ8.delegate = self;
    
    // Call datePicker
    [self datePickerTextField];
    
    // Listen for datePicker changes
    [datePicker addTarget:self
                   action:@selector(updateDateTextField)
         forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
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

- (void)datePickerTextField {
    // Open datePicker when textfield is tapped
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    // Set default date
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setDay:1];
    [components setMonth:1];
    [components setYear:1980];
    NSDate *defaultDate = [calendar dateFromComponents:components];
    [datePicker setDate:defaultDate];
    [datePicker setMaximumDate:[NSDate date]];

    datePicker.backgroundColor = [UIColor clearColor];
    
    // Set input views
    [self.vwfQ7 setInputView:datePicker];
    [self.vwfQ9 setInputView:datePicker];
}

- (void)updateDateTextField {
    // Update textfield when picker is scrolled
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:datePicker.date];
    
    // Check active textfield and update with date
    if ([self.vwfQ7 isFirstResponder]) {
        self.vwfQ7.text = [NSString stringWithFormat:@"%@", stringFromDate];
    }
    
    if ([self.vwfQ9 isFirstResponder]) {
        self.vwfQ9.text = [NSString stringWithFormat:@"%@", stringFromDate];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([textView isKindOfClass:[AcceptedCharactersTextView class]]) {
        return [(AcceptedCharactersTextView *)textView stringIsAcceptable:text inRange:range];
    }
    return YES;
}

- (IBAction)servicesBtnPressed:(UIButton *)sender {
    // Save values
    NSString *vwfQ1 = [self.vwfQ1 titleForSegmentAtIndex:self.vwfQ1.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:vwfQ1 forKey:@"vwfQ1"];
    NSString *vwfQ2 = [self.vwfQ2 titleForSegmentAtIndex:self.vwfQ2.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:vwfQ2 forKey:@"vwfQ2"];
    NSString *vwfQ3 = [self.vwfQ3 titleForSegmentAtIndex:self.vwfQ3.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:vwfQ3 forKey:@"vwfQ3"];
    NSString *vwfQ4 = [self.vwfQ4 titleForSegmentAtIndex:self.vwfQ4.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:vwfQ4 forKey:@"vwfQ4"];
    NSString *vwfQ5 = [self.vwfQ5 titleForSegmentAtIndex:self.vwfQ5.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:vwfQ5 forKey:@"vwfQ5"];
    [self.managedObjectNGLS setValue:self.vwfQ6.text forKey:@"vwfQ6"];
    [self.managedObjectNGLS setValue:self.vwfQ7.text forKey:@"vwfQ7"];
    [self.managedObjectNGLS setValue:self.vwfQ8.text forKey:@"vwfQ8"];
    [self.managedObjectNGLS setValue:self.vwfQ9.text forKey:@"vwfQ9"];
    
    NSLog(@"%@", self.managedObjectNGLS);
    
    // Pop to services
    NSArray *array = [self.navigationController viewControllers];
    for (int i= 0 ; i < [[self.navigationController viewControllers]count] ; i++) {
        if ( [[[self.navigationController viewControllers] objectAtIndex:i] isKindOfClass:[ServicesViewController class]]) {
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
        }
    }
}

@end
