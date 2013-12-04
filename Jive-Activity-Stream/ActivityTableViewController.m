#import "AppConstants.h"
#import "ActivityTableViewController.h"
#import "ProfileViewController.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "CutomAFJSONResponseSerializer.h"

@interface ActivityTableViewController ()

@end

@implementation ActivityTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Activity";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_activity"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[CutomAFJSONResponseSerializer serializer]];
    
    NSString *url;
    
    if ([[[AppConstants alloc] init]useMyTW]) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sohamgh" password:@"Ywr#693>47f,q22g?:J>,uE"];
        url = @"https://my.thoughtworks.com/api/core/v3/activities";
    
    } else {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sohamgh@thoughtworks.com" password:@"93=:Yrf4gTn29<3KPs7qp,a"];
        url = @"https://thoughtworks-prince.jiveon.com/api/core/v3/activities";
    }
    
    [manager GET:url parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id response) {
             self.activities = response[@"list"];
             [self.tableView reloadData];
         }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error....\n%@", error);
         }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }    
    
    cell.textLabel.text = self.activities[indexPath.row][@"actor"][@"displayName"];
    cell.detailTextLabel.text = self.activities[indexPath.row][@"title"];
    
    NSString *imageUrl = self.activities[indexPath.row][@"actor"][@"image"][@"url"];
    NSString *placeholderImage = @"Default";

    NSLog(@"Image..... \n%@", imageUrl);    
    [cell.imageView setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeholderImage]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    profileViewController.profileUrl = self.activities[indexPath.row][@"actor"][@"id"];
    [self.navigationController pushViewController:profileViewController animated:YES];
}

@end
