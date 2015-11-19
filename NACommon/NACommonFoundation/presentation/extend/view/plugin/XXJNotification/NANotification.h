//
//  NANotification.h
//  NACommon
//
//  Created by  on 4/13/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NANotificationType) {
    NANotificationTypeMessage = 0,
    NANotificationTypeWarning,
    NANotificationTypeError,
    NANotificationTypeSuccess
};

typedef NS_ENUM(NSInteger, NANotificationPosition) { NANotificationPositionTop = 0, NANotificationPositionNavBarOverlay, NANotificationPositionBottom };

/** This enum can be passed to the duration parameter */
typedef NS_ENUM(NSInteger, NANotificationDuration) {
    NANotificationDurationAutomatic = 0,
    NANotificationDurationEndless = -1 // The notification is displayed until the user dismissed it or it is dismissed by calling dismissActiveNotification
};

@interface NANotification : NSObject

+ (void)showNotificationWithTitle:(NSString *)title type:(NANotificationType)type callback:(void (^)())callback;

+ (void)showNotificationWithTitle:(NSString *)title subtitle:(NSString *)subtitle type:(NANotificationType)type callback:(void (^)())callback;

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(NANotificationType)type
                                callback:(void (^)())callback;

+ (void)showNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(NANotificationType)type
                                duration:(NSTimeInterval)duration
                                callback:(void (^)())callback;

@end
