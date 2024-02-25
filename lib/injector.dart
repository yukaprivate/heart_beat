import 'package:get_it/get_it.dart';
import 'package:heart_beat/presentation/scan/presenter/scan_screen_presenter.dart';

GetIt injector = GetIt.instance;

final locator = GetIt.I;
void setupLocator() {
  injector.registerLazySingleton<ScanScrennPresenter>(
    () => ScanScrennPresenter(),
  );
}
