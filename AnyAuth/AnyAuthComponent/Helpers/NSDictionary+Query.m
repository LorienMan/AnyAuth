#import "NSDictionary+Query.h"

static NSString *decodeQueryField(NSString *field)
{
    return CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)field, CFSTR("")));
}

@implementation NSDictionary (Query)

+ (NSDictionary *)dictionaryWithQuery:(NSString*)query
{
    NSMutableDictionary *values = [NSMutableDictionary new];
    for (NSString *kv in [query componentsSeparatedByString:@"&"]) {
        NSUInteger idx = [kv rangeOfString:@"="].location;
        if (NSNotFound == idx) continue;
        NSString *k = decodeQueryField([kv substringToIndex:idx]);
        NSString *v = decodeQueryField([kv substringFromIndex:idx+1]);
        [values setObject:v forKey:k];
    }
    return [values copy];
}

@end