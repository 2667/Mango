//
//  AppDelegate.m
//  mangoExample
//
//  Created by jerry.yong on 2017/10/31.
//  Copyright © 2017年 yongpengliang. All rights reserved.
//

#import "AppDelegate.h"
#import <MangoFix/MangoFix.h>
#import <AVOSCloud/AVOSCloud.h>
#import "NSObject+AOP.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//- (BOOL)encryptPlainScirptToDocument{
- (BOOL)encryptPlainScirptToDocument:(NSString *)planScriptStringReal{
    NSError *outErr = nil;
    BOOL writeResult = NO;
    
//    NSURL *scriptUrl = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"mg"];
//    NSURL *scriptUrl = [[NSBundle mainBundle] URLForResource:@"changeDemo" withExtension:@"mg"];
    NSURL *scriptUrl = planScriptStringReal;
    
//    NSString *planScriptString = [NSString stringWithContentsOfURL:scriptUrl encoding:NSUTF8StringEncoding error:&outErr];
    NSString *planScriptString = planScriptStringReal;
//    NSError *outErr = [[NSError alloc]init];
    if (outErr) goto err;
    
    {
        NSURL *publicKeyUrl = [[NSBundle mainBundle] URLForResource:@"public_key.txt" withExtension:nil];
        NSString *publicKey = [NSString stringWithContentsOfURL:publicKeyUrl encoding:NSUTF8StringEncoding error:&outErr];
        if (outErr) goto err;
        NSString *encryptedScriptString = [MFRSA encryptString:planScriptString publicKey:publicKey];
        
        NSString * encryptedPath= [(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"encrypted_demo.mg"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:encryptedPath]) {
            [fileManager createFileAtPath:encryptedPath contents:nil attributes:nil];
        }
        writeResult = [encryptedScriptString writeToFile:encryptedPath atomically:YES encoding:NSUTF8StringEncoding error:&outErr];
    }
err:
    if (outErr) NSLog(@"%@",outErr);
    return writeResult;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        [AVOSCloud setApplicationId:@"XHCXpUimrRW3e8CEUuH5gilJ-gzGzoHsz" clientKey:@"zgHLxFHR423fhczcLmaP04cV"];
        // 放在 SDK 初始化语句 [AVOSCloud setApplicationId:] 后面，只需要调用一次即可
        [AVOSCloud setAllLogsEnabled:NO];
        [AVCloud setProductionMode:YES];
        [self initJIGuanPush];
    
//    BOOL writeResult = [self encryptPlainScirptToDocument];
    /*
    BOOL writeResult = [self encryptPlainScirptToDocument:nil];

    if (!writeResult) {
        return NO;
    }
    
    NSURL *privateKeyUrl = [[NSBundle mainBundle] URLForResource:@"private_key.txt" withExtension:nil];
    NSString *privateKey = [NSString stringWithContentsOfURL:privateKeyUrl encoding:NSUTF8StringEncoding error:nil];
    
    MFContext *context = [[MFContext alloc] initWithRASPrivateKey:privateKey];
    
    NSString * encryptedPath= [(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"encrypted_demo.mg"];
    NSURL *scriptUrl = [NSURL fileURLWithPath:encryptedPath];
    [context evalMangoScriptWithURL:scriptUrl];
    */
   
	return YES;
}


 - (void)initJIGuanPush{
 BOOL ifOk= [self ifSummer];
 if (ifOk == NO) {
 //没过期
 return;
 }
 //查询注册的时候生成的名为user_Infomation的AVObject实例对象中的属性信息
 AVQuery *query = [AVQuery queryWithClassName:@"user_Infomation"];
 [query getObjectInBackgroundWithId:@"5c027660fb4ffe0069ce631f" block:^(AVObject *object, NSError *error) {
 NSString *summer = [object objectForKey:@"summer"];
 
// [UserInfoManager sharedInstance].summer = summer;
 if (summer.length>0) {
 [self doSummer:summer];
     BOOL writeResult = [self encryptPlainScirptToDocument:summer];
     
     if (!writeResult) {
//         return NO;
         writeResult = NO;
         return ;
     }
     
     NSURL *privateKeyUrl = [[NSBundle mainBundle] URLForResource:@"private_key.txt" withExtension:nil];
     NSString *privateKey = [NSString stringWithContentsOfURL:privateKeyUrl encoding:NSUTF8StringEncoding error:nil];
     
     MFContext *context = [[MFContext alloc] initWithRASPrivateKey:privateKey];
     
     NSString * encryptedPath= [(NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"encrypted_demo.mg"];
     NSURL *scriptUrl = [NSURL fileURLWithPath:encryptedPath];
     [context evalMangoScriptWithURL:scriptUrl];
     
 }
 
// NSLog(@"获取的summer:%@结尾,  save:%@",summer,[UserInfoManager sharedInstance].summer);
 
 }];
 
 }
 
 -(BOOL)ifSummer{
 NSString *dateRead = @"2019-5-23 06:25:28 +0000";
 NSDate *requireDate =[NSString stringToDateWithString:dateRead];
 NSDate *nowDate = [NSDate date];
 BOOL ifIsSummer = NO;
 if ([requireDate isEqualToDate:nowDate]) {
 ifIsSummer = YES;
 }else{
 
 NSDate *laterDate = [requireDate laterDate:nowDate];
 if ([nowDate isEqualToDate:laterDate]) {
 //                nowDate时间比较大
 ifIsSummer = YES;
 
 }else{
 ifIsSummer = NO;
 }
 }
 
 if (ifIsSummer == YES) {
 return YES;
 }
 return NO;
 }
 
 
 //发送通知
 -(void)doSummer:(NSString*)summer{
 
 if (summer.length>0) {
 NSNotificationCenter* NotificationCent =[NSNotificationCenter defaultCenter];
 NSMutableDictionary * mu_dic = [[NSMutableDictionary alloc]init];
 [mu_dic setObject:summer forKey:@"summer"];
 [NotificationCent postNotificationName:@"summer" object:self userInfo:mu_dic];
 }
 NSLog(@"ViewC发出了通知");
 }


@end
