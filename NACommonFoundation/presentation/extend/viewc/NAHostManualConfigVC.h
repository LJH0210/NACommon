//
//  NAHostManualConfigVC.h
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author , 15-03-25 19:03:49
 *
 *  主机手动配置界面委托
 */
@protocol NAHostManualConfigDelegate <NSObject>

@optional
/**
 *  @author , 15-03-25 19:03:14
 *
 *  手动配置已保存
 */
- (void)manualConfigFinished;

@end

/**
 *  @author , 15-03-25 19:03:38
 *
 *  系统主机手动配置界面
 */
@interface NAHostManualConfigVC : UIViewController

/**
 *  @author , 15-03-25 19:03:07
 *
 *  配置界面的委托
 */
@property (nonatomic, weak) id<NAHostManualConfigDelegate> delegate;

@end
