    //
//  AxiomTrust.m
//  AxiomTrust
//
//  Created by nilesh kamble on 18/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import "Axiom.h"
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <AdSupport/ASIdentifierManager.h>
#import <UIKit/UIKit.h>

#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "Device.h"


@implementation Axiom
//@synthesize responseData = _responseData;


//static int AES = 1;
//static int RSA = 2;
//static int AES_KEY_SIZE_192 = 192;

static NSString *strResult;
static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};
-(id)init{
    
    self = [super init];
    if(self)
    {
       
        
    }
    return self;

}
-(int) WriteFile:(NSString *)filename usingWith:(NSString *)filedata{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/%@",
                          documentsDirectory,filename];
    //create content - four lines of text
    // NSString *content = @"One\nTwo\nThree\nFour\nFive";
    
    NSString *content = filedata;
    //save content to the documents directory
   bool result = [content writeToFile:fileName
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    if(result == true){
        return 0;
    }else{
        return -1;
    }
    
}


-(NSString *) LoadFile:(NSString *)filename{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *strFileName = [NSString stringWithFormat:@"%@/%@",
                          documentsDirectory,filename];
    NSString *content = [[NSString alloc] initWithContentsOfFile:strFileName
                                                    usedEncoding:nil
                                                           error:nil];
    return content;
    //use simple alert from my library (see previous post for details)
    // [ASFunctions alert:content];
    //  [content release];
    
}


-(int) DestroyFile:(NSString *)filename{
    
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:filename];
        NSError *error;
        BOOL success =[fileManager removeItemAtPath:filePath error:&error];
        if (success) {
//            UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Congratulation:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [removeSuccessFulAlert show];
            return 0;
            
        }
        else
        {
             NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
            return -1;
           
        }
    
}


// encode method
-(NSString *) encodeBase64:(NSString *)str
{
    
    NSData* data=[str dataUsingEncoding:NSUTF8StringEncoding];
    int length = str.length;
    
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}


// decode method
- (NSData *)decodeBase64:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil)
    {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4)
            {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak)
            {
                break;
            }
        }
    }
    
    return theData;
    
}



-(NSString *)parseJSON:(NSMutableDictionary *)dictonary{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictonary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *resultAsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return resultAsString;
}

-(NSMutableDictionary *)getDictonaryFromJSONString:(NSString *)jsonString{
     NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData //1
                                                         options:kNilOptions
                                                           error:&error];

    return json;
}



-(NSMutableDictionary *)SendData:(NSString *)url usingWith:(NSMutableArray *)headers usingWith:(NSMutableArray *)nameValue usingwith:(bool)bSecure{
  //  NSArray *retData = [[NSArray alloc]init][2];
   
    NSString *dataToSend = @"";
    if (nameValue != NULL) {
        for (int i = 0; i < nameValue.count; i++) {
            NSString *str1 = [[nameValue objectAtIndex:i] objectAtIndex:0];
            NSString * str2 = [[nameValue objectAtIndex:i] objectAtIndex:1];
           
            [str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (i == 0) {
                
                dataToSend = [[[@"?" stringByAppendingString:[self encodeURL:str1]] stringByAppendingString:@"="] stringByAppendingString:[self encodeURL:str2]];
            } else {
                dataToSend = [[[@"&" stringByAppendingString:[self encodeURL:str1]] stringByAppendingString:@"="] stringByAppendingString:[self encodeURL:str2]];;
            }
        }
    }
    if(bSecure == true){
        
        
        
    }else{
        url = [url stringByAppendingString:dataToSend];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
       
            if(headers != NULL){
               for (int i=0; i< headers.count; i++) {
                   NSString *str1 = [[headers objectAtIndex:i] objectAtIndex:0];
                   NSString *str2 = [[headers objectAtIndex:i] objectAtIndex:1];
               [urlRequest setValue:str2 forHTTPHeaderField:str1];
            }
        }
        

       // self.responseData = [NSMutableData data];
//        NSURLRequest *request = [NSURLRequest requestWithURL:
//                                 [NSURL URLWithString:@"https://54.206.15.218:8443/MobileTrustAxiom/ipfinder"]];
      //  [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                              returningResponse:&response
                                                          error:&error];
        
        
        
        
        NSMutableDictionary *jsonObject=[NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableLeaves
                                         error:nil];
        
        if (error == nil)
        {
            return jsonObject;
            // Parse data here
        }
       // NSMutableDictionary *jsonObject= _responseData;
        return jsonObject;
    }
    return NULL;
}




