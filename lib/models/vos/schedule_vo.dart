class ScheduleVO {
  final String office;
  final int numberOfPatients;
  final String startTime;
  final String endTime;
  final bool isSelect;

  ScheduleVO({
    required this.office,
    required this.numberOfPatients,
    required this.startTime,
    required this.endTime,
    required this.isSelect,
  });
}
