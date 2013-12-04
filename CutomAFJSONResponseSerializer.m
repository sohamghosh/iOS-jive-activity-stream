#import "CutomAFJSONResponseSerializer.h"

@implementation CutomAFJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *regex = @"throw 'allowIllegalResourceCall is false.';";
    NSString *newDataStr = [dataStr stringByReplacingOccurrencesOfString:regex withString:@""];    

    NSData *newData = [newDataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    return ([super responseObjectForResponse:response data:newData error:error]);
}

@end
