import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../customWidgets/toast.dart';
import '../styles/app_colors.dart';
import 'app_loader.dart';

Center buttonLoader({Color? color, double? size}) {
  return Center(
    child: LoadingAnimationWidget.progressiveDots(
      color: color ?? Colors.white,
      size: size ?? 50,
    ),
  );
}

List<Color> bgColorGradient() {
  return [
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorPrimary,
    AppColors.colorWhite,
    AppColors.colorWhite,
    AppColors.colorWhite,
    AppColors.colorWhite,
  ];
}

/* Future<void> pickLocation(
  BuildContext context,
  TextEditingController textEditingController, {
  TextEditingController? lat,
  TextEditingController? long,
  TextEditingController? zipcode,
  TextEditingController? state,
  TextEditingController? city,
  TextEditingController? isoCode,
  TextEditingController? address1,
  TextEditingController? address2,
  TextEditingController? country,
}) async {
  try {
    final Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      // radius: 10000000000000,
      //  region: "in",
      context: context,
      apiKey: kGoogleApiKey,
      // language: 'fr',
      themeData: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
              iconTheme: const IconThemeData(color: AppColors.colorPrimary))),
      decoration: InputDecoration(
        counterText: '',
        hintText: 'Search place',
        hintStyle: AppTextStyles.textStylePoppinsRegular.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(7))),
      ),
      types: [],
      // hint: 'Search City',
      strictbounds:
          false, /* components: [Component(Component.country, 'fr')] */
    );
    // ignore: use_build_context_synchronously
    await displayPrediction(p, context, textEditingController,
        lat: lat,
        long: long,
        zipcode: zipcode,
        state: state,
        city: city,
        isoCode: isoCode,
        address1: address1,
        address2: address2,
        country: country);
  } on SocketException {
    print('message');
  }
}

Future<void> displayPrediction(
  Prediction? p,
  BuildContext context,
  TextEditingController textEditingController, {
  TextEditingController? lat,
  TextEditingController? long,
  TextEditingController? zipcode,
  TextEditingController? state,
  TextEditingController? city,
  TextEditingController? isoCode,
  TextEditingController? address1,
  TextEditingController? address2,
  TextEditingController? country,
}) async {
  if (p != null) {
    // get detail (lat/lng)
    try {
      textEditingController.text = p.description!;
      final GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      await places.getDetailsByPlaceId(p.placeId!).then((detail) {
        final latTemp = detail.result.geometry!.location.lat;
        final longTemp = detail.result.geometry!.location.lng;
        placemarkFromCoordinates(latTemp, longTemp).then((placemarks) {
          lat!.text = detail.result.geometry!.location.lat.toString();
          long!.text = detail.result.geometry!.location.lng.toString();
          city?.text = placemarks[0].locality ?? '';
          zipcode!.text = placemarks[0].postalCode!;
          state!.text = placemarks[0].administrativeArea!;
          isoCode!.text = placemarks[0].isoCountryCode!;
          address1!.text = placemarks[0].subLocality!;
          address2!.text = placemarks[0].locality!;
          country!.text = placemarks[0].country!;

          /* addressTextEditingController.text =
                    '${placemarks[0].subLocality!}, ${placemarks[0].thoroughfare!}'; */
        });
      });
    } on Exception {}
  }
} */

void dismissKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

void checkConnectivity() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      showToastMessage('Connected');
    }
  } on SocketException catch (_) {
    showToastMessage('No internet');
  }
}

Center loaderPrimaryColor() {
  return const Center(
    child: CircularProgressIndicator(
      color: AppColors.colorPrimary,
    ),
  );
}

Center loader() {
  return Center(
    child: LoadingAnimationWidget.progressiveDots(
      color: AppColors.colorWhite,
      size: 40,
    ),
  );
}

void openImagePickPopup(BuildContext context, VoidCallback onSelectPhoto,
    VoidCallback onSelectCamera) {
  final action = CupertinoTheme(
    data: const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(primaryColor: Color(0xFF0A84FF))),
    child: CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => onSelectPhoto.call(),
          child: const Text('Gallery'),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => onSelectCamera.call(),
          child: const Text('Camera'),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}

bool isURLValid(String url) {
  final RegExp urlRegex = RegExp(
    r'^(http(s)?:\/\/)?[^\s]+(\.[^\s]+)+$',
    caseSensitive: false,
  );
  return urlRegex.hasMatch(url);
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

// SocialPlatform getSocialPlatformEnumFromString(String platform) {
//   switch (platform) {
//     case 'Instagram':
//       return SocialPlatform.instagram;
//     case 'Facebook':
//       return SocialPlatform.facebook;
//     case 'Tiktok':
//       return SocialPlatform.tiktok;
//     case 'Twitter':
//       return SocialPlatform.twitter;
//     case 'Youtube':
//       return SocialPlatform.youtube;
//     default:
//       return SocialPlatform.none;
//   }
// }

// String getSocialPlatformIconFromString(String platform) {
//   switch (platform.toLowerCase()) {
//     case 'instagram':
//       return Assets.igWt;
//     case 'facebook':
//       return Assets.fbWt;
//     case 'tiktok':
//       return Assets.tiktokWt;
//     case 'twitter':
//       return Assets.twitterWt;
//     case 'youtube':
//       return Assets.ytWt;
//     default:
//       return Assets.fbWt;
//   }
// }

Widget initialLoder() {
  return const Center(
    child: AppLoader(
      color: AppColors.colorPrimary,
    ),
  );
}
