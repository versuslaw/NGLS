//
//  AdminViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 12/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "AdminViewController.h"
#import "Model.h"
#import "NGLSAppDelegate.h"
#import "CHCSVParser.h"
#import "DisableTextMenu.h"


@interface AdminViewController () <MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate, UIApplicationDelegate>

@end

@implementation AdminViewController

@synthesize namePicker;
@synthesize usernameArray;
@synthesize sortedUsernameArray;

@synthesize sitePicker;
@synthesize siteArray;
@synthesize sortedSiteArray;

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
    // Do any additional setup after loading the view from its nib
    
    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    // Fetch objects from Admin entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Admin" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // Fetch last object
    Model *admin = [fetchedObjects lastObject];
    
    // If userLogin is empty
    if (admin.userLogin == nil) {
        //NSLog(@"Login empty");
    } else {
        // Populate textfields with data
        self.usernameField.text = admin.userLogin;
        self.siteLocationField.text = admin.siteLocation;
    }
    
    // Create new managed object using the Admin entity description
    NSManagedObject *ManagedObjectAdmin;
    ManagedObjectAdmin = [NSEntityDescription insertNewObjectForEntityForName:@"Admin"
                                                       inManagedObjectContext:context];
    self.managedObjectAdmin = ManagedObjectAdmin;

    // Save context
    NSError *saveError = nil;
    [context save:&saveError];
    
    // Alloc & init username picker
    self.namePicker = [[UIPickerView alloc]init];
    [namePicker setDataSource:self];
    [namePicker setDelegate:self];
    self.usernameArray = [[NSArray alloc]initWithObjects:@"Jennifer",
                          @"Sharon",
                          @"Divas",
                          @"John",
                          @"Andrew",
                          @"Blal",
                          @"Shehzad", nil];
    
    // Sort array alphabetically
    self.sortedUsernameArray = [usernameArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    self.usernameField.delegate = self;
    self.usernameField.inputView = namePicker;
    
    // Alloc & init location picker
    self.sitePicker = [[UIPickerView alloc]init];
    [sitePicker setDataSource:self];
    [sitePicker setDelegate:self];
    self.siteArray = [[NSArray alloc]initWithObjects:@"Houndshill Shopping Centre", @"St John's Shopping Centre", @"Spindles Shopping Centre", @"Town Square Shopping Centre", @"The Rock Shopping Centre", @"Port Arcades Shopping Centre", @"Fishergate Shopping Centre", @"Stretford Mall", @"Spinning Gate Shopping Centre", @"Belle Vale Shopping Centre", @"Clarendon Square Shopping Centre", @"Forum Shopping Centre", @"Huyton Place Shopping Centre", @"Dunmail Park Shopping Centre", @"The Mill Outlet Store", @"Merrion Centre", @"Lakeside Village", @"Junction 32 Outlet Shopping Village", @"The Grafton Centre", @"Weaver Square", nil];
    
    // Sort array alphabetically
    self.sortedSiteArray = [siteArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    self.siteLocationField.delegate =self;
    self.siteLocationField.inputView = sitePicker;
    
    // Set navbar title
    self.navigationItem.title = @"Admin Control";
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

#pragma picker components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.namePicker) {
        return [sortedUsernameArray count];
    } else if (pickerView == self.sitePicker) {
        return [sortedSiteArray count];
    } else {
        assert(NO);
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.namePicker) {
        return [sortedUsernameArray objectAtIndex:row];
    } else if (pickerView == self.sitePicker) {
        return [sortedSiteArray objectAtIndex:row];
    } else {
        assert(NO);
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.namePicker) {
        NSString *nameString = [[NSString alloc]initWithFormat:@"%@", [sortedUsernameArray objectAtIndex:row]];
        self.usernameField.text = nameString;
    } else if (pickerView == self.sitePicker) {
        NSString *siteString = [[NSString alloc]initWithFormat:@"%@", [sortedSiteArray objectAtIndex:row]];
        self.siteLocationField.text = siteString;
    }
}

