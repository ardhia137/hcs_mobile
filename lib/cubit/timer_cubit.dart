import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(0);
  void timerStart() {
    int _start = 30;
    Timer? _timer;
    var oneSec = const Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
            timer.cancel();
        } else {
            _start--;
            emit(_start);
        }
      },
    );

  }
}
