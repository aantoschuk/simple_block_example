// создаем два события
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColorEvent { event_red, event_green }

class ColorBloc {
  Color _color = Colors.red;

  // Контроллер моделирует поток данных
  // добавляет и отправляет события в stream
  final _inputEventController = StreamController<ColorEvent>();
  // Входной поток, пользователь добавляет событие в sink
  // через него передаем события в bloc
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  // Контроллер типа Color
  final _outpusStateController = StreamController<Color>();
  // Выходной поток
  Stream<Color> get outputStateStream => _outpusStateController.stream;

  // Функция для конвертации event в state
  // принимает событие
  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.event_red)
      _color = Colors.red;
    else if (event == ColorEvent.event_green)
      _color = Colors.green;
    else
      throw Exception('Wrong Event Type');

    // добавляет в выходной поток и передаем состояние
    _outpusStateController.sink.add(_color);
  }

  // подписываемся на события
  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  // Закрываем потоки
  void dispose() {
    _inputEventController.close();
    _outpusStateController.close();
  }
}
