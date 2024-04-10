//
//  AxiomMobileTrust.h

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface AxiomMobileTrust : CDVPlugin
- (void)checkstatus:(CDVInvokedUrlCommand*)command;
- (void)initialize:(CDVInvokedUrlCommand*)command;
- (void)load:(CDVInvokedUrlCommand*)command;
-(void)unLoad:(CDVInvokedUrlCommand*)command;
- (void)confirm:(CDVInvokedUrlCommand*)command;
-(void)update:(CDVInvokedUrlCommand*)command;
-(void)ResetPin:(CDVInvokedUrlCommand*)command;
-(void)ChangePin:(CDVInvokedUrlCommand*)command;
-(void)ConfirmResetOrChangePin:(CDVInvokedUrlCommand*)command;
-(void)enableORDisableDebug:(CDVInvokedUrlCommand*)command;
-(void)SelfDestroy:(CDVInvokedUrlCommand*)command;
-(void)getLogs:(CDVInvokedUrlCommand*)command;
-(void)GetOTPPlus:(CDVInvokedUrlCommand*)command;
-(void)GetSOTPPlus:(CDVInvokedUrlCommand*)command;
-(void)UnlockToken:(CDVInvokedUrlCommand*)command;
@end