//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [activedata appendData:data];
//}

//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSString *_serverResponse=[[NSString alloc] initWithData:activedata encoding:NSUTF8StringEncoding];
//    NSMutableDictionary *_dict= [self getDictonaryFromJSONString:_serverResponse];
//    [self.delegate onReceivingDataFromServerWithData:_dict];
//}


- (NSString *) stringToHex:(NSString *)str
{
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        // [hexString [NSString stringWithFormat:@"%02x", chars[i]]]; /*previous input*/
        [hexString appendFormat:@"%02x", chars[i]]; /*EDITED PER COMMENT BELOW*/
    }
    free(chars);
    
    return hexString ;
}

- (NSString *)stringFromHexString:(NSString *)hexString {
    
    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexString length]; i += 2) {
        
        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex cStringUsingEncoding:NSASCIIStringEncoding], "%x", &decimalValue);
        
        [string appendFormat:@"%c", decimalValue];
    }
    
    return string;
}
- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate
{
    NSDate* enddate = checkEndDate;
    NSDate* currentdate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
        return YES;
    else if (secondsBetweenDates < 0)
        return YES;
    else
        return NO;
}


-(NSData *) LoadFileByByte:(NSString *)filename{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat:@"%@/%@",
                          documentsDirectory,filename];
  
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filepath];
   //make a file name to write the data to using the documents directory:
       return data;
    //use simple alert from my library (see previous post for details)
    // [ASFunctions alert:content];
    //  [content release];
    
}
- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    if (newString)
    {
        return newString;
    }
    
    return @"";
}

