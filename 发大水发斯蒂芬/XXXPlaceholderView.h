//
//  XXXPlaceholderView.h
//  发大水发斯蒂芬
//
//  Created by dzc on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^reloadClickBlock)(void);

@interface XXXPlaceholderView : UIView

@property (nonatomic,copy) reloadClickBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
