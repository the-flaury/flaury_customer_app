import 'package:flaury_mobile/app/config/appconfig.dart';
import 'package:flaury_mobile/app/util/app_colors.dart';
import 'package:flaury_mobile/main.dart';

Future<void> main() async {
  final devconfig =
      Appconfig(name: "production", satchcolor: AppColors.primary);
  maincommon(devconfig);
}