- (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
//-(void) connectWithUrl:(NSString *)Url withDelegate:(id<ConnectDelegate>)delegate withSynchronous:(BOOL)bSynchronous {
//    if(bSynchronous) {
//        NSURL *url = [NSURL URLWithString:Url];
//        //  NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//        //        NSData *requestData = [NSData dataWithBytes:[JSONRequest UTF8String] length:[JSONRequest length]];
//        //        NSString *yourStr= [[[NSString alloc] initWithData:requestData
//        //                                                  encoding:NSUTF8StringEncoding] autorelease];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        //        [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
//        //        [request setHTTPBody:requestData];
//        
//        NSURLResponse * response = nil;
//        NSError * error = nil;
//        
//        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        NSString *_serverResponse=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSMutableDictionary *_dict= [self getDictonaryFromJSONString:_serverResponse];
//        [self.delegate onReceivingDataFromServerWithData:_dict];
//    } else {
//        Url =[Url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        _connectDelegate = delegate;
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        NSURL *url = [[NSURL alloc] initWithString:Url];
//        [request setURL:url];
//        url = nil;
//        
//        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        activedata= [[NSMutableData alloc] init];
//        [conn start];
//        
//    }
//}

//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [activedata appendData:data];
//}

//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSString *_serverResponse=[[NSString alloc] initWithData:activedata encoding:NSUTF8StringEncoding];
//    NSMutableDictionary *_dict= [self getDictonaryFromJSONString:_serverResponse];
//    [self.delegate onReceivingDataFromServerWithData:_dict];
//}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    NSLog(@"didReceiveResponse");
//    [self.responseData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [self.responseData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"didFailWithError");
//    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"connectionDidFinishLoading");
//    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
//    
//    // convert to JSON
//    NSError *myError = nil;
//    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
//    
//    // show all values
//    for(id key in res) {
//        
//        id value = [res objectForKey:key];
//        
//        NSString *keyAsString = (NSString *)key;
//        NSString *valueAsString = (NSString *)value;
//        
//        NSLog(@"key: %@", keyAsString);
//        NSLog(@"value: %@", valueAsString);
//    }
//    
//    // extract specific value...
//    //    NSArray *results = [res objectForKey:@"ip"];
//    //
//    //    for (NSDictionary *result in results) {
//    //        NSString *icon = [result objectForKey:@"ip"];
//    //        NSLog(@"icon: %@", icon);
//    //    }
//    
//}
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    
//    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
//}
-(NSString *)SimpleSendData:(NSString *)url usingWith:(NSMutableArray *)headers usingWith:(NSMutableArray *)nameValue usingwith:(bool)bSecure{
    //  NSArray *retData = [[NSArray alloc]init][2];
    
    NSString *dataToSend = @"";
    if (nameValue != NULL) {
        for (int i = 0; i < nameValue.count; i++) {
            NSString *str1 = [[nameValue objectAtIndex:i] objectAtIndex:0];
            NSString * str2 = [[nameValue objectAtIndex:i] objectAtIndex:1];
            
            [str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (i == 0) {
                
                dataToSend = [[[@"?" stringByAppendingString:[self encodeURL:str1]] stringByAppendingString:@"="] stringByAppendingString:[self encodeURL:str2]];
            } else {
                dataToSend = [[[@"&" stringByAppendingString:[self encodeURL:str1]] stringByAppendingString:@"="] stringByAppendingString:[self encodeURL:str2]];;
            }
        }
    }
    if(bSecure == true){
        
        
        
    }else{
        url = [url stringByAppendingString:dataToSend];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        if(headers != NULL){
            for (int i=0; i< headers.count; i++) {
                NSString *str1 = [[headers objectAtIndex:i] objectAtIndex:0];
                NSString *str2 = [[headers objectAtIndex:i] objectAtIndex:1];
                [urlRequest setValue:str2 forHTTPHeaderField:str1];
            }
        }
        
        
        
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                              returningResponse:&response
                                                          error:&error];
        
        //        NSMutableDictionary *jsonObject=[NSJSONSerialization
        //                                         JSONObjectWithData:data
        //                                         options:NSJSONReadingMutableLeaves
        //                                         error:nil];
        
        NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (error == nil)
        {
            return nil;
            // Parse data here
        }
        return stringData;
    }
    return NULL;
}
-(Device *) getDeviceProfile{
    Device *deviceInfo = [[Device alloc]init];
//    deviceInfo.macAddress = [Axiom getMacAddress];
    deviceInfo.unidVendorid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    deviceInfo.uuid = [[NSUUID UUID] UUIDString];
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    deviceInfo.cfuuid = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    deviceInfo.adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    deviceInfo.platform = [UIDevice currentDevice].model;
    deviceInfo.description = [UIDevice currentDevice].description;
    deviceInfo.localizedModel= [UIDevice currentDevice].localizedModel;
    deviceInfo.deviceName =[UIDevice currentDevice].name;
    deviceInfo.systemVersion = [UIDevice currentDevice].systemVersion;
    deviceInfo.systemName = [UIDevice currentDevice].systemName;
    return deviceInfo;
}
//- (NSString *)stringFromHexString:(NSString *)hexString {
//    
//    // The hex codes should all be two characters.
//    if (([hexString length] % 2) != 0)
//        return nil;
//    
//    NSMutableString *string = [NSMutableString string];
//    
//    for (NSInteger i = 0; i < [hexString length]; i += 2) {
//        
//        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
//        NSInteger decimalValue = 0;
//        sscanf([hex UTF8String], "%x", &decimalValue);
//        [string appendFormat:@"%c", decimalValue];
//    }
//}


@end




