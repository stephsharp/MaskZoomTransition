//
//  MZProfileViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfileViewController.h"
#import "UIView+MZEmbed.h"
#import "UIView+MZNavigationBar.h"

static CGFloat const MZProfileImageMinHeight = 80.0f;
static CGFloat MZProfileImageMaxHeight;

@interface MZProfileViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIView *profileButtonsContainerView;
@property (weak, nonatomic) IBOutlet UITableView *contactDetailsTableView;

@property (weak, nonatomic) IBOutlet UIView *profileButtonsView;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIView *phoneSpacerView;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIView *messageSpacerView;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
@property (weak, nonatomic) IBOutlet UIButton *addressBookButton;

@property (weak, nonatomic) IBOutlet UIView *myProfileButtonsView;
@property (weak, nonatomic) IBOutlet UIButton *myAddressBookButton;

@property (nonatomic) CGFloat profileImageOriginalHeight;

@end

@implementation MZProfileViewController

@synthesize largeView, viewsToFadeIn;

- (void)viewDidLoad
{
    [super viewDidLoad];

    MZProfileImageMaxHeight = CGRectGetWidth([UIScreen mainScreen].bounds) - 40.0f;

    // Decrease size of profile image on small screens (e.g. iPhone 4S)
    if (CGRectGetHeight([UIScreen mainScreen].bounds) < 568) {
        self.profileImageViewHeightConstraint.constant -= 35.0f;
    }

    [self setUpProfile];
    [self addTableViewPanGestureRecognizerToView];
    [self setupProfileButtons];

    // When view is first loaded, hide navigation bar hairline immediately
    [self.navigationController.navigationBar mz_hideBottomHairlineAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // When returning to this view (e.g. unwind), animate out the navigation bar hairline
    if ([self.navigationController.navigationBar mz_hairlineIsVisible]) {
        [self.navigationController.navigationBar mz_hideBottomHairlineAnimated:YES];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupTableView];
}

- (void)setUpProfile
{
    self.nameLabel.text = self.profile.displayName;
    self.roleLabel.text = self.profile.person.role;
    self.locationLabel.text = self.profile.person.location;
    self.profileImageView.image = self.profile.profileImage;

    self.contactDetailsTableView.dataSource = self.profile;

    // Hide delete button if viewing authenticated user
    if (self.profile.person.isAuthenticated) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)addTableViewPanGestureRecognizerToView
{
    for (UIGestureRecognizer *recognizer in self.contactDetailsTableView.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.view addGestureRecognizer:recognizer];
        }
    }
}

- (void)setupTableView
{
    if (self.contactDetailsTableView.contentInset.top == 0) {
        CGFloat topInset = CGRectGetHeight(self.headerView.frame) + 20;
        self.contactDetailsTableView.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    }
}

- (void)setupProfileButtons
{
    UIView *profileButtonsView = self.profile.person.isAuthenticated ? self.myProfileButtonsView : self.profileButtonsView;
    [self.profileButtonsContainerView addSubview:profileButtonsView];
    [self.profileButtonsContainerView mz_addContainerConstraintsToSubview:profileButtonsView];
}

#pragma mark - Properties

- (CGFloat)profileImageOriginalHeight
{
    if (_profileImageOriginalHeight == 0) {
        _profileImageOriginalHeight = self.profileImageViewHeightConstraint.constant;
    }
    return _profileImageOriginalHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    float imageHeight = fmaxf((float)(self.profileImageOriginalHeight - offset), (float)MZProfileImageMinHeight);
    imageHeight = fminf(imageHeight, (float)MZProfileImageMaxHeight);

    self.profileImageViewHeightConstraint.constant = imageHeight;
}

#pragma mark - MZMaskZoomTransitionPresentedViewController

- (NSArray *)viewsToFadeIn
{
    return @[self.nameLabel,
             self.roleLabel,
             self.locationLabel,
             self.profileButtonsContainerView,
             self.contactDetailsTableView];
}

- (UIView *)largeView
{
    return self.profileImageView;
}

#pragma mark - Actions

- (IBAction)dismiss
{
    if ([self.delegate respondsToSelector:@selector(MZProfileViewControllerShouldDismiss:)]) {
        [self.delegate MZProfileViewControllerShouldDismiss:self];
    }
    else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)delete
{
    NSString *title = [NSString stringWithFormat:@"Delete %@?", self.profile.person.firstName];
    UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([self.delegate respondsToSelector:@selector(MZProfileViewControllerShouldDelete:)]) {
            [self.delegate MZProfileViewControllerShouldDelete:self];
            [self dismiss];
        }
    }];

    [deleteAlert addAction:cancelAction];
    [deleteAlert addAction:deleteAction];

    [self presentViewController:deleteAlert animated:YES completion:nil];
}

@end
