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

- (IBAction)nextBtnPressed:(UIButton *)sender {
    _infoAlert = [[UIAlertView alloc]initWithTitle:@"More information required"
                                                       message:@"Please enter further details"
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
    
    // If "yes" is selected on segment, user must enter additional information
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
        
        // Else, go back to Services
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
