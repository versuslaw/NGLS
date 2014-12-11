//
//  ServicesViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 11/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "ServicesViewController.h"
#import "Model.h"
#import "NGLSAppDelegate.h"
#import "INDViewController.h"
#import "ASBViewController.h"
#import "AAWViewController.h"
#import "RTAViewController.h"
#import "VWFViewController.h"
#import "BPViewController.h"
#import "PPIViewController.h"
#import "MSLMViewController.h"
#import "PBAViewController.h"
#import "MSPViewController.h"
#import "RCFViewController.h"
#import "WPViewController.h"
#import "CONVViewController.h"
#import "LettersOnly.h"
#import "PhoneNumber.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'&-_."

@interface ServicesViewController ()
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ServicesViewController

@synthesize moreInfo;
@synthesize qConfirm;
@synthesize alertTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/* 
 * HOW-TO: Set up UIScrollView with IB
 * - ServicesViewController.xib
 * - Shift + right-click, View > Attributes Inspector > Size > Freeform
 * - Size Inspector > change height
 * - Make background image very long
 * - Rearrange buttons etc (shift down slightly)
 * - Click on button, cmd + A > Editor > Embed In > ScrollView
 * - Click on button, cmd + A > Editor > Embed In > View
 * - Hook up ScrollView & View to ServicesViewController.m under @interface
 * - Uncomment section below
 * // Need to work on keyboard scroll bug //
 
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardWillHide:)];
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapGesture];
}

 *
 */

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
    self.navigationItem.title = @"Services";
    
    // Create 'Home' navbar button
    UIBarButtonItem *homeBtn = [[UIBarButtonItem alloc]initWithTitle:@"Home"
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(homeBtnPressed:)];
    self.navigationItem.rightBarButtonItem = homeBtn;
    homeBtn.enabled = TRUE;
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    
    // Set delegate on textfield
    self.otherTextField.delegate = self;
    self.recName.delegate = self;
    self.recTel.delegate = self;
    
    // If otherService is empty, disable textfield
    NSString *otherServices = [_managedObjectNGLS valueForKey:@"otherServices"];
    if (otherServices.length == 0) {
        self.otherTextField.enabled = FALSE;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    // This method is called every time the view appears
    [self isInterested];
    //NSLog(@"viewWillAppear called");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Call AcceptedCharacters subclass on Other & Name textfields
    if ([textField isKindOfClass:[LettersOnly class]]) {
        return [(LettersOnly *)textField stringIsAcceptable:string inRange:range];
    }
    
    // Call PhoneNumber subclass on telephone textfield
    if ([textField isKindOfClass:[PhoneNumber class]]) {
        return [(PhoneNumber *)textField stringIsAcceptable:string inRange:range];
    }
    
    // Return ACCEPTABLE_CHARACTERS on all UIAlertView textfields (calling subclass is illegal)
    if (textField.tag == 100) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }

    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Dismiss keyboard when user taps anywhere on view
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // If otherTextField is empty, set otherBtn attributes
    if (self.otherTextField.text.length == 0) {
        _otherBtn.backgroundColor = [UIColor redColor];
        _otherBtn.enabled = TRUE;
        // Disable otherTextField
        self.otherTextField.enabled = FALSE;
        self.otherTextField.placeholder = @"Please tap 'Other' button";
        [_managedObjectNGLS setValue:_otherTextField.text forKey:@"otherServices"];
    }
    
    // If otherTextField isn't empty, disable otherBtn & set background colour
    if (self.otherTextField.text.length > 0) {
        [_otherBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
        //_otherBtn.enabled = FALSE;
        [_managedObjectNGLS setValue:_otherTextField.text forKey:@"otherServices"];
    } else {
        [_otherBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
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

- (void)qConfirmAlert {
    // Alloc & init qConfirm UIAlertView
    qConfirm = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@", _btnTitle]
                                         message:@"Would you like to give additional information by answering some short related questions?"
                                        delegate:self
                               cancelButtonTitle:@"No"
                               otherButtonTitles:@"Proceed", nil];
}

- (void)isInterested {
    // Perform tests to determine button state
    // If <key> is "yes", keep button in selected state
    // If <keyDetails> isn't empty, disable button & change colour
    
    // IND
    if ([[_managedObjectNGLS valueForKey:@"ind"] isEqual: @"Yes"]) {
        _indBtn.selected = YES;
    }
    if ([[_managedObjectNGLS valueForKey:@"indSurvey"] isEqual: @"Yes"]) {
        _indBtn.selected = NO;
        [_indBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_indBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // ASB
    if ([[_managedObjectNGLS valueForKey:@"asb"] isEqual: @"Yes"]) {
        _asbBtn.selected = YES;
    }
    NSString *asbDetails = [_managedObjectNGLS valueForKey:@"asbDetails"];
    if (asbDetails.length > 0) {
        _asbBtn.selected = NO;
        [_asbBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_asbBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // VWF
    if ([[_managedObjectNGLS valueForKey:@"vwf"] isEqual: @"Yes"]) {
        _vwfBtn.selected = YES;
    }
    if ([[_managedObjectNGLS valueForKey:@"vwfSurvey"] isEqual: @"Yes"]) {
        _vwfBtn.selected = NO;
        [_vwfBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_vwfBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // BP
    if ([[_managedObjectNGLS valueForKey:@"bp"] isEqual: @"Yes"]) {
        _bpBtn.selected = YES;
    }
    NSString *bpDetails = [_managedObjectNGLS valueForKey:@"bpDetails"];
    if (bpDetails.length > 0) {
        _bpBtn.selected = NO;
        [_bpBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_bpBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // RTA
    if ([[_managedObjectNGLS valueForKey:@"rta"] isEqual: @"Yes"]) {
        _rtaBtn.selected = YES;
    }
    NSString *rtaDetails = [_managedObjectNGLS valueForKey:@"rtaDetails"];
    if (rtaDetails.length > 0) {
        _rtaBtn.selected = NO;
        [_rtaBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_rtaBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // MSLM
    if ([[_managedObjectNGLS valueForKey:@"mslm"] isEqual: @"Yes"]) {
        _mslmBtn.selected = YES;
    }
    NSString *mslmDetails = [_managedObjectNGLS valueForKey:@"mslmDetails"];
    if (mslmDetails.length > 0) {
        _mslmBtn.selected = NO;
        [_mslmBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_mslmBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // PBA
    if ([[_managedObjectNGLS valueForKey:@"pba"] isEqual: @"Yes"]) {
        _pbaBtn.selected = YES;
    }
    NSString *pbaDetails = [_managedObjectNGLS valueForKey:@"pbaDetails"];
    if (pbaDetails.length > 0) {
        _pbaBtn.selected = NO;
        [_pbaBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_pbaBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // RCF
    if ([[_managedObjectNGLS valueForKey:@"rcf"] isEqual: @"Yes"]) {
        _rcfBtn.selected = YES;
    }
    NSString *rcfDetails = [_managedObjectNGLS valueForKey:@"rcfDetails"];
    if (rcfDetails.length > 0) {
        _rcfBtn.selected = NO;
        [_rcfBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_rcfBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // MSP
    if ([[_managedObjectNGLS valueForKey:@"msp"] isEqual: @"Yes"]) {
        _mspBtn.selected = YES;
    }
    NSString *mspDetails = [_managedObjectNGLS valueForKey:@"mspDetails"];
    if (mspDetails.length > 0) {
        _mspBtn.selected = NO;
        [_mspBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_mspBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // WP
    if ([[_managedObjectNGLS valueForKey:@"wp"] isEqual: @"Yes"]) {
        _wpBtn.selected = YES;
    }
    NSString *wpDetails = [_managedObjectNGLS valueForKey:@"wpDetails"];
    if (wpDetails.length > 0) {
        _wpBtn.selected = NO;
        [_wpBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_wpBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // AAW
    if ([[_managedObjectNGLS valueForKey:@"aaw"] isEqual: @"Yes"]) {
        _aawBtn.selected = YES;
    }
    NSString *aawDetails = [_managedObjectNGLS valueForKey:@"aawDetails"];
    if (aawDetails.length > 0) {
        _aawBtn.selected = NO;
        [_aawBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_aawBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // PPI
    if ([[_managedObjectNGLS valueForKey:@"ppi"] isEqual: @"Yes"]) {
        _ppiBtn.selected = YES;
    }
    NSString *ppiDetails = [_managedObjectNGLS valueForKey:@"ppiDetails"];
    if (ppiDetails.length > 0) {
        _ppiBtn.selected = NO;
        [_ppiBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_ppiBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // CONV
    if ([[_managedObjectNGLS valueForKey:@"conv"] isEqual: @"Yes"]) {
        _convBtn.selected = YES;
    }
    NSString *convDetails = [_managedObjectNGLS valueForKey:@"convDetails"];
    if (convDetails.length > 0) {
        _convBtn.selected = NO;
        [_convBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
    } else {
        [_convBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    }
    
    // OTHER
    NSString *otherServices = [_managedObjectNGLS valueForKey:@"otherServices"];
    if (otherServices.length > 1) {
        [_otherBtn setBackgroundImage:[UIImage imageNamed:@"Button-Completed.png"] forState:UIControlStateNormal];
        // Populate textField with previously entered text
        self.otherTextField.text = otherServices;
        //_otherBtn.enabled = FALSE;
        self.otherTextField.enabled = TRUE;
    }
}

- (IBAction)indBtnPressed:(UIButton *)sender {
    // If button is not selected
    if ([sender isSelected]) {
        [sender setSelected:NO];
        // Set blank value
        [_managedObjectNGLS setValue:@"" forKey:@"ind"];
    } else {
        // If button is selected
        [sender setSelected:YES];
        // Set "Yes" for interested
        [_managedObjectNGLS setValue:@"Yes" forKey:@"ind"];
    }

    // If button is selected
    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *indSurvey = [_managedObjectNGLS valueForKey:@"indSurvey"];
        // If indSurvey key isn't empty, there must be an entry already submitted
        if (indSurvey.length > 0) {
            // Push view for editing
            INDViewController *ind = [[INDViewController alloc]initWithNibName:@"INDViewController"
                                                                        bundle:nil];
            ind.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:ind animated:YES];
             // Else, show qConfirm alert
        } else {
            // Set button title for qConfirmAlert
            _btnTitle = sender.titleLabel.text;
            // Call qConfirm method to alloc & init alert
            [self qConfirmAlert];
            // Set alert tag
            qConfirm.tag = 1;
            // Show the alert
            [qConfirm show];
        }
    }
}

- (IBAction)asbBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"asb"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"asb"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *asbDetails = [_managedObjectNGLS valueForKey:@"asbDetails"];
        if (asbDetails.length > 0) {
            ASBViewController *asb = [[ASBViewController alloc]initWithNibName:@"ASBViewController"
                                                                        bundle:nil];
            asb.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:asb animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 2;
            [qConfirm show];
        }
    }
}

- (IBAction)vwfBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"vwf"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"vwf"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *vwfSurvey = [_managedObjectNGLS valueForKey:@"vwfSurvey"];
        if (vwfSurvey.length > 0) {
            VWFViewController *vwf = [[VWFViewController alloc]initWithNibName:@"VWFViewController"
                                                                        bundle:nil];
            vwf.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:vwf animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 3;
            [qConfirm show];
        }
    }
}

- (IBAction)bpBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"bp"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"bp"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *bpDetails = [_managedObjectNGLS valueForKey:@"bpDetails"];
        if (bpDetails.length > 0) {
            BPViewController *bp = [[BPViewController alloc]initWithNibName:@"BPViewController"
                                                                     bundle:nil];
            bp.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:bp animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 4;
            [qConfirm show];
        }
    }
}

- (IBAction)rtaBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"rta"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"rta"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *rtaDetails = [_managedObjectNGLS valueForKey:@"rtaDetails"];
        if (rtaDetails.length > 0) {
            RTAViewController *rta = [[RTAViewController alloc]initWithNibName:@"RTAViewController"
                                                                        bundle:nil];
            rta.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:rta animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 5;
            [qConfirm show];
        }
    }
}

- (IBAction)mslmBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"mslm"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"mslm"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *mslmDetails = [_managedObjectNGLS valueForKey:@"mslmDetails"];
        if (mslmDetails.length > 0) {
            MSLMViewController *mslm = [[MSLMViewController alloc]initWithNibName:@"MSLMViewController"
                                                                           bundle:nil];
            mslm.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:mslm animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 6;
            [qConfirm show];
        }
    }
}

- (IBAction)pbaBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"pba"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"pba"];
    }
    
    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *pbaDetails = [_managedObjectNGLS valueForKey:@"pbaDetails"];
        if (pbaDetails.length > 0) {
            PBAViewController *pba = [[PBAViewController alloc]initWithNibName:@"PBAViewController"
                                                                        bundle:nil];
            pba.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:pba animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 7;
            [qConfirm show];
        }
    }
}

- (IBAction)rcfBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"rcf"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"rcf"];
    }
    
    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *rcfDetails = [_managedObjectNGLS valueForKey:@"rcfDetails"];
        if (rcfDetails.length > 0) {
            RCFViewController *rcf = [[RCFViewController alloc]initWithNibName:@"RCFViewController"
                                                                        bundle:nil];
            rcf.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:rcf animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 8;
            [qConfirm show];
        }
    }
}

- (IBAction)mspBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"msp"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"msp"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *mspDetails = [_managedObjectNGLS valueForKey:@"mspDetails"];
        if (mspDetails.length > 0) {
            MSPViewController *msp = [[MSPViewController alloc]initWithNibName:@"MSPViewController"
                                                                        bundle:nil];
            msp.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:msp animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 9;
            [qConfirm show];
        }
    }
}

- (IBAction)aawBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"aaw"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"aaw"];
    }

    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *aawDetails = [_managedObjectNGLS valueForKey:@"aawDetails"];
        if (aawDetails.length > 0) {
            AAWViewController *aaw = [[AAWViewController alloc]initWithNibName:@"AAWViewController"
                                                                        bundle:nil];
            aaw.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:aaw animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 10;
            [qConfirm show];
        }
    }
}

- (IBAction)ppiBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"ppi"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"ppi"];
    }
    
    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *ppiDetails = [_managedObjectNGLS valueForKey:@"ppiDetails"];
        if (ppiDetails.length > 0) {
            PPIViewController *ppi = [[PPIViewController alloc]initWithNibName:@"PPIViewController"
                                                                        bundle:nil];
            ppi.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:ppi animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 11;
            [qConfirm show];
        }
    }
}

