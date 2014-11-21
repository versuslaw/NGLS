//
//  Model.h
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Model : NSObject 

@property (strong, nonatomic) NSManagedObject *managedObjectNGLS;

// Admin Entity
@property (nonatomic, retain) NSString *userLogin; 
@property (nonatomic, retain) NSString *siteLocation;
@property (nonatomic, retain) NSString *dateStamp;

// NGLS Entity
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *site;

@property (nonatomic, retain) NSString *addLine1;
@property (nonatomic, retain) NSString *addLine2;
@property (nonatomic, retain) NSString *addLine3;
@property (nonatomic, retain) NSString *addLine4;
@property (nonatomic, retain) NSString *addLine5;
@property (nonatomic, retain) NSString *clientEmail;
@property (nonatomic, retain) NSString *clientForename;
@property (nonatomic, retain) NSString *clientSurname;
@property (nonatomic, retain) NSString *clientNI;
@property (nonatomic, retain) NSString *clientPost;
@property (nonatomic, retain) NSString *clientTelLand;
@property (nonatomic, retain) NSString *clientTelMob;
@property (nonatomic, retain) NSString *clientTitle;
@property (nonatomic, retain) NSString *contactHours;
@property (nonatomic, retain) NSString *dateOfBirth;

@property (nonatomic, retain) NSString *emp1Name;
@property (nonatomic, retain) NSString *emp1From;
@property (nonatomic, retain) NSString *emp1To;
@property (nonatomic, retain) NSString *emp1Noise;
@property (nonatomic, retain) NSString *emp1Exposure;

@property (nonatomic, retain) NSString *emp2Name;
@property (nonatomic, retain) NSString *emp2From;
@property (nonatomic, retain) NSString *emp2To;
@property (nonatomic, retain) NSString *emp2Noise;
@property (nonatomic, retain) NSString *emp2Exposure;

@property (nonatomic, retain) NSString *emp3Name;
@property (nonatomic, retain) NSString *emp3From;
@property (nonatomic, retain) NSString *emp3To;
@property (nonatomic, retain) NSString *emp3Noise;
@property (nonatomic, retain) NSString *emp3Exposure;

@property (nonatomic, retain) NSString *emp4Name;
@property (nonatomic, retain) NSString *emp4From;
@property (nonatomic, retain) NSString *emp4To;
@property (nonatomic, retain) NSString *emp4Noise;
@property (nonatomic, retain) NSString *emp4Exposure;

@property (nonatomic, retain) NSString *emp5Name;
@property (nonatomic, retain) NSString *emp5From;
@property (nonatomic, retain) NSString *emp5To;
@property (nonatomic, retain) NSString *emp5Noise;
@property (nonatomic, retain) NSString *emp5Exposure;

@property (nonatomic, retain) NSString *emp6Name;
@property (nonatomic, retain) NSString *emp6From;
@property (nonatomic, retain) NSString *emp6To;
@property (nonatomic, retain) NSString *emp6Noise;
@property (nonatomic, retain) NSString *emp6Exposure;

@property (nonatomic, retain) NSString *emp7Name;
@property (nonatomic, retain) NSString *emp7From;
@property (nonatomic, retain) NSString *emp7To;
@property (nonatomic, retain) NSString *emp7Noise;
@property (nonatomic, retain) NSString *emp7Exposure;

@property (nonatomic, retain) NSString *emp8Name;
@property (nonatomic, retain) NSString *emp8From;
@property (nonatomic, retain) NSString *emp8To;
@property (nonatomic, retain) NSString *emp8Noise;
@property (nonatomic, retain) NSString *emp8Exposure;

@property (nonatomic, retain) NSString *emp9Name;
@property (nonatomic, retain) NSString *emp9From;
@property (nonatomic, retain) NSString *emp9To;
@property (nonatomic, retain) NSString *emp9Noise;
@property (nonatomic, retain) NSString *emp9Exposure;

@property (nonatomic, retain) NSString *emp10Name;
@property (nonatomic, retain) NSString *emp10From;
@property (nonatomic, retain) NSString *emp10To;
@property (nonatomic, retain) NSString *emp10Noise;
@property (nonatomic, retain) NSString *emp10Exposure;

@property (nonatomic, retain) NSString *ind;
@property (nonatomic, retain) NSString *indSurvey;
@property (nonatomic, retain) NSString *indQ1;
@property (nonatomic, retain) NSString *indQ1More;
@property (nonatomic, retain) NSString *indQ2;
@property (nonatomic, retain) NSString *indQ2More;
@property (nonatomic, retain) NSString *indQ3;
@property (nonatomic, retain) NSString *indQ3More;
@property (nonatomic, retain) NSString *indQ4;
@property (nonatomic, retain) NSString *indQ4More;

@property (nonatomic, retain) NSString *asb;
@property (nonatomic, retain) NSString *asbDetails;

@property (nonatomic, retain) NSString *bp;
@property (nonatomic, retain) NSString *bpDetails;

@property (nonatomic, retain) NSString *conv;
@property (nonatomic, retain) NSString *convDetails;

@property (nonatomic, retain) NSString *aaw;
@property (nonatomic, retain) NSString *aawDetails;

@property (nonatomic, retain) NSString *mslm;
@property (nonatomic, retain) NSString *mslmDetails;

@property (nonatomic, retain) NSString *msp;
@property (nonatomic, retain) NSString *mspDetails;

@property (nonatomic, retain) NSString *pba;
@property (nonatomic, retain) NSString *pbaDetails;

@property (nonatomic, retain) NSString *ppi;
@property (nonatomic, retain) NSString *ppiDetails;

@property (nonatomic, retain) NSString *rcf;
@property (nonatomic, retain) NSString *rcfDetails;

@property (nonatomic, retain) NSString *rta;
@property (nonatomic, retain) NSString *rtaDetails;

@property (nonatomic, retain) NSString *vwf;
@property (nonatomic, retain) NSString *vwfSurvey;

@property (nonatomic, retain) NSString *wp;
@property (nonatomic, retain) NSString *wpDetails;

@property (nonatomic, retain) NSString *recName;
@property (nonatomic, retain) NSString *recTel;

@property (nonatomic, retain) NSString *otherServices;

- (void)blankData;

@end
