//
//  MZProfileViewController.m
//  MaskZoomTransitionDemo
//
//  Created by Steph Sharp on 27/01/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "MZProfileViewController.h"
#import "UIView+MZEmbed.h"

static NSString * const kEmailAddressTitle = @"email";
static NSString * const kMobilePhoneTitle = @"mobile";
static NSString * const kWorkPhoneTitle = @"work";
static NSString * const kServiceLineTitle = @"department";

static CGFloat const MZProfileImageMinHeight = 80.0f;
static CGFloat MZProfileImageMaxHeight;

@interface MZProfileViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *theProfileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theProfileRoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *theLocationLabel;

@property (weak, nonatomic) IBOutlet UIView *profileButtonsContainerView;
@property (weak, nonatomic) IBOutlet UITableView *theContactDetailsTableView;

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
@property (nonatomic, readonly) BOOL isMe;

@property (nonatomic) NSMutableArray *theTitles;
@property (nonatomic) NSMutableArray *theContactInformation;

@end

@implementation MZProfileViewController

@synthesize largeView, viewsToFadeIn;

- (void)viewDidLoad
{
    [super viewDidLoad];

    MZProfileImageMaxHeight = CGRectGetWidth([UIScreen mainScreen].bounds) - 40.0f;

    // Reduce size of profile image slightly on small screens
//    if (IS_IPHONE_4_OR_LESS) {
//        self.profileImageViewHeightConstraint.constant -= 35.0f;
//    }

    [self setUpProfile];
    [self addTableViewPanGestureRecognizerToView];
    [self setupProfileButtons];

    // When view is first loaded, hide navigation bar hairline immediately
//    [self.navigationController.navigationBar hideBottomHairlineAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // When returning to this view (e.g. unwind), animate out the navigation bar hairline
//    if ([self.navigationController.navigationBar hairlineIsVisible]) {
//        [self.navigationController.navigationBar hideBottomHairlineAnimated:YES];
//    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupTableView];
}

- (void)setUpProfile
{
    self.theProfileNameLabel.text = self.profile.displayName;
    self.theProfileRoleLabel.text = self.profile.person.role;
    self.theLocationLabel.text = self.profile.person.location;
    self.profileImageView.image = self.profile.profileImage;

	if (!self.theTitles)
		self.theTitles = [[NSMutableArray alloc] initWithCapacity:5];

	if (!self.theContactInformation)
		self.theContactInformation = [[NSMutableArray alloc] initWithCapacity:5];

	if (self.profile.person.mobile.length > 0) {
		[self.theTitles addObject:kMobilePhoneTitle];
		[self.theContactInformation addObject:self.profile.person.mobile];
	}

	if (self.profile.person.phone.length > 0) {
		[self.theTitles addObject:kWorkPhoneTitle];
		[self.theContactInformation addObject:self.profile.person.phone];
	}

    if (self.profile.person.email.length > 0) {
        [self.theTitles addObject:kEmailAddressTitle];
        [self.theContactInformation addObject:self.profile.person.email];
    }

    if (self.profile.person.department.length > 0) {
        [self.theTitles addObject:kServiceLineTitle];
        [self.theContactInformation addObject:self.profile.person.department];
    }
}

- (void)addTableViewPanGestureRecognizerToView
{
    for (UIGestureRecognizer *recognizer in self.theContactDetailsTableView.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.view addGestureRecognizer:recognizer];
        }
    }
}

- (void)setupTableView
{
    if (self.theContactDetailsTableView.contentInset.top == 0) {
        CGFloat topInset = CGRectGetHeight(self.headerView.frame) + 20;
        self.theContactDetailsTableView.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    }
}

- (void)setupProfileButtons
{
    UIView *profileButtonsView = self.isMe ? self.myProfileButtonsView : self.profileButtonsView;
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

- (BOOL)isMe
{
    return NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return (NSInteger)self.theTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ProfileCell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger index = (NSUInteger)indexPath.row;

	UILabel *lblName = (UILabel *)[cell viewWithTag:100];
	[lblName setText:[NSString stringWithFormat:@"%@", [self.theTitles objectAtIndex:index]]];

	UILabel *lblRole = (UILabel *)[cell viewWithTag:200];
	[lblRole setText:[NSString stringWithFormat:@"%@", [self.theContactInformation objectAtIndex:index]]];

	return cell;
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
    return @[self.theProfileNameLabel,
             self.theProfileRoleLabel,
             self.theLocationLabel,
             self.profileButtonsContainerView,
             self.theContactDetailsTableView];
}

- (UIView *)largeView
{
    return self.profileImageView;
}

#pragma mark - Actions

- (IBAction)dismiss
{
    if (self.delegate) {
        [self.delegate MZProfileViewControllerShouldDismiss:self];
    }
    else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
