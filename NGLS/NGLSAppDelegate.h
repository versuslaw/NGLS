//
//  NGLSAppDelegate.h
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface NGLSAppDelegate : UIResponder <UIApplicationDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *) applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, strong) MFMailComposeViewController *globalMailComposer;

- (void)cycleTheGlobalMailComposer;

@end
