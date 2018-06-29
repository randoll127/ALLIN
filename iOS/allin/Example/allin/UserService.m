#import "UserService.h"
#import <allin/ALNetworkMacro.h>


@implementation UserService
@EXPORT_API(getVersion_v_os_version_){
    BEGIN
    @ReturnType(Call)
    @RequestType(JSON)
    @ResponseClass(UserModel)
    @Method(GET)
    @Path(mres/{v})
    @ParameterKey(v)
    @ParameterKey(os)
    @ParameterKey(version)
    @Timeout(3000)
    END
}

@EXPORT_API(getV_os_version_){
    BEGIN
    @ReturnType(Call)
    @RequestType(JSON)
    @ResponseClass(UserModel)
    @Method(GET)
    @Path(mres/v)
    @ParameterKey(v)
    @ParameterKey(os)
    @ParameterKey(version)
    @Timeout(3000)
    END
}

///mres/v?v=5.1.5.1&os=iOS&__=62353&params=%7B%7D&version=5.1.5.1

//@EXPORT_API(setUserInfo_name_){
//    BEGIN
//    @ReturnType(OrtroCall)
//    @Method(POST)
//    @Path(user/setuserinfo)
//    @ParameterName(phoneNO)
//    @ParameterName(name)
//    END
//}



@end
