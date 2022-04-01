import 'package:dental_app/models/vos/event_vo.dart';
import 'package:dental_app/models/vos/schedule_vo.dart';

final List<String> demoTimeList = [
  '8:00',
  '8:30',
  '9:00',
  '9:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '1:00',
  '1:30'
];


final List<EventVO> demoEventList = [
  EventVO(
      patientName: 'John Lawrence',
      startTime: '8:00 AM',
      endTime: '8:50 AM',
      isEnable: false,
      isLastDisable: false),
  EventVO(
      patientName: 'Nellie Lawrence',
      startTime: '9:00 AM',
      endTime: '9:40 AM',
      isEnable: false,
      isLastDisable: true),
  EventVO(
      patientName: 'John Elliott',
      startTime: '10:00 AM',
      endTime: '10:50 AM',
      isEnable: true,
      isLastDisable: false),
  EventVO(
      patientName: 'Issac Alexander',
      startTime: '11:00 AM',
      endTime: '11:50 AM',
      isEnable: true,
      isLastDisable: false),
  EventVO(
      patientName: 'Francisco Clayton',
      startTime: '12:00 AM',
      endTime: '12:40 AM',
      isEnable: true,
      isLastDisable: false),
  EventVO(
      patientName: 'John Wick',
      startTime: '1:00 AM',
      endTime: '1:50 AM',
      isEnable: true,
      isLastDisable: false),
];

List<ScheduleVO> demoScheduleList = [
  ScheduleVO(
      office: 'Office No. 248',
      numberOfPatients: 3,
      startTime: '8:30 AM',
      endTime: '2:00 PM',
      isSelect: true),
  ScheduleVO(
      office: 'Office No. 249',
      numberOfPatients: 4,
      startTime: '8:30 AM',
      endTime: '2:00 PM',
      isSelect: false),
  ScheduleVO(
      office: 'Office No. 250',
      numberOfPatients: 2,
      startTime: '8:30 AM',
      endTime: '2:00 PM',
      isSelect: false),
  ScheduleVO(
      office: 'Office No. 261',
      numberOfPatients: 2,
      startTime: '8:30 AM',
      endTime: '2:00 PM',
      isSelect: false),
];
