//
//  AxiomMobileTrust.m
//  MobileToken
//
//  Created by vikram sareen on 19/02/16.
//
//

#import "AxiomMobileTrust.h"
#import "MobilityTrustKickStartImpl.h"
#import "MobilityTrustVaultImpl.h"
#import "AxiomException.h"
#import "AxiomOTPResponse.h"
#import "AxiomPKIResponse.h"
#import "MobilityTrustKickStart.h"
#import "MobilityTrustVault.h"
#import "Axiom.h"


static NSString *g_push_message;
static MobilityTrustVaultImpl *mv;


@implementation AxiomMobileTrust{
    
    AxiomMobileTrust *sayHello;
    Axiom *axiom;
    NSString *userid;
    NSString *urlToActivate;
    NSString *pin;
    NSString *regcode;
    NSString *lattitude;
    NSString *longitude;
    NSString *licensekey;
    NSDictionary *jsonObj;
    CDVPluginResult *pluginResult;
    MobilityTrustKickStart *m ;
    MobilityTrustVaultImpl *mv;

    
    NSString *initialize;
    NSString *checkstatus;
    NSString *confirm;
    NSString *load ;
    NSString *update ;
    NSString *unLoad;
    NSString *ResetPin;
    NSString *ChangePin ;
    NSString *ConfirmResetOrChangePin ;
    NSString *enableORDisableDebug ;
    NSString *SelfDestroy ;
    NSString *getLogs ;
    NSString *GetOTPPlus;
    NSString *GetSOTPPlus;
    NSString *UnlockToken;
}

-(id)init{
    
    self = [super init];
    if(self)
    {
       self->initialize = @"initialize";
        self->checkstatus = @"checkstatus";
        self->confirm = @"confirm";
        self->load = @"load";
        self->update=@"update";
        self->unLoad=@"unLoad";
        self->ResetPin = @"ResetPin";
        self->ChangePin = @"ChangePin";
        self->ConfirmResetOrChangePin = @"ConfirmResetOrChangePin";
        self->enableORDisableDebug = @"enableORDisableDebug";
        self->SelfDestroy = @"SelfDestroy";
        self->getLogs = @"getLogs";
        self->GetOTPPlus = @"GetOTPPlus";
         self->GetSOTPPlus = @"GetSOTPPlus";
        self->UnlockToken = @"UnlockToken";
        
    }
    return self;
}

