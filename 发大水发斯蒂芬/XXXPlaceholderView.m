//
//  XXXPlaceholderView.m
//  发大水发斯蒂芬
//
//  Created by dzc on 2021/2/3.
//

#import "XXXPlaceholderView.h"

@implementation XXXPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"click" forState:UIControlStateNormal];
        btn.frame = CGRectMake(100, 100, 100, 40);
        [btn setBackgroundColor:[UIColor greenColor]];
        [btn addTarget:self action:@selector(clicl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
- (void)clicl{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
@end
