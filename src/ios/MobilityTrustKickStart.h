//
//  MobilityTrustKickStartProtocall.h
//  IOSMobileTrust
//
//  Created by nilesh kamble on 19/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MobilityTrustKickStart <NSObject>
@required
-(NSString *)initialize :(NSString *) licensekey usingWith: (NSString*) userid usingWith: (NSString*) regcode usingWith:(NSString * )pin;
-(int)confirm:(NSString *) licensekey usingWith: (NSString*) userid usingWith: (NSString *) pin usingWith: (NSString *) toconfirm;
-(int)SilentIntialize:(NSString *) licensekey usingWith: (NSString*) userid usingWih:(NSString *) filename usingWith: (NSString *) regcode usingWith: (NSString * )pin usingWith:(NSDictionary *) uDetails;
-(void)LoadDelegates;
-(BOOL)enableORDisableDebug:(BOOL)bCheck;
-(int)CheckStatus:(NSString *) userid;
-(int)Update:(NSString *)userid usingWith:(NSString *)strPayload usingWith:(NSString *) pin;
-(NSString *)getLogs;
-(int)selfDestroy:(NSString *) userid usingWith: (NSString *)pin;

@end
