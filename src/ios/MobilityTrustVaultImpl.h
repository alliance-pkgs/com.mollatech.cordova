//
//  MobilityTrustVaultImpl.h
//  IOSMobileTrust
//
//  Created by nilesh kamble on 19/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxiomOTPResponse.h"
#import "AxiomPKIResponse.h"
#import "AxiomLocation.h"
#import "MobilityTrustVault.h"
@interface MobilityTrustVaultImpl : NSObject <MobilityTrustVault>

-(int) load:(NSString *) licensekey usingWith: (NSString *) userid usingWith: (NSString *)pin;
-(int) unLoad:(NSString *) userid;
-(AxiomOTPResponse *) GetOTPPlus:(NSString *) tStamp;
-(AxiomOTPResponse *) GetSOTPPlus:(NSString *)tStamp usingWith:(NSArray *) data;
-(AxiomOTPResponse *)ShowOTP;
-(AxiomOTPResponse *)ShowSOTP:(NSArray *)data;
-(AxiomPKIResponse *)GetSignPlus:(NSString *)data usingWith:(NSString *) tStamp;
-(AxiomPKIResponse *)GetSignFilePlus:(NSString *)filename usingWith:(NSString *) tStamp;
-(void)LoadDelegates;
-(NSString *)EnforceSecurity:(NSString *) plainData;
-(NSString *)ConsumeSecurity:(NSString *) encryptedData;
-(BOOL)enableORDisableDebug:(BOOL)bCheck;
-(NSString *)checkVersion;
-(void)SetGPSCoordinates:(NSString *)longitude usingWith:(NSString *)longitude;
-(AxiomLocation *)GetGPSCoordinates;
-(NSString *)getGeoLocation;
-(NSString *)getLocationByCoordinate:(NSString *) lattitude usingWith:(NSString *) longitude;
-(NSString *)getLocationByIPAddress:(NSString *) ipAddress;
-(NSString *)getIPAddress;
-(int)setSecureAttribute:(NSString *)key usingWith:(NSData *)data;
-(NSData *) getSecureAttribute:(NSString *) key;
-(int)removeSecureAttribute:(NSString *) key;
-(int)removeAllSecureAttribute;
-(NSArray *) getAllKeys;
-(NSString *) ResetPin:(NSString *) licensekey usingWith:(NSString *) userid usingWith:(NSString *)doctype  usingWith:(NSString *) uniqueId usingWith:(NSString *)newpin usingWith:(NSString *) tStamp;
-(NSString *) ChangePin:(NSString*) pin usingWith:(NSString *) newpin  usingWith:(NSString *) tStamp;
-(BOOL) ConfirmResetOrChangePin:(NSString *) toconfirm;
-(NSString  *) getDeviceDetails;
-(NSString *)unlockToken:(NSString *) licensekey usingWith:(NSString*) userid usingWith:(NSString*) pukCode usingWith:(NSString*) pin;




@end