- (IBAction)wpBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"wp"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"wp"];
    }
    
    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *wpDetails = [_managedObjectNGLS valueForKey:@"wpDetails"];
        if (wpDetails.length > 0) {
            WPViewController *wp = [[WPViewController alloc]initWithNibName:@"WPViewController"
                                                                     bundle:nil];
            wp.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:wp animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 12;
            [qConfirm show];
        }
    }
}

- (IBAction)convBtnPressed:(UIButton *)sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"conv"];
    } else {
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"conv"];
    }
    
    if (sender.isSelected == YES) {
        NSLog(@"%@", sender.titleLabel.text);
        NSString *convDetails = [_managedObjectNGLS valueForKey:@"convDetails"];
        if (convDetails.length > 0) {
            CONVViewController *conv = [[CONVViewController alloc]initWithNibName:@"CONVViewController"
                                                                           bundle:nil];
            conv.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:conv animated:YES];
        } else {
            _btnTitle = sender.titleLabel.text;
            [self qConfirmAlert];
            qConfirm.tag = 13;
            [qConfirm show];
        }
    }
}

- (IBAction)otherBtnPressed:(id)sender {
    // Enable textField & become active
    self.otherTextField.enabled = YES;
    [self.otherTextField becomeFirstResponder];
    self.otherTextField.placeholder = @"Enter legal service";
}

