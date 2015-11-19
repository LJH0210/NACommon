//
//  NANotification.m
//  NACommon
//
//  Created by  on 4/13/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NANotification.h"
#import <TSMessage.h>

@implementation NANotification

+ (void)showNotificationWithTitle:(NSString *)title type:(NANotificationType)type callback:(void (^)())callback {
    [TSMessage showNotificationInViewController:[TSMessage defaultViewController]
                                          title:title
                                       subtitle:nil
                                          image:nil
                                           type:(TSMessageNotificationType)type
                                       duration:NANotificationDurationAutomatic
                                       callback:^{
                                           if (callback) {
                                               callback();
                                           }
                                           [TSMessage dismissActiveNotification];
                                       }
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}

+ (void)showNotificationWithTitle:(NSString *)title subtitle:(NSString *)subtitle type:(NANotificationType)type callback:(void (^)())callback {
    [TSMessage showNotificationInViewController:[TSMessage defaultViewController]
                                          title:title
                                       subtitle:subtitle
                                          image:nil
                                           type:(TSMessageNotificationType)type
                                       duration:NANotificationDurationAutomatic
                                       callback:^{
                                           if (callback) {
                                               callback();
                                           }
                                           [TSMessage dismissActiveNotification];
                                       }
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(NANotificationType)type
                                callback:(void (^)())callback {
    [TSMessage showNotificationInViewController:viewController
                                          title:title
                                       subtitle:subtitle
                                          image:nil
                                           type:(TSMessageNotificationType)type
                                       duration:NANotificationDurationAutomatic
                                       callback:^{
                                           if (callback) {
                                               callback();
                                           }
                                           [TSMessage dismissActiveNotification];
                                       }
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(NANotificationType)type
                                duration:(NSTimeInterval)duration
                                callback:(void (^)())callback {
    [TSMessage showNotificationInViewController:viewController
                                          title:title
                                       subtitle:subtitle
                                          image:nil
                                           type:(TSMessageNotificationType)type
                                       duration:NANotificationDurationAutomatic
                                       callback:^{
                                           if (callback) {
                                               callback();
                                           }
                                           [TSMessage dismissActiveNotification];
                                       }
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}

@end
