//
//  AxiomOTPResponse.h
//  IOSMobileTrust
//
//  Created by nilesh kamble on 19/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AxiomOTPResponse : NSObject{
NSString *_otp;
NSString *_otpplus;
int _resultCode;
NSString *_resultMessage;
}
@property(nonatomic,retain) NSString * otp;
@property(nonatomic,retain) NSString *otpplus;
@property(nonatomic,readwrite) int resultCode;
@property(nonatomic,retain) NSString *resultMessage;

@end
