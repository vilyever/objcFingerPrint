//
//  VDFingerPrintViewController.h
//  objcFingerPrint
//
//  Created by Deng on 16/8/5.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const VDFingerPrintViewControllerNotificationLock;
extern NSString *const VDFingerPrintViewControllerNotificationUnlock;

@class VDFingerPrintViewController;


@interface VDFingerPrintViewController : UIViewController

#pragma mark Constructor


#pragma mark Public Method
- (void)registerLock;
- (void)unregisterLock;
- (void)show;
- (void)check;

- (void)fingerPrintDidUnsupport;

#pragma mark Properties
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, copy) NSString *checkReason;

#pragma mark Protected Method


#pragma mark Private Method


@end
