//
//  AxiomPKIResponse.h
//  IOSMobileTrust
//
//  Created by nilesh kamble on 07/01/14.
//  Copyright (c) 2014 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AxiomPKIResponse : NSObject{
    NSString *_signature;
    NSString *_signatureplus;
    int _resultCode;
    NSString *_resultMessage;
}
@property(nonatomic,retain) NSString * signature;
@property(nonatomic,retain) NSString *signatureplus;
@property(nonatomic,readwrite) int resultCode;
@property(nonatomic,retain) NSString *resultMessage;

@end
