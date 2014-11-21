//
//  Model.m
//  NGLS
//
//  Created by Ross Humphreys on 10/09/2014.
//  Copyright (c) 2014 Next Generation Legal Services. All rights reserved.
//

#import "Model.h"
#import "NGLSAppDelegate.h"
#import "ClientViewController.h"
#import "CHCSVParser.h"
#import "AdminViewController.h"

@implementation Model

// Admin Entity
@dynamic userLogin;
@dynamic siteLocation;
@dynamic dateStamp;

// NGLS Entity
@dynamic username;
@dynamic site;

@dynamic addLine1;
@dynamic addLine2;
@dynamic addLine3;
@dynamic addLine4;
@dynamic addLine5;
@dynamic clientEmail;
@dynamic clientForename;
@dynamic clientSurname;
@dynamic clientNI;
@dynamic clientPost;
@dynamic clientTelLand;
@dynamic clientTelMob;
@dynamic clientTitle;
@dynamic contactHours;
@dynamic dateOfBirth;

@dynamic emp1Exposure;
@dynamic emp1From;
@dynamic emp1Name;
@dynamic emp1Noise;
@dynamic emp1To;

@dynamic emp2Exposure;
@dynamic emp2From;
@dynamic emp2Name;
@dynamic emp2Noise;
@dynamic emp2To;

@dynamic emp3Exposure;
@dynamic emp3From;
@dynamic emp3Name;
@dynamic emp3Noise;
@dynamic emp3To;

@dynamic emp4Exposure;
@dynamic emp4From;
@dynamic emp4Name;
@dynamic emp4Noise;
@dynamic emp4To;

@dynamic emp5Exposure;
@dynamic emp5From;
@dynamic emp5Name;
@dynamic emp5Noise;
@dynamic emp5To;

@dynamic emp6Exposure;
@dynamic emp6From;
@dynamic emp6Name;
@dynamic emp6Noise;
@dynamic emp6To;

@dynamic emp7Exposure;
@dynamic emp7From;
@dynamic emp7Name;
@dynamic emp7Noise;
@dynamic emp7To;

@dynamic emp8Exposure;
@dynamic emp8From;
@dynamic emp8Name;
@dynamic emp8Noise;
@dynamic emp8To;

@dynamic emp9Exposure;
@dynamic emp9From;
@dynamic emp9Name;
@dynamic emp9Noise;
@dynamic emp9To;

@dynamic emp10Exposure;
@dynamic emp10From;
@dynamic emp10Name;
@dynamic emp10Noise;
@dynamic emp10To;

@dynamic ind;
@dynamic indSurvey;
@dynamic indQ1;
@dynamic indQ1More;
@dynamic indQ2;
@dynamic indQ2More;
@dynamic indQ3;
@dynamic indQ3More;
@dynamic indQ4;
@dynamic indQ4More;

@dynamic aaw;
@dynamic aawDetails;

@dynamic asb;
@dynamic asbDetails;

@dynamic bp;
@dynamic bpDetails;

@dynamic conv;
@dynamic convDetails;

@dynamic mslm;
@dynamic mslmDetails;

@dynamic msp;
@dynamic mspDetails;

@dynamic pba;
@dynamic pbaDetails;

@dynamic ppi;
@dynamic ppiDetails;

@dynamic rcf;
@dynamic rcfDetails;

@dynamic recName;
@dynamic recTel;

@dynamic rta;
@dynamic rtaDetails;

@dynamic vwf;
@dynamic vwfDetails;

@dynamic wp;
@dynamic wpDetails;

@dynamic otherServices;

- (void)blankData {
    // Set blank value ("") if keys are nil
    
    // Services
    NSArray *services = @[@"ind", @"asb", @"vwf", @"bp", @"rta", @"mslm", @"pba", @"rcf", @"msp", @"aaw", @"ppi", @"wp", @"conv", @"otherServices"];
    for (NSString *serviceKey in services) {
        if ([_managedObjectNGLS valueForKey:serviceKey] == nil) {
            [_managedObjectNGLS setValue:@"" forKey:serviceKey];
        }
    }
    
    // Employers
    NSArray *employers = @[@"emp1Name", @"emp1From", @"emp1To", @"emp1Exposure", @"emp1Noise",
                           @"emp2Name", @"emp2From", @"emp2To", @"emp2Exposure", @"emp2Noise",
                           @"emp3Name", @"emp3From", @"emp3To", @"emp3Exposure", @"emp3Noise",
                           @"emp4Name", @"emp4From", @"emp4To", @"emp4Exposure", @"emp4Noise",
                           @"emp5Name", @"emp5From", @"emp5To", @"emp5Exposure", @"emp5Noise",
                           @"emp6Name", @"emp6From", @"emp6To", @"emp6Exposure", @"emp6Noise",
                           @"emp7Name", @"emp7From", @"emp7To", @"emp7Exposure", @"emp7Noise",
                           @"emp8Name", @"emp8From", @"emp8To", @"emp8Exposure", @"emp8Noise",
                           @"emp9Name", @"emp9From", @"emp9To", @"emp9Exposure", @"emp9Noise",
                           @"emp10Name", @"emp10From", @"emp10To", @"emp10Exposure", @"emp10Noise"];
    for (NSString *empKey in employers) {
        if ([_managedObjectNGLS valueForKey:empKey] == nil) {
            [_managedObjectNGLS setValue:@"" forKey:empKey];
        }
    }
    
    // IND Questions
    NSArray *indQuestions = @[@"indSurvey", @"indQ1", @"indQ1More", @"indQ2", @"indQ2More", @"indQ3", @"indQ3More", @"indQ4", @"indQ4More"];
    for (NSString *indKey in indQuestions) {
        if ([_managedObjectNGLS valueForKey:indKey] == nil) {
            [_managedObjectNGLS setValue:@"" forKey:indKey];
        }
    }
    
    // Services - Additional Details
    NSArray *addDetails = @[@"asbDetails", @"vwfDetails", @"bpDetails", @"rtaDetails", @"mslmDetails", @"pbaDetails", @"rcfDetails", @"mspDetails", @"aawDetails", @"ppiDetails", @"wpDetails", @"convDetails"];
    for (NSString *detailsKey in addDetails) {
        if ([_managedObjectNGLS valueForKey:detailsKey] == nil) {
            [_managedObjectNGLS setValue:@"" forKeyPath:detailsKey];
        }
    }
}

@end
