//
//  DeviceProfile.m
//  AxiomTrust
//
//  Created by nilesh kamble on 18/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import "Device.h"

@implementation Device
@synthesize macAddress = _macAddress, unidVendorid = _unidVendorid, uuid = _uuid, adId = _adId,cfuuid =_cfuuid,
platform = _platform,description = _description,localizedModel =_localizedModel,
deviceName =_deviceName,systemVersion =_systemVersion,systemName = _systemName;

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nMac Address: %@ \nVerndorid: %@\nUUID = %@\nAdd Id: %@\nCFUUID: %@\nPlatForm: %@\nDescription: %@\nLocalizeModel: %@\nDevice Name: %@\nSystem Version: %@\nSystemName: %@", _macAddress, _unidVendorid, _uuid, _adId,_cfuuid,_platform,_description,_localizedModel,_deviceName,_systemVersion,_systemName];
            }
@end
