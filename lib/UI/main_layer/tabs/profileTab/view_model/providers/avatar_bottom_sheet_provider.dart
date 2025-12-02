import 'package:flutter/material.dart';

import '../../../../../../core/models/avatar_bottom_sheet_model.dart';

class AvatarBottomSheetProvider extends ChangeNotifier {
  int? avatarId;
  int? selectedIndex;
  String? selectedAvatar;

  void selectAvatar(int index) {
    selectedIndex = index;
    selectedAvatar =
        AvatarBottomSheetModel.avatarImages[selectedIndex ?? 7].avatarImage;
    notifyListeners();
  }

  void initialAvatar({int? avatarId}) {
    selectedIndex = avatarId;
    selectedAvatar =
        AvatarBottomSheetModel.avatarImages[selectedIndex ?? 7].avatarImage;
    notifyListeners();
  }

  void changeAvatarId() {
    avatarId = selectedIndex;
  }
}
