#import "AppUtils.h"

#import "AFHTTPRequestOperationManager.h"
#import "CutomAFJSONResponseSerializer.h"

@implementation AppUtils

- (AppUtils *)init;
{
    _useMyTW = FALSE;
    return [super init];
}

- (AFHTTPRequestOperationManager *) configureOpManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[CutomAFJSONResponseSerializer serializer]];
    
    if (_useMyTW) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"username" password:@"password"];
        
    } else {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"username" password:@"password"];
    }
    
    return manager;
}

- (NSString *) getUrl:(NSString *) resource
{
    if (_useMyTW) {        
        return [@"https://my.thoughtworks.com/api/core/v3/" stringByAppendingString:resource];
        
    } else {        
        return [@"https://thoughtworks-prince.jiveon.com/api/core/v3/" stringByAppendingString:resource];
    }
}

@end