- (IBAction)loginBtnPressed:(UIButton *)sender {
    NSString *user = _usernameField.text;
    NSString *site = _siteLocationField.text;
    
    // If username & location are set
    if ((_usernameField.text.length > 0) && _siteLocationField.text.length > 0) {
        UIAlertView *successful = [[UIAlertView alloc]initWithTitle:@"Login Successful"
                                                       message:@"You have successfully logged in"
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
        [successful show];
        
        // Provide feedback for successful login
        _usernameField.enabled = NO;
        _usernameField.backgroundColor = [UIColor lightGrayColor];
        
        _siteLocationField.enabled = NO;
        _siteLocationField.backgroundColor = [UIColor lightGrayColor];
        
        _loginBtn.backgroundColor = [UIColor colorWithRed:(55/255.0) green:(200/255.0) blue:(0/255.0) alpha:1];
        _loginBtn.enabled = NO;
        [_loginBtn setTitle:@"Logged in" forState:UIControlStateDisabled];
        
        // Save login details
        [_managedObjectAdmin setValue:user forKey:@"userLogin"];
        [_managedObjectAdmin setValue:site forKey:@"siteLocation"];
        
        NSError *error;
        [[self.managedObjectAdmin managedObjectContext] save:&error];
        NSLog(@"%@", self.managedObjectAdmin);
        
    } else {
        UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Error"
                                                       message:@"Please enter a valid username and site location"
                                                      delegate:nil
                                             cancelButtonTitle:@"Dismiss"
                                             otherButtonTitles:nil];
        [error show];
    }
}

- (IBAction)exportBtnPressed:(UIButton *)sender {
    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    // Fetch objects from NGLS entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NGLS"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"%@", [NSString stringWithFormat:@"%lu records found", (unsigned long)[fetchedObjects count]]);
    
    // If entity is empty
    if ([fetchedObjects count] == 0) {
        NSLog(@"No data found");
        UIAlertView *noData = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"No data found"
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [noData show];
    } else {
        // Check for .csv, delete to avoid duplicates
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
            [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:NULL];
            NSLog(@".csv found - deleted to avoid duplicate entries");
        }
        // Call confirmExport method
        [self confirmExport];
        NSLog(@"%@", [NSString stringWithFormat:@"%lu records found", (unsigned long)[fetchedObjects count]]);
    }
}

