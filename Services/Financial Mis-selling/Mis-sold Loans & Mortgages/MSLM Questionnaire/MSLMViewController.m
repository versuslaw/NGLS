//
//  MSLMViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 28/11/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "MSLMViewController.h"
#import "ServicesViewController.h"
#import "AcceptedCharactersTextView.h"

@interface MSLMViewController ()

@end

@implementation MSLMViewController

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
    self.navigationItem.title = @"Mis-sold Loans & Mortgages";
    
    // Create 'next' navbar item
    UIBarButtonItem *servicesBtn = [[UIBarButtonItem alloc]initWithTitle:@"Services"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(servicesBtnPressed:)];
    self.navigationItem.rightBarButtonItem = servicesBtn;
    servicesBtn.enabled = TRUE;
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    // Set textView delegate
    self.mslmDetails.delegate = self;
    [self.mslmDetails becomeFirstResponder];
    
    NSString *mslmDetails = [_managedObjectNGLS valueForKey:@"mslmDetails"];
    if (mslmDetails.length > 0) {
        self.mslmDetails.text = mslmDetails;
    }
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([textView isKindOfClass:[AcceptedCharactersTextView class]]) {
        return [(AcceptedCharactersTextView *)textView stringIsAcceptable:text inRange:range];
    }
    return YES;
}

- (IBAction)servicesBtnPressed:(UIButton *)sender {
    [self.managedObjectNGLS setValue:self.mslmDetails.text forKey:@"mslmDetails"];
    NSLog(@"%@", self.managedObjectNGLS);
    
    // If textview is empty, push services view
    NSString *mslmDetails = [_managedObjectNGLS valueForKey:@"mslmDetails"];
    if (mslmDetails.length < 1) {
        ServicesViewController *services = [[ServicesViewController alloc]initWithNibName:@"ServicesViewController"
                                                                                   bundle:nil];
        services.managedObjectNGLS = self.managedObjectNGLS;
        [self.navigationController pushViewController:services animated:YES];
    } else {
        // Pop to services
        NSArray *array = [self.navigationController viewControllers];
        for (int i= 0 ; i < [[self.navigationController viewControllers]count] ; i++) {
            if ( [[[self.navigationController viewControllers] objectAtIndex:i] isKindOfClass:[ServicesViewController class]]) {
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
    }
}

@end
