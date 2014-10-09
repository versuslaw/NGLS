//
//  NGLSViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NGLSViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;
@property (retain, strong) UIAlertView *loginRequired;

@end
