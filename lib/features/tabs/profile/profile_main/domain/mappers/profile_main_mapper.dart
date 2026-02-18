import '../../../../../../core/constants/app_text_constants.dart';
import '../../data/models/user_data_response_dto.dart';
import '../../data/models/user_dto.dart';
import '../entities/user_data_response.dart';
import '../entities/user_entity.dart';

class ProfileMainMapper {
  ProfileMainMapper._();

  static UserEntity mapUserDtoToUserEntity(UserDto userDto) {
    /*
    this.id,                        -> For Navigate to Edit Profile
    this.firstName,                 -> For Display
    this.email,                     -> For Display
    this.imgAvatarURL               -> For Display
    * */
    return UserEntity(
      id: userDto.id ?? '',
      firstName: userDto.firstName ?? '',
      lastName: userDto.lastName ?? '',
      phoneNumber: userDto.phone ?? '',
      email: userDto.email ?? '',
      imgAvatarURL: userDto.photo ?? AppTextConstants.defaultAvatarUrl,
    );
  }

  static UserDataResponse mapUserDataResponseDtoToUserDataResponse(
    UserDataResponseDto userDataResponseDto,
  ) {
    return UserDataResponse(
      userDataResponseDto.message ?? '',
      mapUserDtoToUserEntity(userDataResponseDto.user ?? UserDto()),
    );
  }
}