- (void)confirmExport{
    // Confirm export
    self.loginRequired = [[UIAlertView alloc]initWithTitle:@"Password Required"
                                                   message:@"Please enter the export password"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Proceed", nil];
    self.loginRequired.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [self.loginRequired textFieldAtIndex:0].delegate = self;
    [self.loginRequired show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Dismiss keyboard when 'done' is pressed
    [self.loginRequired dismissWithClickedButtonIndex:self.loginRequired.firstOtherButtonIndex animated:YES];
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Proceed"]) {
        UITextField *password = [alertView textFieldAtIndex:0];
        
        // Check admin password
        if ([password.text isEqualToString:@"admin"]) {
            NSLog(@"Password correct");
            
            // Identify the app delegate
            NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            NSError *error;
            
            // Fetch objects from NGLS entity
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"NGLS"
                                                      inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            
            // Confirm export & display number of records
            UIAlertView *exportConfirm = [[UIAlertView alloc]initWithTitle:@"Export"
                                                            message:[NSString stringWithFormat:@"%lu Records found. Do you want to export these results?", (unsigned long)[fetchedObjects count]]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Export", nil];
            [exportConfirm show];
        } else {
            UIAlertView *wrongPass = [[UIAlertView alloc]initWithTitle:@"Error"
                                                               message:@"Wrong password. Please try again or contact your administrator"
                                                              delegate:nil
                                                     cancelButtonTitle:@"Dismiss"
                                                     otherButtonTitles:nil];
            [wrongPass show];
        }
    }
    // If user pressed "Export" button
    if ([title isEqualToString:@"Export"]) {
        NSLog(@"Start export");
        [self exportProcess];
    }
}

-(NSString *)dataFilePath {
    // Build path to .csv file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"NGLS_export.csv"];
}

- (void) exportProcess {
    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    // Fetch objects from NGLS entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NGLS"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // CHCSVParser
    NSOutputStream *stream = [[NSOutputStream alloc]initToMemory];
    CHCSVWriter *writer = [[CHCSVWriter alloc]initWithOutputStream:stream
                                                          encoding:NSUTF8StringEncoding
                                                         delimiter:','];
    
    // Write fetched objects to .csv
    for (Model *results in fetchedObjects) {
        [writer writeLineOfFields:@[results.site,
                                    results.username,
                                    results.dateStamp,
                                    
                                    results.clientTitle,
                                    results.clientForename,
                                    results.clientSurname,
                                    results.dateOfBirth,
                                    results.addLine1,
                                    results.addLine2,
                                    results.addLine3,
                                    results.addLine4,
                                    results.addLine5,
                                    results.clientPost,
                                    results.clientTelLand,
                                    results.clientTelMob,
                                    results.clientEmail,
                                    results.clientNI,
                                    results.contactHours,
                                    
                                    results.q1,
                                    results.q1More,
                                    results.q2,
                                    results.q2More,
                                    results.q3,
                                    results.q3More,
                                    results.q4,
                                    results.q4More,
                                    
                                    results.emp1Name, results.emp1From, results.emp1To, results.emp1Noise, results.emp1Exposure,
                                    results.emp2Name, results.emp2From, results.emp2To, results.emp2Noise, results.emp2Exposure,
                                    results.emp3Name, results.emp3From, results.emp3To, results.emp3Noise, results.emp3Exposure,
                                    results.emp4Name, results.emp4From, results.emp4To, results.emp4Noise, results.emp4Exposure,
                                    results.emp5Name, results.emp5From, results.emp5To, results.emp5Noise, results.emp5Exposure,
                                    results.emp6Name, results.emp6From, results.emp6To, results.emp6Noise, results.emp6Exposure,
                                    results.emp7Name, results.emp7From, results.emp7To, results.emp7Noise, results.emp7Exposure,
                                    results.emp8Name, results.emp8From, results.emp8To, results.emp8Noise, results.emp8Exposure,
                                    results.emp9Name, results.emp9From, results.emp9To, results.emp9Noise, results.emp9Exposure,
                                    results.emp10Name, results.emp10From, results.emp10To, results.emp10Noise, results.emp10Exposure,

                                    results.ind,
                                    results.asb,
                                    results.asbDetails,
                                    results.vwf,
                                    results.vwfDetails,
                                    results.bp,
                                    results.bpDetails,
                                    results.rta,
                                    results.rtaDetails,
                                    results.mslm,
                                    results.mslmDetails,
                                    results.pba,
                                    results.pbaDetails,
                                    results.rcf,
                                    results.rcfDetails,
                                    results.msp,
                                    results.mspDetails,
                                    results.aaw,
                                    results.aawDetails,
                                    results.ppi,
                                    results.ppiDetails,
                                    results.wp,
                                    results.wpDetails,
                                    results.conv,
                                    results.convDetails,
                                    results.otherServices,
                                    results.recName,
                                    results.recTel]];
    }
    [writer closeStream];
    
    NSData *buffer = [stream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    NSString *output = [[NSString alloc]initWithData:buffer
                                            encoding:NSUTF8StringEncoding];
    
    // If file doesn't exist, create one
    if (![[NSFileManager defaultManager]fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager]createFileAtPath:[self dataFilePath]
                                               contents:nil
                                             attributes:nil];
        NSLog(@"File created");
    }
    
    // Write to file
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePath]];
    [handle seekToEndOfFile];
    [handle writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
    

    /**
     
     // SECTION BELOW IS FOR DEBUG PURPOSES ONLY
     // Opens UIDocumentInteractionController to preview contents of .csv
     
     NSURL *fileURL = [NSURL fileURLWithPath:[self dataFilePath] isDirectory:NO];
     UIDocumentInteractionController *docController = [[UIDocumentInteractionController alloc]init];
     docController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
     docController.delegate = self;
     [docController presentPreviewAnimated:YES];
     NSLog(@"Debug - preview .csv file");
     
     **/
    
    // If device can send mail
    if ([MFMailComposeViewController canSendMail]) {
        // Set mail components
        NSArray *recipient = [NSArray arrayWithObject:@"proadmin@medicalgeneration.co.uk"];
        NSArray *ccRecipient = [NSArray arrayWithObjects:@"info@ngls.co.uk", @"bc@ngls.co.uk", @"as@ngls.co.uk", @"sc@ngls.co.uk",nil];
        // Set date format
        NSDate *sysDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dateStamp = [formatter stringFromDate:sysDate];
        NSString *emailBody = [NSString stringWithFormat:@"Attachment: NGLS Survey Results - Exported on %@", dateStamp];
        // Set components
        [appDelegate.globalMailComposer setToRecipients:recipient];
        [appDelegate.globalMailComposer setCcRecipients:ccRecipient];
        [appDelegate.globalMailComposer setSubject:@"NGLS Survey Results"];
        [appDelegate.globalMailComposer setMessageBody:emailBody isHTML:NO];
        appDelegate.globalMailComposer.mailComposeDelegate = self;
        // Attach file
        [appDelegate.globalMailComposer addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePath]]
                         mimeType:@"text/csv"
                         fileName:@"NGLS_export.csv"];
        // Open mail composer
        [self presentViewController:appDelegate.globalMailComposer
                                       animated:YES
                                     completion:nil];

    } else {
        UIAlertView *noMail = [[UIAlertView alloc]initWithTitle:@"Unable to send email"
                                                        message:@"This device cannot send email"
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [noMail show];
        // Cycle the mailComposer
        [appDelegate cycleTheGlobalMailComposer];
    }
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller
{
    return [self navigationController];
}

// Check mail outcome, delete .csv to avoide duplicate entries
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:NULL];
                NSLog(@".csv deleted");
            }
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:NULL];
                NSLog(@".csv deleted");
            }
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:NULL];
                NSLog(@".csv deleted");
                // If mail sent successfully, delete context (wipe database)
                [self resetData];
                
                // Empty login fields
                self.usernameField.text = nil;
                self.siteLocationField.text = nil;
            }
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:NULL];
                NSLog(@".csv deleted");
            }
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Dismiss mail view
    [self dismissViewControllerAnimated:YES completion:^{
        NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
        [appDelegate cycleTheGlobalMailComposer];
        //NSLog(@"mail dismissed");
    }];
}

