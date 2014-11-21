//
//  VWFViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 21/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "VWFViewController.h"
#import "ServicesViewController.h"

@interface VWFViewController ()

@end

@implementation VWFViewController

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
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc]initWithTitle:@"Next"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(nextBtnPressed:)];
    self.navigationItem.rightBarButtonItem = nextBtn;
    nextBtn.enabled = TRUE;
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
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

- (IBAction)nextBtnPressed:(UIButton *)sender {
    _infoAlert = [[UIAlertView alloc]initWithTitle:@"More information required"
                                           message:@"Please enter further details"
                                          delegate:nil
                                 cancelButtonTitle:@"Dismiss"
                                 otherButtonTitles:nil];
    
//    // If segment = "Yes", user must provide Further Information
//    if ([[self.indQ1Seg titleForSegmentAtIndex:self.indQ1Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
//        if (self.indQ1More.text.length == 0) {
//            if (!_infoAlert.visible) {
//                [_infoAlert show];
//            }
//        }
//    }
//    
//    if ([[self.indQ2Seg titleForSegmentAtIndex:self.indQ2Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
//        if (self.indQ2More.text.length == 0) {
//            if (!_infoAlert.visible) {
//                [_infoAlert show];
//            }
//        }
//    }
//    
//    if ([[self.indQ3Seg titleForSegmentAtIndex:self.indQ3Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
//        if (self.indQ3More.text.length == 0) {
//            if (!_infoAlert.visible) {
//                [_infoAlert show];
//            }
//        }
//    }
//    
//    if ([[self.indQ4Seg titleForSegmentAtIndex:self.indQ4Seg.selectedSegmentIndex] isEqualToString:@"Yes"]) {
//        if (self.indQ4More.text.length == 0) {
//            if (!_infoAlert.visible) {
//                [_infoAlert show];
//            }
//        }
//    }
    
    // Save values
    NSString *vwfQ1 = [self.vwfQ1 titleForSegmentAtIndex:self.vwfQ1.selectedSegmentIndex];
    [self.managedObjectNGLS setValue:vwfQ1 forKey:@"vwfQ1"];
    
    [self.managedObjectNGLS setValue:self.vwfQ2.text forKey:@"vwfQ2"];
    
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
    

    // Allocate & initialise ServicesViewController
    ServicesViewController *services = [[ServicesViewController alloc]initWithNibName:@"ServicesViewController"
                                                                               bundle:nil];
        
    // Pass managedObject to view
    services.managedObjectNGLS = self.managedObjectNGLS;
        
    // Push next view
    [self.navigationController pushViewController:services animated:YES];
}

@end
