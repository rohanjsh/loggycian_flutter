extension DurationExtension on Duration {
  String durationInSec() => '${inMilliseconds / 1000} s';
}
