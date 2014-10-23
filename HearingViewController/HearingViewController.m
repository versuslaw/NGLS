//
//  HearingViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 11/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "HearingViewController.h"
#import "ServicesViewController.h"
#import "NoisyViewController.h"
#import "AcceptedCharacters.h"

@interface HearingViewController ()

@end

@implementation HearingViewController

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
    self.navigationItem.title = @"Hearing";
    
    // Create 'next' navbar item
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc]initWithTitle:@"Next"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(nextBtnPressed:)];
    self.navigationItem.rightBarButtonItem = nextBtn;
    nextBtn.enabled = TRUE;
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    // Default all segments to 'no'
    self.q1Seg.selectedSegmentIndex = 1;
    self.q2Seg.selectedSegmentIndex = 1;
    self.q3Seg.selectedSegmentIndex = 1;
    self.q4Seg.selectedSegmentIndex = 1;
    
    // Disable textfields as default
    self.q1More.enabled = NO;
    self.q2More.enabled = NO;
    self.q3More.enabled = NO;
    self.q4More.enabled = NO;
    
    
    
    // Set delegate on textfield
    self.q1More.delegate = self;
    self.q2More.delegate = self;
    self.q3More.delegate = self;
    self.q4More.delegate = self;
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
    // Call AcceptedCharacters class on Further Details textfields
    if ([textField isKindOfClass:[AcceptedCharacters class]]) {
        return [(AcceptedCharacters *)textField stringIsAcceptable:string inRange:range];
    }
    return YES;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    // If segment = Yes, enable & focus on textfield
    if (self.q1Seg.selectedSegmentIndex == 0) {
        self.q1More.enabled = YES;
        [self.q1More becomeFirstResponder];
        // If segment = No, disable & clear textfield
    } else if (self.q1Seg.selectedSegmentIndex == 1) {
        self.q1More.enabled = NO;
        self.q1More.text = nil;
    }
    
    if (self.q2Seg.selectedSegmentIndex == 0) {
        self.q2More.enabled = YES;
        [self.q2More becomeFirstResponder];
    } else if (self.q2Seg.selectedSegmentIndex == 1) {
        self.q2More.enabled = NO;
        self.q2More.text = nil;
    }
    
    if (self.q3Seg.selectedSegmentIndex == 0) {
        self.q3More.enabled = YES;
        [self.q3More becomeFirstResponder];
    } else if (self.q3Seg.selectedSegmentIndex == 1) {
        self.q3More.enabled = NO;
        self.q3More.text = nil;
    }
    
    if (self.q4Seg.selectedSegmentIndex == 0) {
        self.q4More.enabled = YES;
        [self.q4More becomeFirstResponder];
    } else if (self.q4Seg.selectedSegmentIndex == 1) {
        self.q4More.enabled = NO;
        self.q4More.text = nil;
    }
}

- (IBAction)nextBtnPressed:(UIButton *)sender {
    _infoAlert = [[UIAlertView alloc]initWithTitle:@"More information required"
                                                       message:@"Please enter further details"
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
    
    // If segment = "Yes", user must provide Further Information
    if ([[self.q1Seg titleForSegmentAtIndex:self.q1Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.q1More.text.length <= 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    if ([[self.q2Seg titleForSegmentAtIndex:self.q2Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.q2More.text.length <= 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    if ([[self.q3Seg titleForSegmentAtIndex:self.q3Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.q3More.text.length <= 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    if ([[self.q4Seg titleForSegmentAtIndex:self.q4Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.q4More.text.length <= 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    NSString *q1 = [self.q1Seg titleForSegmentAtIndex:self.q1Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:q1 forKey:@"q1"];
    [self.managedObjectNGLS setValue:self.q1More.text forKey:@"q1More"];
    
    NSString *q2 = [self.q2Seg titleForSegmentAtIndex:self.q2Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:q2 forKey:@"q2"];
    [self.managedObjectNGLS setValue:self.q2More.text forKey:@"q2More"];
    
    NSString *q3 = [self.q3Seg titleForSegmentAtIndex:self.q3Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:q3 forKey:@"q3"];
    [self.managedObjectNGLS setValue:self.q3More.text forKey:@"q3More"];
    
    NSString *q4 = [self.q4Seg titleForSegmentAtIndex:self.q4Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:q4 forKey:@"q4"];
    [self.managedObjectNGLS setValue:self.q4More.text forKey:@"q4More"];
    
    NSLog(@"%@", self.managedObjectNGLS);
    
    // If client has worked in noisy environment, push employer questions
    if ([[self.noisyWork titleForSegmentAtIndex:self.noisyWork.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (!_infoAlert.visible) {
            // Allocate & initialise OtherInfoViewController
            NoisyViewController *noisy = [[NoisyViewController alloc]initWithNibName:@"NoisyViewController"
                                                                              bundle:nil];
            
            // Pass managedObject to view
            noisy.managedObjectNGLS = self.managedObjectNGLS;
            
            // Push next view
            [self.navigationController pushViewController:noisy animated:YES];
        }
    } else {
        // Allocate & initialise ServicesViewController
        ServicesViewController *services = [[ServicesViewController alloc]initWithNibName:@"ServicesViewController"
                                                                                          bundle:nil];
        
        // Pass managedObject to view
        services.managedObjectNGLS = self.managedObjectNGLS;
        
        // Push next view
        [self.navigationController pushViewController:services animated:YES];
    }
}

@end