// initialize
-(void)initialize:(CDVInvokedUrlCommand*)command {
    regcode=[command.arguments objectAtIndex:0];
    userid=[command.arguments objectAtIndex:1];
    pin=[command.arguments objectAtIndex:2];
    licensekey=[command.arguments objectAtIndex:3];
     m = [[MobilityTrustKickStart alloc]init];
     mv=[[MobilityTrustVaultImpl alloc]init];
    [m LoadDelegates];
    [mv SetGPSCoordinates:@"101.6869" usingWith:@"3.1390"];
    axiom=[[Axiom alloc]init];
    NSLog(@"regcode   %@",regcode);
    NSLog(@" userid  %@",userid);
    NSLog(@" pin  %@",pin);
    NSLog(@" licensekey  %@",licensekey);
    
    NSLog(@" longitude  %@",longitude);
    
    NSLog(@" lattitude  %@",lattitude);
    @try {
               NSString *strInitData =[m initialize:licensekey usingWith: userid usingWith: regcode usingWith:pin];
               jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 strInitData,@"initData",
                 @"true",@"success",
                licensekey,@"licensekey",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
        }
    @catch(NSException *exception){
        NSLog(@"%@",exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}


// load
-(void) load:(CDVInvokedUrlCommand*)command {
    userid=[command.arguments objectAtIndex:0];
    pin=[command.arguments objectAtIndex:1];
    licensekey=[command.arguments objectAtIndex:2];
    
    NSLog(@"load start userid %@", userid);
    NSLog(@"load start pin %@", pin);
    NSLog(@"load start licensekey %@", licensekey);
    [m LoadDelegates];
    [mv LoadDelegates];
    @try{
        mv = [[MobilityTrustVaultImpl alloc]init];
        m = [[MobilityTrustKickStart alloc]init];
        [mv SetGPSCoordinates:@"101.6869" usingWith:@"3.1390"];
        axiom=[[Axiom alloc]init];
        int res = [mv load:licensekey usingWith:userid usingWith: pin];
        NSNumber *ress=@(res);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

// unLoad
- (void) unLoad:(CDVInvokedUrlCommand*)command {
    userid=[command.arguments objectAtIndex:0];
    @try{
       int res=[mv unLoad: userid];
        NSNumber *ress=@(res);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];

    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

// confirm
- (void) confirm:(CDVInvokedUrlCommand*)command {
    licensekey=[command.arguments objectAtIndex:0];
    userid=[command.arguments objectAtIndex:1];
    pin=[command.arguments objectAtIndex:2];
    NSString *toconfirm=[command.arguments objectAtIndex:3];
    
    NSLog(@"confirm licensekey %@", licensekey );
    NSLog(@"confirm userid %@", userid );
    NSLog(@"confirm pin %@", pin );
    NSLog(@"confirm toconfirm %@", toconfirm );

    @try{
        int res=[m confirm: licensekey usingWith: userid usingWith: pin usingWith: toconfirm];
        NSNumber *ress=@(res);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];

    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
     [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}
// update
- (void) update:(CDVInvokedUrlCommand*)command {
    userid=[command.arguments objectAtIndex:0];
    NSString *payload=[command.arguments objectAtIndex:1];
    pin=[command.arguments objectAtIndex:2];
    
    NSLog(@"update start userid %@",userid);
    NSLog(@"payload %@",payload);
    NSLog(@"pin %@",pin);
    
    @try{
       int res=[m Update: userid usingWith: payload usingWith: pin];
        NSNumber *ress=@(res);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
     [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}

// ResetPin
- (void) ResetPin:(CDVInvokedUrlCommand*)command {
    licensekey=[command.arguments objectAtIndex:0];
    userid=[command.arguments objectAtIndex:1];
    NSString *doctype=[command.arguments objectAtIndex:2];
    NSString *uniqueId=[command.arguments objectAtIndex:3];
    NSString *newpin=[command.arguments objectAtIndex:4];
    NSString *tStamp=[command.arguments objectAtIndex:5];
    @try{
        NSString *res=[mv ResetPin: licensekey usingWith: userid usingWith: doctype usingWith: uniqueId usingWith: newpin usingWith: tStamp];
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 res,@"Response",
                 @"true",@"success",
                 nil];

    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
}

// ChangePin
-(void) ChangePin:(CDVInvokedUrlCommand*)command{
    pin=[command.arguments objectAtIndex:0];
    NSString *newpin=[command.arguments objectAtIndex:1];
    NSString *tStamp=[command.arguments objectAtIndex:2];
    
    NSLog(@"ChangePin pin %@", pin);
     NSLog(@"ChangePin newpin %@", newpin);
     NSLog(@"ChangePin tStamp %@", tStamp);
    @try{
        NSString *res=[mv ChangePin: pin usingWith: newpin usingWith: tStamp];
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 res,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//ConfirmResetOrChangePin
-(void) ConfirmResetOrChangePin:(CDVInvokedUrlCommand*)command{
    NSString *toconfirm=[command.arguments objectAtIndex:0];
    NSLog(@"ConfirmResetOrChangePin toconfirm %@", toconfirm);
    @try{
        [mv LoadDelegates];
        [m LoadDelegates];
        BOOL res1=[mv ConfirmResetOrChangePin: toconfirm];
        [m getLogs];
        
        NSNumber *ress=@(res1);
        
        NSLog(@"%@", ress);
        
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    }
    @catch (NSException *exception) {
         NSLog(@"error");
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
//enableORDisableDebug
-(void) enableORDisableDebug: (CDVInvokedUrlCommand*)command{
    //mv = [[MobilityTrustVaultImpl alloc]init];
    NSString *bcheck=[command.arguments objectAtIndex:0];
    @try{
        BOOL res1=[mv enableORDisableDebug: bcheck];
        NSNumber *ress=@(res1);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//SelfDestroy
-(void)SelfDestroy:(CDVInvokedUrlCommand*)command{
    m = [[MobilityTrustKickStart alloc]init];
    userid=[command.arguments objectAtIndex:0];
     pin=[command.arguments objectAtIndex:1];
    @try{
        int res=[m selfDestroy: userid usingWith: pin];
        NSNumber *res1=@(res);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 res1,@"Response",
                 @"true",@"success",
                 nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
}
//getLogs
-(void)getLogs:(CDVInvokedUrlCommand*)command{
    m = [[MobilityTrustKickStart alloc]init];
    @try{
        NSString *logs=[m getLogs];
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 logs,@"Response",
                 @"true",@"success",
                 nil];
    }@catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
        //        return -1;
    }

}

//checkstatus
-(void) checkstatus:(CDVInvokedUrlCommand*)command{
    mv = [[MobilityTrustVaultImpl alloc]init];
    m = [[MobilityTrustKickStart alloc]init];
    userid=[command.arguments objectAtIndex:0];
    NSLog(@"checkstatus for %@", userid);
    @try{
        int res=[m CheckStatus: userid];
        NSNumber *ress=@(res);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 ress,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//unlockToken
-(void) UnlockToken:(CDVInvokedUrlCommand*)command{
    userid=[command.arguments objectAtIndex:0];
    licensekey=[command.arguments objectAtIndex:1];
    pin=[command.arguments objectAtIndex:2];
    NSString *pukCode=[command.arguments objectAtIndex:3];
    
    NSLog(@"UnlockToken userid %@", userid);
    NSLog(@"UnlockToken licensekey %@", licensekey);
    NSLog(@"UnlockToken pukCode %@", pukCode);
    NSLog(@"UnlockToken pin %@", pin);
    @try{
  NSString *res=[mv unlockToken: licensekey usingWith: userid usingWith: pukCode usingWith: pin];
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 res,@"Response",
                 @"true",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//GetOTPPlus
-(void)GetOTPPlus:(CDVInvokedUrlCommand*)command{
    AxiomOTPResponse *axiomotpresponse;
    NSString *timestamp = nil;
    timestamp=[command.arguments objectAtIndex:0];
    NSMutableDictionary *jsonResponse1;
           @try {
                axiomotpresponse=[mv GetOTPPlus:timestamp];
                NSString *OTP= axiomotpresponse.otp;
               jsonResponse1= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  OTP,@"otp",
                nil];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonResponse1];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception.reason);
                jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                         exception.reason,@"error",
                         @"false",@"success",
                         nil];
                pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)GetSOTPPlus:(CDVInvokedUrlCommand*)command{
    AxiomOTPResponse *axiomotpresponse;
    NSString *timestamp=[command.arguments objectAtIndex:0];
    NSString *challengeAnswerStr=[command.arguments objectAtIndex:1];
    NSArray *challengeAnswer=[challengeAnswerStr componentsSeparatedByString:@","];
    NSMutableDictionary *jsonResponse;
    @try {
        axiomotpresponse=[mv GetSOTPPlus:timestamp usingWith: challengeAnswer];
        NSString *OTP= axiomotpresponse.otp;
        jsonResponse= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        OTP,@"sotp",
                        nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonResponse];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
        jsonObj=[[NSDictionary alloc]initWithObjectsAndKeys:
                 exception.reason,@"error",
                 @"false",@"success",
                 nil];
        pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