- (void)resetData {
    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    // Fetch objects from NGLS entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NGLS"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // Delete objects
    for (Model *results in fetchedObjects) {
        [context deleteObject:(id)results];
        NSLog(@"NGLS objects deleted");
    };
    
    // Fetch objects from Admin entity
    NSFetchRequest *adminFetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *adminEntity = [NSEntityDescription entityForName:@"Admin"
                                                   inManagedObjectContext:context];
    [adminFetchRequest setEntity:adminEntity];
    NSArray *adminFetchedObjects = [context executeFetchRequest:adminFetchRequest error:&error];
    
    // Delete objects
    for (Model *adminResults in adminFetchedObjects) {
        [context deleteObject:(id)adminResults];
        NSLog(@"Admin objects deleted");
    }
    
    // Create new managed object using the Admin entity description
    NSManagedObject *ManagedObjectAdmin;
    ManagedObjectAdmin = [NSEntityDescription insertNewObjectForEntityForName:@"Admin"
                                                       inManagedObjectContext:context];
    self.managedObjectAdmin = ManagedObjectAdmin;
    
    // Save context
    NSError *saveError = nil;
    [context save:&saveError];
    
    UIAlertView *successfulExport = [[UIAlertView alloc]initWithTitle:@"Successful Export"
                                                              message:@"The .csv file was successfully exported via email. Please monitor Proclaim for newly imported cases. Note: Import can take between 30 - 90+ minutes."
                                                             delegate:nil
                                                    cancelButtonTitle:@"Dismiss"
                                                    otherButtonTitles:nil];
    [successfulExport show];
}

@end
