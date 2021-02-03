//
//  UITableView+xxxxxx.h
//  发大水发斯蒂芬
//
//  Created by dzc on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (xxxxxx)

@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic,   copy) void(^reloadBlock)(void);

@end

NS_ASSUME_NONNULL_END
