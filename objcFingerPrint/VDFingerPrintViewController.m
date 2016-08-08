//
//  VDFingerPrintViewController.m
//  objcFingerPrint
//
//  Created by Deng on 16/8/5.
//  Copyright © Deng. All rights reserved.
//

#import "VDFingerPrintViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <objcView/objcView.h>
#import <objcWindow/objcWindow.h>
#import <objcBlock/objcBlock.h>

NSString *const VDFingerPrintViewControllerNotificationLock = @"VDFingerPrintViewControllerNotificationLock";
NSString *const VDFingerPrintViewControllerNotificationUnlock = @"VDFingerPrintViewControllerNotificationUnlock";

@interface VDFingerPrintViewController ()

- (void)__i__appWillResignActive:(NSNotification *)notification;
- (void)__i__appDidEnterBackground:(NSNotification *)notification;
- (void)__i__appWillEnterForeground:(NSNotification *)notification;
- (void)__i__appDidBecomeActive:(NSNotification *)notification;

- (void)__i__onTap;
- (void)__i__show;
- (void)__i__checkFingerPrint;

@property (nonatomic, assign) BOOL isShowing;

@property (nonatomic, assign) NSInteger registerCount;

@end


@implementation VDFingerPrintViewController

#pragma mark Constructor


#pragma mark Public Method
- (void)registerLock {
    self.registerCount += 1;
}

- (void)unregisterLock {
    self.registerCount -= 1;
    self.registerCount = MAX(self.registerCount, 0);
}

- (void)show {
    if (!self.isShowing) {
        self.isShowing = YES;
        [VDWindow.rootViewController presentViewController:self animated:YES completion:NULL];
    }
}

- (void)check {
    if (!self.isShowing) {
        self.isShowing = YES;
        VDWeakifySelf;
        [VDWindow.rootViewController presentViewController:self animated:YES completion:^{
            VDStrongifySelf;
            [self __i__checkFingerPrint];
        }];
    }
    else {
        [self __i__checkFingerPrint];
    }
}

- (void)fingerPrintDidUnsupport {
    
}

#pragma mark Properties
- (void)setIsLock:(BOOL)isLock {
    if (_isLock != isLock) {
        _isLock = isLock;
        if (_isLock) {
            [[NSNotificationCenter defaultCenter] postNotificationName:VDFingerPrintViewControllerNotificationLock object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:VDFingerPrintViewControllerNotificationUnlock object:nil];
        }
    }
}

#pragma mark Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__i__appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__i__appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__i__appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__i__appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self.view vd_performSelectorOnTapWithTarget:self selector:@selector(__i__onTap)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

#pragma mark IBActions


#pragma mark Delegates


#pragma mark Protected Method


#pragma mark Private Methods
- (void)__i__appWillResignActive:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    [self __i__show];
}

- (void)__i__appDidEnterBackground:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    self.isLock = YES;
    [self __i__show];
}

- (void)__i__appWillEnterForeground:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    [self __i__checkFingerPrint];
}

- (void)__i__appDidBecomeActive:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    if (self.isShowing && !self.isLock)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.isShowing = NO;
    }
}

- (void)__i__onTap {
    if (self.isLock) {
        [self __i__checkFingerPrint];
    }
}

- (void)__i__show {
    if (self.registerCount <= 0) {
        return;
    }
    
    if (!self.isShowing)
    {
        self.isShowing = YES;
        [VDWindow.rootViewController presentViewController:self animated:YES completion:NULL];
    }
}

- (void)__i__checkFingerPrint
{
    self.isLock = YES;
    
    LAContext *context = [ [LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL])
    {
        VDWeakifySelf;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.checkReason reply:^(BOOL success, NSError *error) {
            VDStrongifySelf;
            if (success)
            {
                [self dismissViewControllerAnimated:YES completion:NULL];
                self.isShowing = NO;
                self.isLock = NO;
            }
        }];
    }
    else {
        [self fingerPrintDidUnsupport];
    }
}

@end
