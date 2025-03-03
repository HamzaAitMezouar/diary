import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadAndCropImage {
  static uploadImage(String id) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 80,
        uiSettings: [],
      );

      if (croppedFile != null) {
        // bool isImageUploaded = await ProfileImageService(dio: Dio())
        //     .uploadProfileImage([croppedFile.path], id.toString(), name, type);
        // if (isImageUploaded != true) return null;
        // UserModel? user = await GenericApiService(dio: Dio())
        //     .fetchData(getUserUrl + id, {}, (p0) => UserModel.fromJson(p0));
        // if (user != null) {
        //   sharedPreferences.setString("user", userModelToJson(user));
        // }
        return croppedFile;
      }
    }
    return null;
  }
}
