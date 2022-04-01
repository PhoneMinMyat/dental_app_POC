class EventVO {
  final String patientName;
  final String startTime;
  final String endTime;
  final bool isEnable;
  final bool isLastDisable;
  EventVO({
    required this.patientName,
    required this.startTime,
    required this.endTime,
    required this.isEnable,
    required this.isLastDisable,
  });

}
