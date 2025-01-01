import 'package:flutter/material.dart';

const kAnimationDefaultDuration = Duration(milliseconds: 150);

class AppTextStyleConstants {
  static const heading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: 'EuclidCircularB',
    package: 'loggycian_flutter',
  );

  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'EuclidCircularB',
    package: 'loggycian_flutter',
  );

  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'EuclidCircularB',
    package: 'loggycian_flutter',
  );

  static const bodySemiBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'EuclidCircularB',
    package: 'loggycian_flutter',
  );

  static const bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'EuclidCircularB',
    package: 'loggycian_flutter',
  );
}

class AppStrings {
  // Button text
  static const copyAsCurl = 'Copy as cURL';
  static const remove = 'Remove';
  static const cancel = 'Cancel';
  static const select = 'Select';
  static const selectAll = 'Select all';
  static const unselectAll = 'Unselect all';

  // Titles
  static const networkLogs = 'Loggycian - Networking';
  static const headers = 'Headers';
  static const body = 'Body';
  static const request = 'Request';
  static const response = 'Response';

  // Info items
  static const queryParams = 'Query params';
  static const method = 'Method';
  static const statusCode = 'Status code';
  static const requestDateTime = 'Request date time';
  static const responseDateTime = 'Response date time';
  static const responseDuration = 'Response duration';

  // Search
  static const searchHint = 'Search requests';

  // Request status
  static const success = 'SUCCESS';
  static const error = 'ERROR';
  static const started = 'STARTED';
}

class AppColors {
  static const black = Color(0xFF000000);
  static const white = Colors.white;
  static const transparent = Colors.transparent;

  // Background colors
  static const surfaceDark = Color(0xff1A1A1A);
  static const surfaceDarker = Color(0xff1C1C1C);

  // Border colors
  static const borderDark = Color(0xff2D2D2D);

  // Status colors
  static const success = Color(0xff14CC6D);
  static const error = Color(0xffFB5F59);
  static const info = Color(0xff1B73E8);
  static const successLight = Color(0xff0FA457);

  // Search bar
  static const searchBarBg = Color(0xff252525);

  // Text colors
  static const textGrey = Colors.grey;
  static const textGreyLight =
      Color(0xFFD3D3D3); // equivalent to Colors.grey.shade300

  // Action colors
  static const actionSuccess = Color.fromARGB(255, 19, 231, 58);

  // Overlay colors
  static const overlayDark = Color(0x42000000); // equivalent to Colors.black26
}

class AppSpacing {
  // Border radius
  static const radius12 = 12.0;
  static const radius16 = 16.0;
  static const radius22 = 22.0;

  // Icon sizes
  static const iconSizeSmall = 16.0;
  static const iconSizeMedium = 18.0;

  // Toolbar heights
  static const toolbarHeight = 48.0;
  static const appBarHeight = 50.0;

  // Padding
  static const padding8 = 8.0;
  static const padding12 = 12.0;
  static const padding16 = 16.0;
  static const padding20 = 20.0;
}
