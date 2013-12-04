#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSString *profileUrl;

@property (strong, nonatomic) NSDictionary *profile;

- (void) displayProfile;

@end
