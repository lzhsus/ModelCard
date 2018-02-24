//
//  AddObject.m
//  YAFrameWork
//
//  Created by iMac on 2017/12/14.
//  Copyright © 2017年 John. All rights reserved.
//

#import "Oneyian.h"
/** 获取IP */
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
/** 获取Phone信息 */
#import "sys/utsname.h"

@implementation Oneyian

#pragma mark ===== 获取32位随机数 =====
+(NSString *)get32bit{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}
#pragma mark ===== 获取ipv4 =====
+(NSString *)getIP{
    NSArray *searchArray = @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ];
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
+(BOOL)isValidatIP:(NSString *)ipAddress{
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        if (firstMatch)return YES;
    }
    return NO;
}
+(NSDictionary *)getIPAddresses{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP)) {
                continue;
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
#pragma mark  =========== 快速初始化View ==========
+(UIView *)initViewWithColor:(UIColor *)color{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=color;
    return view;
}
#pragma mark  =========== 获取设备型号 ==========
+(NSString *)getPhoneModel;{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}
#pragma mark  =========== 压缩图片 ==========
+(NSData *)compressionImageData:(UIImage *)image{
    NSData *imageData=UIImageJPEGRepresentation(image, 1.0);
    if (!isObjectEmpty(imageData)) {
        CGFloat max=256;//阈值单位K
        while (imageData.length>max*1024) {
            if (imageData.length>max*4*1024) {
                imageData = UIImageJPEGRepresentation(image, 0.5);
            }else if (imageData.length>max*2*1024){
                imageData = UIImageJPEGRepresentation(image, 0.5);
            }else if (imageData.length>max*1024){
                imageData = UIImageJPEGRepresentation(image, 0.5);
            }
        }
    }else{
        return nil;
    }
    NSLog(@"压缩后:%fK",imageData.length/1024.f);
    return imageData;
}
#pragma mark  =========== 关闭TableView估算头尾行高 ==========
+(void)closeTableViewSection:(UITableView *)tableview{
    tableview.estimatedSectionHeaderHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
}
#pragma mark  =========== 通知 ==========
+(void)initNotification:(id)Observer selector:(SEL)Selector name:(NSString *)Name object:(id)Object{
    [[NSNotificationCenter defaultCenter] addObserver:Observer selector:Selector name:Name object:Object];
}
+(void)postNotification:(NSString *)Name object:(id)Object{
    [[NSNotificationCenter defaultCenter] postNotificationName:Name object:Object];
}
+(void)removeAllNotification:(id)observer{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}
#pragma mark  =========== 简介文字排版 ==========
+(NSMutableAttributedString *)sortingContent:(NSString *)content{
    if (!isStringEmpty(content)) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MarkFont(37.5)] range:NSMakeRange(0, content.length)];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.alignment=NSTextAlignmentLeft;
        style.lineSpacing = 3;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
        return attributedString;
    }else{
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
}

@end
