import 'package:logger/logger.dart';
import 'dart:math' as math;

const maxWidth = 120;

var logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
);

class LargeContentOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var msg in event.lines) {
      final lines = (msg.length / maxWidth).ceil();
      for (var i = 0; i < lines; ++i) {
        //(i >= 0 ? '║ ' : '') +
        // ignore: avoid_print
        print(msg.substring(i * maxWidth,
            math.min<int>(i * maxWidth + maxWidth, msg.length)));
      }
    }
  }
}