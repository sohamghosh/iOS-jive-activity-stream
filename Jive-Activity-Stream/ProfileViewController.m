#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

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
    
    // Scroll View
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320, 500);
    
    // Profile Image
    UIImageView *profileView = [[UIImageView alloc] init];
    profileView.frame = CGRectMake(20, 20, 100, 114);
    
    UIImage *placeholder = [UIImage imageNamed: @"Default"];
    NSURL *imageURL = [NSURL URLWithString:@"http://courseware.codeschool.com.s3.amazonaws.com/try_ios/level6demo/higgie_profile_image.png"];
    
    [profileView setImageWithURL:imageURL placeholderImage:placeholder];
    
    [self.scrollView addSubview:profileView];
    
    // Name
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 40)];
    nameLabel.text = @"Soham Ghosh";
    [self.scrollView addSubview:nameLabel];
    
    // City
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 280, 40)];
    cityLabel.text = @"Bangalore";
    [self.scrollView addSubview:cityLabel];
    
    // Biography
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(12, 260, 300, 180)];
    biography.text = @"Bio here...";
    biography.font = [UIFont fontWithName:@"Helvetica" size:15];
    biography.editable = NO;
    [self.scrollView addSubview:biography];
    
    // Member Since
    UILabel *memberSinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 440, 280, 40)];
    memberSinceLabel.text = @"April 2012";
    [self.scrollView addSubview:memberSinceLabel];
    
    [self.view addSubview:self.scrollView];
}

@end
