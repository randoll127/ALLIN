#import <JSONModel/JSONModel.h>

@interface UserModel : JSONModel
@property(nonatomic) NSString* staticUrl;
@property(nonatomic) NSDictionary* module;
@property(nonatomic) NSDictionary<Optional>* module2;
@end
