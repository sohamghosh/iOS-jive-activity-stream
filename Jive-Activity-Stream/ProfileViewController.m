#import "AppConstants.h"
#import "ProfileViewController.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "CutomAFJSONResponseSerializer.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_profile"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[CutomAFJSONResponseSerializer serializer]];
    
    if ([[[AppConstants alloc] init]useMyTW]) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sohamgh" password:@"Ywr#693>47f,q22g?:J>,uE"];
    } else {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sohamgh@thoughtworks.com" password:@"93=:Yrf4gTn29<3KPs7qp,a"];
    }
    
    NSString *url = self.profileUrl;
    
    [manager GET:url parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id response) {
             self.profile = response;
             [self displayProfile];
         }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error....\n%@", error);
         }];            
}

- (void) displayProfile
{    
    // Scroll View
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320, 600);
    
    // Profile Image
    UIImageView *profileView = [[UIImageView alloc] init];
    profileView.frame = CGRectMake(20, 20, 100, 114);
    
    UIImage *placeholder = [UIImage imageNamed: @"Default"];
    NSURL *imageURL = [NSURL URLWithString:self.profile[@"thumbnailUrl"]];
    
    [profileView setImageWithURL:imageURL placeholderImage:placeholder];    
    [self.scrollView addSubview:profileView];
    
    // Name
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 40)];
    nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.profile[@"displayName"]];
    [self.scrollView addSubview:nameLabel];
    
    // Email
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 280, 40)];
    emailLabel.text = [NSString stringWithFormat:@"Email: %@", self.profile[@"emails"][0][@"value"]];
    [self.scrollView addSubview:emailLabel];
    
    // Phone Number
    UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 280, 40)];
    phone.text = [NSString stringWithFormat:@"Phone: %@", self.profile[@"phoneNumbers"][0][@"value"]];
    [self.scrollView addSubview:phone];
    
    // Biography
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(20, 320, 280, 270)];
    biography.text = @"Biography:\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    biography.font = [UIFont fontWithName:@"Helvetica" size:15];
    biography.editable = NO;
    [self.scrollView addSubview:biography];
    
    [self.view addSubview:self.scrollView];
}

@end
