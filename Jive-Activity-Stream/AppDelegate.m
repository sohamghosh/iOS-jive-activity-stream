#import "AppDelegate.h"
#import "ActivityTableViewController.h"
#import "InboxTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ActivityTableViewController *activityTableViewController = [[ActivityTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *activityNavController = [[UINavigationController alloc] initWithRootViewController:activityTableViewController];
    
    InboxTableViewController *inboxTableViewController = [[InboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *inboxNavController = [[UINavigationController alloc] initWithRootViewController:inboxTableViewController];
    
    UITabBarController *landingTabBarController = [[UITabBarController alloc] init];
    //landingTabBarController.tabBar.frame = CGRectMake(0, 0, 320, 70);
    [landingTabBarController setViewControllers:@[activityNavController, inboxNavController]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = landingTabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
