#import "AppConstants.h"
#import "InboxTableViewController.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "CutomAFJSONResponseSerializer.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Inbox";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_inbox"];
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
        url = @"https://my.thoughtworks.com/api/core/v3/inbox";
        
    } else {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sohamgh@thoughtworks.com" password:@"93=:Yrf4gTn29<3KPs7qp,a"];
        url = @"https://thoughtworks-prince.jiveon.com/api/core/v3/inbox";
    }    
    
    [manager GET:url parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id response) {
             self.messages = response[@"list"];
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
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.messages[indexPath.row][@"object"][@"displayName"];
    
    NSString *publishedDateStr = self.messages[indexPath.row][@"object"][@"published"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *publishedDate = [formatter dateFromString:publishedDateStr];
    
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *detail = [formatter stringFromDate:publishedDate];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Published on %@", detail];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
