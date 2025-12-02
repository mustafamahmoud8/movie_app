import 'package:movies_app/core/utils/app_assets.dart';

class AvatarBottomSheetModel {
  final String avatarImage;
  bool isSelected;

  AvatarBottomSheetModel({required this.avatarImage, this.isSelected = false});

  static List<AvatarBottomSheetModel> avatarImages = [
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage1),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage2),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage3),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage4),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage5),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage6),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage7),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage8),
    AvatarBottomSheetModel(avatarImage: AppAssets.avatarImage9),
  ];
}
