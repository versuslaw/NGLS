//
//  NGLSViewController.m
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "NGLSViewController.h"
#import "ClientViewController.h"
#import "AdminViewController.h"
#import "NGLSAppDelegate.h"

@interface NGLSViewController ()

@end

@implementation NGLSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set navbar title
    self.navigationItem.title = @"Welcome";
    
    // Create "Admin" navbar button
    UIBarButtonItem *adminBtn = [[UIBarButtonItem alloc]initWithTitle:@"Admin Login"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(adminBtnPressed:)];
    self.navigationItem.rightBarButtonItem = adminBtn;
    adminBtn.enabled = TRUE;
    
    // Set custom text for back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Home"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:nil];
    
    // Identify the app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    // Use appDelegate object to identify managed object context
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // Create fetch request to fetch NGLS data from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NGLS"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // Delete objects
    for (Model *results in fetchedObjects) {
        [context deleteObject:(id)results];
        //NSLog(@"NGLS object deleted: %@", results.username);
    }
    
    // Create fetch request to fetch Admin data from the store
    NSFetchRequest *adminFetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *adminEntity = [NSEntityDescription entityForName:@"Admin"
                                                   inManagedObjectContext:context];
    [adminFetchRequest setEntity:adminEntity];
    
    NSArray *adminFetchedObjects = [context executeFetchRequest:adminFetchRequest error:&error];
    
    // Delete objects
    for (Model *adminResults in adminFetchedObjects) {
        [context deleteObject:(id)adminResults];
        NSLog(@"Admin object deleted: %@", adminResults.userLogin);
    }
    
    // Save context
    NSError *saveError = nil;
    [context save:&saveError];
    
    // Create new managed object using the Admin entity description
    NSManagedObject *ManagedObjectAdmin;
    ManagedObjectAdmin = [NSEntityDescription insertNewObjectForEntityForName:@"Admin"
                                                       inManagedObjectContext:context];
    // Declare managed object
    self.managedObjectAdmin = ManagedObjectAdmin;
    
    // Start animations
    //[self startAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimations {
    [_startBtn setAlpha:0.0];
    [_disclaimerTxt setAlpha:0.0];
    [_nglsLogo setAlpha:0.0];
    
    [UIView animateWithDuration:1
                          delay:0.25
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [_startBtn setAlpha:1];
                     }completion:nil];
    
    [UIView animateWithDuration:1
                          delay:0.25
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [_disclaimerTxt setAlpha:1];
                     }completion:nil];
    
    [UIView animateWithDuration:1
                          delay:0.25
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [_nglsLogo setAlpha:1];
                     }completion:nil];
}

- (IBAction)startButton:(UIButton *)sender {
    // Identify app delegate
    NGLSAppDelegate *appDelegate = (NGLSAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    // Use appDelegate to identify managed object context
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Admin" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    Model *admin = [fetchedObjects lastObject];
    
    // If no username found, display message
    if (admin.userLogin == nil) {
        NSLog(@"No username");
                UIAlertView *noLogin = [[UIAlertView alloc]initWithTitle:@"Error"
                                                         message:@"Please login with your username on the Admin screen"
                                                        delegate:nil
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil];
                                [noLogin show];
    } else {
        // Allocate & initialise ClientViewController
        ClientViewController *client = [[ClientViewController alloc]initWithNibName:@"ClientViewController"
                                                                             bundle:nil];
        
        // Pass managed object to view
        client.managedObjectNGLS = self.managedObjectNGLS;
        client.managedObjectAdmin = self.managedObjectAdmin;
        
        // Push ClientViewController
        [self.navigationController pushViewController:client
                                             animated:YES];
    }
}

- (IBAction)adminBtnPressed:(UIButton *)sender {
    self.loginRequired = [[UIAlertView alloc]initWithTitle:@"Login Required"
                                                   message:@"Please enter the admin password"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Login", nil];
    self.loginRequired.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [self.loginRequired textFieldAtIndex:0].delegate = self;
    [self.loginRequired show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // When return key is pressed, dismiss keyboard and trigger "Login" button
    [self.loginRequired dismissWithClickedButtonIndex:self.loginRequired.firstOtherButtonIndex animated:YES];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Login"]) {
        UITextField *password = [alertView textFieldAtIndex:0];
        
        // Basic login authentication
        if ([password.text isEqualToString:@"admin"]) {
            //NSLog(@"Password correct");
            
            // Allocate & initialise AdminViewController
            AdminViewController *admin = [[AdminViewController alloc]initWithNibName:@"AdminViewController"
                                                                              bundle:nil];
            
            // Pass managedOvject to view
            admin.managedObjectNGLS = self.managedObjectNGLS;
            admin.managedObjectAdmin = self.managedObjectAdmin;
            
            // Push next view
            [self.navigationController pushViewController:admin animated:YES];
            
        } else {
            NSLog(@"Incorrect password attempt: %@", password.text);
            UIAlertView *errorMsg = [[UIAlertView alloc]initWithTitle:@"Error"
                                                              message:@"Wrong password. Please try again or contact your administrator"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Dismiss"
                                                    otherButtonTitles:nil];
            [errorMsg show];
        }
    }
}

@end
