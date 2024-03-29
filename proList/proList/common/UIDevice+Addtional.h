//
//  UIDevice+Addtional.h
//  RenrenSixin
//
//  Created by TLB on 12-2-22.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ cameraAuthorziedBlock) (void);

@interface UIDevice (Addtional)

// 是否是iPhone
+ (BOOL)isiPhone;

// 是否是iPad
+ (BOOL)isiPad;

// 是否是iTouch
+ (BOOL)isiPodTouch;

// 支持拔打电话
+ (BOOL)supportTelephone;

// 支持发送短信
+ (BOOL)supportSendSMS;

//获取真机名称
+ (NSString *)deviceModelName;

// 支持发送邮件
//+ (BOOL)supportSendMail;

// 支持摄像头取景
+ (BOOL)supportCamera;

+ (void)cameraAuthorzied:(cameraAuthorziedBlock)authorizedBlock notAuthorized:(cameraAuthorziedBlock)notAuthorizedlock;
// 以全小写的形式返回设备名称
- (NSString*)modelNameLowerCase;

// 系统版本，以float形式返回
- (CGFloat)systemVersionByFloat;

// 系统版本比较
- (BOOL)systemVersionLowerThan:(NSString*)version;
- (BOOL)systemVersionNotHigherThan:(NSString *)version;
- (BOOL)systemVersionHigherThan:(NSString*)version;
- (BOOL)systemVersionNotLowerThan:(NSString *)version;

- (NSString *) macaddress;
- (NSString *) uniqueDeviceIdentifier;
- (NSString *) uniqueGlobalDeviceIdentifier;

// 内存信息
+ (unsigned int)freeMemory;
+ (unsigned int)usedMemory;

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;




@end
