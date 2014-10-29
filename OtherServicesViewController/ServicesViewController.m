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
#import "HearingViewController.h"
#import "AcceptedCharacters.h"
#import "PhoneNumber.h"
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'&-_."

@interface ServicesViewController ()

@end

@implementation ServicesViewController

@synthesize moreInfo;
@synthesize alertTextField;

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
    
    // Perform tests to determine button state
    [self isInterested];
    
    // Set delegate on textfield
    self.otherTextField.delegate = self;
    self.recName.delegate = self;
    self.recTel.delegate = self;
    
    // Call moreInfoAlert method
    [self moreInfoAlert];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Call AcceptedCharacters subclass on Other & Name textfields
    if ([textField isKindOfClass:[AcceptedCharacters class]]) {
        return [(AcceptedCharacters *)textField stringIsAcceptable:string inRange:range];
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

- (void)moreInfoAlert {
    // Alloc & init moreInfo UIAlertView
    moreInfo = [[UIAlertView alloc]initWithTitle:@"Additional Information"
                                         message:@"Would you like to give additional information?"
                                        delegate:self
                               cancelButtonTitle:@"Submit"
                               otherButtonTitles:nil];
    moreInfo.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [moreInfo textFieldAtIndex:0];
    self.alertTextField.delegate = self;
    alertTextField.autocorrectionType = UITextAutocorrectionTypeDefault;
    alertTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    alertTextField.tag = 100;
}

- (void)isInterested {
    // If <key> is "yes", keep button in selected state
    // If <keyDetails> isn't empty, disable button & change colour
    
    // IND
    if ([[_managedObjectNGLS valueForKey:@"ind"] isEqual: @"Yes"]) {
        _indBtn.selected = YES;
    }
    if ([[_managedObjectNGLS valueForKey:@"indSurvey"] isEqual: @"Yes"]) {
        _indBtn.selected = NO;
        _indBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _indBtn.enabled = FALSE;
    }
    
    // ASB
    if ([[_managedObjectNGLS valueForKey:@"asb"] isEqual: @"Yes"]) {
        _asbBtn.selected = YES;
    }
    NSString *asbDetails = [_managedObjectNGLS valueForKey:@"asbDetails"];
    if (asbDetails.length > 0) {
        _asbBtn.selected = NO;
        _asbBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _asbBtn.enabled = FALSE;
    }
    
    // VWF
    if ([[_managedObjectNGLS valueForKey:@"vwf"] isEqual: @"Yes"]) {
        _vwfBtn.selected = YES;
    }
    NSString *vwfDetails = [_managedObjectNGLS valueForKey:@"vwfDetails"];
    if (vwfDetails.length > 0) {
        _vwfBtn.selected = NO;
        _vwfBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _vwfBtn.enabled = FALSE;
    }
    
    // BP
    if ([[_managedObjectNGLS valueForKey:@"bp"] isEqual: @"Yes"]) {
        _bpBtn.selected = YES;
    }
    NSString *bpDetails = [_managedObjectNGLS valueForKey:@"bpDetails"];
    if (bpDetails.length > 0) {
        _bpBtn.selected = NO;
        _bpBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _bpBtn.enabled = FALSE;
    }
    
    // RTA
    if ([[_managedObjectNGLS valueForKey:@"rta"] isEqual: @"Yes"]) {
        _rtaBtn.selected = YES;
    }
    NSString *rtaDetails = [_managedObjectNGLS valueForKey:@"rtaDetails"];
    if (rtaDetails.length > 0) {
        _rtaBtn.selected = NO;
        _rtaBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _rtaBtn.enabled = FALSE;
    }
    
    // MSLM
    if ([[_managedObjectNGLS valueForKey:@"mslm"] isEqual: @"Yes"]) {
        _mslmBtn.selected = YES;
    }
    NSString *mslmDetails = [_managedObjectNGLS valueForKey:@"mslmDetails"];
    if (mslmDetails.length > 0) {
        _mslmBtn.selected = NO;
        _mslmBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _mslmBtn.enabled = FALSE;
    }
    
    // PBA
    if ([[_managedObjectNGLS valueForKey:@"pba"] isEqual: @"Yes"]) {
        _pbaBtn.selected = YES;
    }
    NSString *pbaDetails = [_managedObjectNGLS valueForKey:@"pbaDetails"];
    if (pbaDetails.length > 0) {
        _pbaBtn.selected = NO;
        _pbaBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _pbaBtn.enabled = FALSE;
    }
    
    // RCF
    if ([[_managedObjectNGLS valueForKey:@"rcf"] isEqual: @"Yes"]) {
        _rcfBtn.selected = YES;
    }
    NSString *rcfDetails = [_managedObjectNGLS valueForKey:@"rcfDetails"];
    if (rcfDetails.length > 0) {
        _rcfBtn.selected = NO;
        _rcfBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _rcfBtn.enabled = FALSE;
    }
    
    // MSP
    if ([[_managedObjectNGLS valueForKey:@"msp"] isEqual: @"Yes"]) {
        _mspBtn.selected = YES;
    }
    NSString *mspDetails = [_managedObjectNGLS valueForKey:@"mspDetails"];
    if (mspDetails.length > 0) {
        _mspBtn.selected = NO;
        _mspBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _mspBtn.enabled = FALSE;
    }
    
    // WP
    if ([[_managedObjectNGLS valueForKey:@"wp"] isEqual: @"Yes"]) {
        _wpBtn.selected = YES;
    }
    NSString *wpDetails = [_managedObjectNGLS valueForKey:@"wpDetails"];
    if (wpDetails.length > 0) {
        _wpBtn.selected = NO;
        _wpBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _wpBtn.enabled = FALSE;
    }
    
    // AAW
    if ([[_managedObjectNGLS valueForKey:@"aaw"] isEqual: @"Yes"]) {
        _aawBtn.selected = YES;
    }
    NSString *aawDetails = [_managedObjectNGLS valueForKey:@"aawDetails"];
    if (aawDetails.length > 0) {
        _aawBtn.selected = NO;
        _aawBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _aawBtn.enabled = FALSE;
    }
    
    // PPI
    if ([[_managedObjectNGLS valueForKey:@"ppi"] isEqual: @"Yes"]) {
        _ppiBtn.selected = YES;
    }
    NSString *ppiDetails = [_managedObjectNGLS valueForKey:@"ppiDetails"];
    if (ppiDetails.length > 0) {
        _ppiBtn.selected = NO;
        _ppiBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _ppiBtn.enabled = FALSE;
    }
    
    // CONV
    if ([[_managedObjectNGLS valueForKey:@"conv"] isEqual: @"Yes"]) {
        _convBtn.selected = YES;
    }
    NSString *convDetails = [_managedObjectNGLS valueForKey:@"convDetails"];
    if (convDetails.length > 0) {
        _convBtn.selected = NO;
        _convBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _convBtn.enabled = FALSE;
    }
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

- (IBAction)indBtnPressed:(UIButton *)sender {
    // If button is not selected
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [_managedObjectNGLS setValue:@"" forKey:@"ind"];
    } else {
        // If button is selected
        [sender setSelected:YES];
        [_managedObjectNGLS setValue:@"Yes" forKey:@"ind"];
    }
    
    UIAlertView *qConfirm = [[UIAlertView alloc]initWithTitle:@"Additional Information"
                                          message:@"Would you like to give additional information by answering some short related questions?"
                                         delegate:self
                                cancelButtonTitle:@"No"
                                otherButtonTitles:@"Proceed", nil];
    qConfirm.tag = 1;
    // If button is selected, show alert
    if (sender.isSelected == YES) {
        [qConfirm show];
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
    // Set textfield.text to empty
    alertTextField.text = nil;
    moreInfo.tag = 2;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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

    alertTextField.text = nil;
    moreInfo.tag = 3;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 4;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 5;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 6;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 7;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 8;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 9;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 10;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 11;

    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 12;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
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
    
    alertTextField.text = nil;
    moreInfo.tag = 13;
    
    if (sender.isSelected == YES) {
        [moreInfo show];
    }
}

- (IBAction)homeBtnPressed:(UIButton *) sender {
    if (self.recTel.text.length > 0) {
        if (self.recTel.text.length != 11) {
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
    // Alter button state depending if additional details are added
    // IND
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            // Set "Yes" for indSurvey
            [_managedObjectNGLS setValue:@"Yes" forKey:@"indSurvey"];
            
            // Allocate & initialise HearingViewController
            HearingViewController *hearing = [[HearingViewController alloc]initWithNibName:@"HearingViewController"
                                                                                    bundle:nil];
            
            // Pass managedObject to view
            hearing.managedObjectNGLS = self.managedObjectNGLS;
            
            // Push next view
            [self.navigationController pushViewController:hearing animated:YES];
        }
    }
    
    // ASB
    if (alertView.tag == 2) {
        NSString *asbDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:asbDetails forKeyPath:@"asbDetails"];
        if (asbDetails.length > 1) {
            [_asbBtn setSelected:NO];
            _asbBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _asbBtn.enabled = FALSE;
        }
    }
    
    // VWF
    if (alertView.tag == 3) {
        NSString *vwfDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:vwfDetails forKeyPath:@"vwfDetails"];
        if (vwfDetails.length > 1) {
            [_vwfBtn setSelected:NO];
            _vwfBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _vwfBtn.enabled = FALSE;
        }
    }
    
    // BP
    if (alertView.tag == 4) {
        NSString *bpDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:bpDetails forKeyPath:@"bpDetails"];
        if (bpDetails.length > 1) {
            [_bpBtn setSelected:NO];
            _bpBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _bpBtn.enabled = FALSE;
        }
    }
    
    // RTA
    if (alertView.tag == 5) {
        NSString *rtaDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:rtaDetails forKeyPath:@"rtaDetails"];
        if (rtaDetails.length > 1) {
            [_rtaBtn setSelected:NO];
            _rtaBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _rtaBtn.enabled = FALSE;
        }
    }
    
    // MSLM
    if (alertView.tag == 6) {
        NSString *mslmDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:mslmDetails forKeyPath:@"mslmDetails"];
        if (mslmDetails.length > 1) {
            [_mslmBtn setSelected:NO];
            _mslmBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _mslmBtn.enabled = FALSE;
        }
    }
    
    // PBA
    if (alertView.tag == 7) {
        NSString *pbaDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:pbaDetails forKeyPath:@"pbaDetails"];
        if (pbaDetails.length > 1) {
            [_pbaBtn setSelected:NO];
            _pbaBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _pbaBtn.enabled = FALSE;
        }
    }
    
    // RCF
    if (alertView.tag == 8) {
        NSString *rcfDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:rcfDetails forKeyPath:@"rcfDetails"];
        if (rcfDetails.length > 1) {
            [_rcfBtn setSelected:NO];
            _rcfBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _rcfBtn.enabled = FALSE;
        }
    }
    
    // MSP
    if (alertView.tag == 9) {
        NSString *mspDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:mspDetails forKeyPath:@"mspDetails"];
        if (mspDetails.length > 1) {
            [_mspBtn setSelected:NO];
            _mspBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _mspBtn.enabled = FALSE;
        }
    }
    
    // AAW
    if (alertView.tag == 10) {
        NSString *aawDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:aawDetails forKeyPath:@"aawDetails"];
        if (aawDetails.length > 1) {
            [_aawBtn setSelected:NO];
            _aawBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _aawBtn.enabled = FALSE;
        }
    }
    
    // PPI
    if (alertView.tag == 11) {
        NSString *ppiDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:ppiDetails forKeyPath:@"ppiDetails"];
        if (ppiDetails.length > 1) {
            [_ppiBtn setSelected:NO];
            _ppiBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _ppiBtn.enabled = FALSE;
        }
    }
    
    // WP
    if (alertView.tag == 12) {
        NSString *wpDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:wpDetails forKeyPath:@"wpDetails"];
        if (wpDetails.length > 1) {
            [_wpBtn setSelected:NO];
            _wpBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _wpBtn.enabled = FALSE;
        }
    }
    
    // CONV
    if (alertView.tag == 13) {
        NSString *convDetails = [alertView textFieldAtIndex:0].text;
        [_managedObjectNGLS setValue:convDetails forKeyPath:@"convDetails"];
        if (convDetails.length > 1) {
            [_convBtn setSelected:NO];
            _convBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
            _convBtn.enabled = FALSE;
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
    
    [_managedObjectNGLS setValue:_otherTextField.text forKey:@"otherServices"];
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
