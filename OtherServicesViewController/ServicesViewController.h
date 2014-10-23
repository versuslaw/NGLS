//
//  ServicesViewController.h
//  NGLS
//
//  Created by Ross Humphreys on 11/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ServicesViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;
@property (nonatomic, strong) NSManagedObject *managedObjectAdmin;

@property (weak, nonatomic) IBOutlet UIButton *indBtn;
@property (weak, nonatomic) IBOutlet UIButton *asbBtn;
@property (weak, nonatomic) IBOutlet UIButton *vwfBtn;
@property (weak, nonatomic) IBOutlet UIButton *bpBtn;
@property (weak, nonatomic) IBOutlet UIButton *rtaBtn;
@property (weak, nonatomic) IBOutlet UIButton *mslmBtn;
@property (weak, nonatomic) IBOutlet UIButton *pbaBtn;
@property (weak, nonatomic) IBOutlet UIButton *rcfBtn;
@property (weak, nonatomic) IBOutlet UIButton *mspBtn;
@property (weak, nonatomic) IBOutlet UIButton *wpBtn;
@property (weak, nonatomic) IBOutlet UIButton *aawBtn;
@property (weak, nonatomic) IBOutlet UIButton *ppiBtn;
@property (weak, nonatomic) IBOutlet UIButton *convBtn;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;

@property (weak, nonatomic) IBOutlet UITextField *recName;
@property (weak, nonatomic) IBOutlet UITextField *recTel;

@property (strong) UIAlertView *moreInfo;
@property (strong) UITextField *alertTextField;

@end
