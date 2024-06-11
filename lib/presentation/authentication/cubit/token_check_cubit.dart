import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/core/utils/env.dart';
import 'package:hello/utils/share_preference.dart';

class TokenCheckCubit extends Cubit<bool> {
  TokenCheckCubit() : super(false);

  checkHasToken() async {
    String? accessToken =
        await SharePreference.instance.getString(Env.accessToken);
    if (accessToken != null) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
