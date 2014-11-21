//
//  INDViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 11/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "INDViewController.h"
#import "ServicesViewController.h"
#import "INDEmpViewController.h"
#import "AcceptedCharacters.h"

@interface INDViewController ()

@end

@implementation INDViewController

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
    self.indQ1Seg.selectedSegmentIndex = 1;
    self.indQ2Seg.selectedSegmentIndex = 1;
    self.indQ3Seg.selectedSegmentIndex = 1;
    self.indQ4Seg.selectedSegmentIndex = 1;
    
    // Disable textfields as default
    self.indQ1More.enabled = NO;
    self.indQ2More.enabled = NO;
    self.indQ3More.enabled = NO;
    self.indQ4More.enabled = NO;
    
    // Set delegate on textfields
    self.indQ1More.delegate = self;
    self.indQ2More.delegate = self;
    self.indQ3More.delegate = self;
    self.indQ4More.delegate = self;
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
    if (self.indQ1Seg.selectedSegmentIndex == 0) {
        self.indQ1More.enabled = YES;
        [self.indQ1More becomeFirstResponder];
        // If segment = No, disable & clear textfield
    } else if (self.indQ1Seg.selectedSegmentIndex == 1) {
        self.indQ1More.enabled = NO;
        self.indQ1More.text = nil;
    }
    
    if (self.indQ2Seg.selectedSegmentIndex == 0) {
        self.indQ2More.enabled = YES;
        [self.indQ2More becomeFirstResponder];
    } else if (self.indQ2Seg.selectedSegmentIndex == 1) {
        self.indQ2More.enabled = NO;
        self.indQ2More.text = nil;
    }
    
    if (self.indQ3Seg.selectedSegmentIndex == 0) {
        self.indQ3More.enabled = YES;
        [self.indQ3More becomeFirstResponder];
    } else if (self.indQ3Seg.selectedSegmentIndex == 1) {
        self.indQ3More.enabled = NO;
        self.indQ3More.text = nil;
    }
    
    if (self.indQ4Seg.selectedSegmentIndex == 0) {
        self.indQ4More.enabled = YES;
        [self.indQ4More becomeFirstResponder];
    } else if (self.indQ4Seg.selectedSegmentIndex == 1) {
        self.indQ4More.enabled = NO;
        self.indQ4More.text = nil;
    }
}

- (IBAction)nextBtnPressed:(UIButton *)sender {
    _infoAlert = [[UIAlertView alloc]initWithTitle:@"More information required"
                                                       message:@"Please enter further details"
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
    
    // If segment = "Yes", user must provide Further Information
    if ([[self.indQ1Seg titleForSegmentAtIndex:self.indQ1Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.indQ1More.text.length == 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    if ([[self.indQ2Seg titleForSegmentAtIndex:self.indQ2Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.indQ2More.text.length == 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    if ([[self.indQ3Seg titleForSegmentAtIndex:self.indQ3Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.indQ3More.text.length == 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    if ([[self.indQ4Seg titleForSegmentAtIndex:self.indQ4Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (self.indQ4More.text.length == 0) {
            if (!_infoAlert.visible) {
                [_infoAlert show];
            }
        }
    }
    
    // Save values
    NSString *indQ1 = [self.indQ1Seg titleForSegmentAtIndex:self.indQ1Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:indQ1 forKey:@"indQ1"];
    [self.managedObjectNGLS setValue:self.indQ1More.text forKey:@"indQ1More"];
    
    NSString *indQ2 = [self.indQ2Seg titleForSegmentAtIndex:self.indQ2Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:indQ2 forKey:@"indQ2"];
    [self.managedObjectNGLS setValue:self.indQ2More.text forKey:@"indQ2More"];
    
    NSString *indQ3 = [self.indQ3Seg titleForSegmentAtIndex:self.indQ3Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:indQ3 forKey:@"indQ3"];
    [self.managedObjectNGLS setValue:self.indQ3More.text forKey:@"indQ3More"];
    
    NSString *indQ4 = [self.indQ4Seg titleForSegmentAtIndex:self.indQ4Seg.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:indQ4 forKey:@"indQ4"];
    [self.managedObjectNGLS setValue:self.indQ4More.text forKey:@"indQ4More"];
    
    NSLog(@"%@", self.managedObjectNGLS);
    
    // If client has worked in noisy environment, push employer questions
    if ([[self.noisyWork titleForSegmentAtIndex:self.noisyWork.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        if (!_infoAlert.visible) {
            // Allocate & initialise OtherInfoViewController
            INDEmpViewController *indEmp = [[INDEmpViewController alloc]initWithNibName:@"INDEmpViewController"
                                                                              bundle:nil];
            
            // Pass managedObject to view
            indEmp.managedObjectNGLS = self.managedObjectNGLS;
            
            // Push next view
            [self.navigationController pushViewController:indEmp animated:YES];
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
