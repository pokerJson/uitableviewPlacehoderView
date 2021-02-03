//
//  UITableView+xxxxxx.m
//  发大水发斯蒂芬
//
//  Created by dzc on 2021/2/3.
//

#import "UITableView+xxxxxx.h"
#import <objc/runtime.h>
#import "XXXPlaceholderView.h"

@implementation UITableView (xxxxxx)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(reloadData);
        SEL swizzledSelector = @selector(xxx_reloadData);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (void)xxx_reloadData {
    if (self.firstReload) {
        [self checkEmpty];
    }
    self.firstReload = NO;
    
    [self xxx_reloadData];
}

- (void)checkEmpty {
    BOOL isEmpty = YES; // 判空 flag 标示
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1; // 默认TableView 只有一组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1; // 获取当前TableView 组数
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i]; // 获取当前TableView各组行数
        if (rows) {
            isEmpty = NO; // 若行数存在，不为空
        }
    }
    if (isEmpty) { // 若为空，加载占位图
        if (!self.placeholderView) { // 若未自定义，加载默认占位图
            [self makeDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    } else { // 不为空，隐藏占位图
        self.placeholderView.hidden = YES;
    }
}
- (void)makeDefaultPlaceholderView {
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    XXXPlaceholderView *placeholderView = [[XXXPlaceholderView alloc] initWithFrame:self.bounds];
    placeholderView.backgroundColor = [UIColor orangeColor];
    __weak typeof(self) weakSelf = self;
    placeholderView.clickBlock = ^{
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    };
    self.placeholderView = placeholderView;
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
