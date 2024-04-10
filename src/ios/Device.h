//
//  DeviceProfile.h
//  AxiomTrust
//
//  Created by nilesh kamble on 18/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device: NSObject{
    
    NSString *_macAddress;
    NSString *_unidVendorid;
    NSString *_uuid;
    NSString *_cfuuid;
    NSString *_adId;
    NSString *_platform;
    NSString *_description;
    NSString *_localizedModel;
    NSString *_deviceName;
    NSString *_systemVersion;
    NSString *_systemName;
}
@property(nonatomic,retain) NSString *macAddress;
@property(nonatomic,retain) NSString *unidVendorid;

@property(nonatomic,retain) NSString *uuid;

@property(nonatomic,retain) NSString *cfuuid;

@property(nonatomic,retain) NSString *adId;

@property(nonatomic,retain) NSString *platform;

@property(nonatomic,retain) NSString *description;

@property(nonatomic,retain) NSString *localizedModel;

@property(nonatomic,retain) NSString *deviceName;
@property(nonatomic,retain) NSString *systemVersion;
@property(nonatomic,retain) NSString *systemName;


@end