- (IBAction)homeBtnPressed:(UIButton *) sender {
    // If recTel field is populated
    if (self.recTel.text.length > 0) {
        // If length is less than 11
        if (self.recTel.text.length < 11) {
            _invalidPhone = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                 message:@"Please enter a valid phone number for the recommendation"
                                                                delegate:nil
                                                       cancelButtonTitle:@"Dismiss"
                                                       otherButtonTitles:nil];
            [_invalidPhone show];
        }
    }
    
    UIAlertView *successMsg = [[UIAlertView alloc]initWithTitle:@"Submit Survey"
                                                        message:@"Would you like to save and submit this questionnaire?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Submit", nil];
    successMsg.tag = 14;
    if (!_invalidPhone.visible) {
       [successMsg show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // IND
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            // Set "Yes" for indSurvey
            [_managedObjectNGLS setValue:@"Yes" forKey:@"indSurvey"];
            
            // Allocate & initialise INDViewController
            INDViewController *ind = [[INDViewController alloc]initWithNibName:@"INDViewController"
                                                                        bundle:nil];
            
            // Pass managedObject to view
            ind.managedObjectNGLS = self.managedObjectNGLS;
            
            // Push next view
            [self.navigationController pushViewController:ind animated:YES];
        }
    }
    
    // ASB
    if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            ASBViewController *asb = [[ASBViewController alloc]initWithNibName:@"ASBViewController"
                                                                        bundle:nil];
            asb.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:asb animated:YES];
        }
    }
    
    // VWF
    if (alertView.tag == 3) {
        if (buttonIndex == 1) {
            [_managedObjectNGLS setValue:@"Yes" forKey:@"vwfSurvey"];
            VWFViewController *vwf = [[VWFViewController alloc]initWithNibName:@"VWFViewController"
                                                                        bundle:nil];
            vwf.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:vwf animated:YES];
        }
    }
    
    // BP
    if (alertView.tag == 4) {
        if (buttonIndex == 1) {
            BPViewController *bp = [[BPViewController alloc]initWithNibName:@"BPViewController"
                                                                    bundle:nil];
            bp.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:bp animated:YES];
        }
    }
    
    // RTA
    if (alertView.tag == 5) {
        if (buttonIndex == 1) {
            RTAViewController *rta = [[RTAViewController alloc]initWithNibName:@"RTAViewController"
                                                                        bundle:nil];
            rta.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:rta animated:YES];
        }
    }
    
    // MSLM
    if (alertView.tag == 6) {
        if (buttonIndex == 1) {
            MSLMViewController *mslm = [[MSLMViewController alloc]initWithNibName:@"MSLMViewController"
                                                                        bundle:nil];
            mslm.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:mslm animated:YES];
        }
    }
    
    // PBA
    if (alertView.tag == 7) {
        if (buttonIndex == 1) {
            PBAViewController *pba = [[PBAViewController alloc]initWithNibName:@"PBAViewController"
                                                                           bundle:nil];
            pba.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:pba animated:YES];
        }
    }
    
    // RCF
    if (alertView.tag == 8) {
        if (buttonIndex == 1) {
            RCFViewController *rcf = [[RCFViewController alloc]initWithNibName:@"RCFViewController"
                                                                        bundle:nil];
            rcf.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:rcf animated:YES];
        }
    }
    
    // MSP
    if (alertView.tag == 9) {
        if (buttonIndex == 1) {
            MSPViewController *msp = [[MSPViewController alloc]initWithNibName:@"MSPViewController"
                                                                        bundle:nil];
            msp.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:msp animated:YES];
        }
    }
    
    // AAW
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {
            AAWViewController *aaw = [[AAWViewController alloc]initWithNibName:@"AAWViewController"
                                                                        bundle:nil];
            aaw.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:aaw
                                                 animated:YES];
        }
    }
    
    // PPI
    if (alertView.tag == 11) {
        if (buttonIndex == 1) {
            PPIViewController *ppi = [[PPIViewController alloc]initWithNibName:@"PPIViewController"
                                                                        bundle:nil];
            ppi.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:ppi
                                                 animated:YES];
        }
    }
    
    // WP
    if (alertView.tag == 12) {
        if (buttonIndex == 1) {
            WPViewController *wp = [[WPViewController alloc]initWithNibName:@"WPViewController"
                                                                        bundle:nil];
            wp.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:wp
                                                 animated:YES];
        }
    }
    
    // CONV
    if (alertView.tag == 13) {
        if (buttonIndex == 1) {
            CONVViewController *conv = [[CONVViewController alloc]initWithNibName:@"CONVViewController"
                                                                     bundle:nil];
            conv.managedObjectNGLS = self.managedObjectNGLS;
            [self.navigationController pushViewController:conv
                                                 animated:YES];
        }
    }
    
    // Home
    if (alertView.tag == 14) {
        if (buttonIndex == 1) {
            NSLog(@"%ld", (long)buttonIndex);
            [self surveyComplete];
        }
    }
}

