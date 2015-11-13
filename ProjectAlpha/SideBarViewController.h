//
//  ViewController.h
//  sideBar
//
//  Created by Sunshuaiqi on 10/27/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SideBarViewController;

@protocol SideBarViewControllerDelegate <NSObject>
- (void)introPage;
@end

@interface SideBarViewController : UIViewController

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *portraitButton;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, assign) id<SideBarViewControllerDelegate> delegate;
@end

