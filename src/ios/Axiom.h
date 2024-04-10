//
//  AxiomTrust.h
//  AxiomTrust
//
//  Created by nilesh kamble on 18/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h";
//@protocol ConnectDelegate <NSObject>
//-(void) onReceivingDataFromServerWithData:(NSMutableDictionary *) data;
//@end

@interface Axiom : NSObject
//@property (nonatomic, strong) NSMutableData *responseData;
//<NSURLConnectionDelegate>
//{
//    
//    
//    NSMutableData *activedata;
//    id<ConnectDelegate>_connectDelegate;
//}
//@property (nonatomic,retain) id<ConnectDelegate> delegate;
//-(void) connectWithUrl:(NSString *) Url withDelegate:(id <ConnectDelegate>) delegate withSynchronous:(BOOL) bSynchronous;



//fileoperations

-(int) WriteFile:(NSString *)filename usingWith:(NSString *)filedata;
-(NSString *) LoadFile:(NSString *)filename;
-(int) DestroyFile:(NSString *)filename;

//Base64
-(NSString *) encodeBase64:(NSString *)str;
- (NSData *) decodeBase64: (NSString *)string;

///JsonOperations
-(NSString *)parseJSON:(NSMutableDictionary *)dictonary;
-(NSMutableDictionary *)getDictonaryFromJSONString:(NSString *)jsonString;


//Http Connection
-(NSMutableDictionary *)SendData:(NSString *)url usingWith:(NSMutableArray *)headers usingWith:(NSMutableArray *)nameValue usingwith:(bool)bSecure;
-(NSData *) LoadFileByByte:(NSString *)filename;
- (NSString*)encodeURL:(NSString *)string;
- (NSString*)base64forData:(NSData*)theData;
-(NSString *)SimpleSendData:(NSString *)url usingWith:(NSMutableArray *)headers usingWith:(NSMutableArray *)nameValue usingwith:(bool)bSecure;

- (NSString *)stringFromHexString:(NSString *)hexString;
-(Device *) getDeviceProfile;
@end