- (NSString *)dataFilePath {
    // Build path to .csv file
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                        NSUserDomainMask,
                                                        YES);
    NSString *docDir = [path objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:@"NGLS_export.csv"];
}

- (void)surveyComplete {
    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    // Fetch objects from Admin entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Admin"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // Fetch last admin object
    Model *admin = [fetchedObjects lastObject];
    
    // Set username/site keys in NGLS entity to values of last objects in Admin entity
    [_managedObjectNGLS setValue:admin.userLogin forKey:@"username"];
    [_managedObjectNGLS setValue:admin.siteLocation forKey:@"site"];
    
    [_managedObjectNGLS setValue:_recName.text forKey:@"recName"];
    [_managedObjectNGLS setValue:_recTel.text forKey:@"recTel"];
    
    // Call blankData in Model.m to insert "" values
    Model *callMethod = [[Model alloc]init];
    callMethod.managedObjectNGLS = self.managedObjectNGLS;
    [callMethod blankData];
    
    // Save context
    [[self.managedObjectAdmin managedObjectContext] save:&error];
    [[self.managedObjectNGLS managedObjectContext] save:&error];
    NSLog(@"%@", self.managedObjectNGLS);
    
    // Fetch objects from NGLS entity
    NSFetchRequest *totalFetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *NGLSentity = [NSEntityDescription entityForName:@"NGLS"
                                                  inManagedObjectContext:context];
    [totalFetchRequest setEntity:NGLSentity];
    NSArray *totalFetchedObjects = [context executeFetchRequest:totalFetchRequest error:&error];
    NSLog(@"%@", [NSString stringWithFormat:@"Total records: %lu", (unsigned long)[totalFetchedObjects count]]);
    
    // Delete .csv to avoid duplicate entries
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:NULL];
        NSLog(@"NGLS_export.csv deleted");
    }
    
    // Pop to root view
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
