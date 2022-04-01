import 'package:dental_app/canvas/vertical_line_painter.dart';
import 'package:dental_app/models/vos/event_vo.dart';
import 'package:dental_app/models/vos/schedule_vo.dart';
import 'package:dental_app/resources/colors.dart';
import 'package:dental_app/resources/demo_data.dart';
import 'package:dental_app/resources/dimens.dart';
import 'package:dental_app/resources/strings.dart';
import 'package:dental_app/screens/details_page.dart';
import 'package:dental_app/widgets/horizontal_patients_listview.dart';
import 'package:dental_app/widgets/smart_listview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndexForNavBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GREY_COLOR,
        body: Column(
          children: [
            const ProfileAndServiceView(),
            TimeAndEventListSectionView(
              timeList: demoTimeList,
              eventList: demoEventList,
            )
          ],
        ),
        floatingActionButton: Container(
          width: MARGIN_XXLARGE + MARGIN_LARGE,
          padding: const EdgeInsets.all(MARGIN_MEDIUM_2x),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: LIGHT_GREY_COLOR,
                  offset: Offset(0.0, 1),
                  blurRadius: 5.0,
                  spreadRadius: 2.0)
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomAppBar());
  }
}

class TimeAndEventListSectionView extends StatelessWidget {
  final List<String> timeList;
  final List<EventVO> eventList;

  const TimeAndEventListSectionView({
    required this.timeList,
    required this.eventList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartListView(
      () {
        print('start');
      },
      () {
        print('end');
      },
      itemCount: (eventList.isEmpty) ? 0 : 1,
      builder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: HOMEPAGE_TIMELIST_WIDTH,
            child: TimeList(timeList: timeList),
          ),
          Expanded(
            child: EventList(eventList: eventList),
          )
        ],
      ),
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({
    Key? key,
    required this.eventList,
  }) : super(key: key);

  final List<EventVO> eventList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0),
        itemCount: eventList.length + 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(
              height: HOMEPAGE_TIME_ITEM_HEIGHT,
              child: Row(
                children: const [
                  VerticalLinePainter(height: HOMEPAGE_TIME_ITEM_HEIGHT),
                  Text(
                    'Events',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            );
          } else {
            return EventItem(
              event: eventList[index - 1],
            );
          }
        });
  }
}

class EventItem extends StatelessWidget {
  const EventItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  final EventVO event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: HOMEPAGE_EVENT_ITEM_HEIGHT,
          child: Row(
            children: [
              VerticalLinePainter(
                height: HOMEPAGE_EVENT_ITEM_HEIGHT,
                isDashedLine: !event.isEnable,
                isBlueDotShow: event.isLastDisable,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (event.isEnable) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DetailsPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  height: double.infinity,
                  margin: const EdgeInsets.only(
                      bottom: MARGIN_SMALL,
                      top: MARGIN_SMALL,
                      left: MARGIN_MEDIUM,
                      right: MARGIN_LARGE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2x)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_MEDIUM_2x, vertical: MARGIN_MEDIUM_2x),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: GREY_COLOR,
                        child: Icon(
                          Icons.health_and_safety,
                          color: DARK_BLUE_COLOR,
                        ),
                      ),
                      const SizedBox(
                        width: MARGIN_MEDIUM_2x,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.patientName,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time),
                              const SizedBox(
                                width: MARGIN_MEDIUM,
                              ),
                              Text(
                                '${event.startTime} - ${event.endTime}',
                                style: const TextStyle(
                                    fontSize: TEXT_SMALL_2x,
                                    color: LIGHT_GREY_COLOR),
                              )
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
        Visibility(
          visible: !event.isEnable,
          child: Container(
            height: HOMEPAGE_EVENT_ITEM_HEIGHT,
            color: Colors.black12,
          ),
        )
      ],
    );
  }
}

class TimeList extends StatelessWidget {
  const TimeList({
    Key? key,
    required this.timeList,
  }) : super(key: key);

  final List<String> timeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 0),
      shrinkWrap: true,
      itemCount: timeList.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(
            height: HOMEPAGE_TIME_ITEM_HEIGHT,
            child: Center(
              child: Text(
                'Time',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: MARGIN_SMALL),
            height: HOMEPAGE_TIME_ITEM_HEIGHT,
            child: Center(
              child: Text(
                timeList[index - 1],
                style: const TextStyle(color: LIGHT_GREY_COLOR),
              ),
            ),
          );
        }
      },
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: GREY_COLOR,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.date_range,
              color: MEDIUM_BLUE_COLOR,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.access_time,
              color: GREY_COLOR,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.people,
              color: GREY_COLOR,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileAndServiceView extends StatelessWidget {
  const ProfileAndServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GREY_COLOR,
      height: HOMEPAGE_BACKGROUND_TOP_HEIGHT,
      child: Stack(
        children: [
          //Blue
          Container(
            width: double.infinity,
            height: HOMEPAGE_BACKGROUND_BLUE_HEIGHT,
            decoration: const BoxDecoration(color: DARK_BLUE_COLOR),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
                child: SearchAndProfileView(),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
                child: MyPatientsSectionView(),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              HorizontalPatientsListView(
                () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DetailsPage()));
                },
                isHome: true,
                scheduleList: demoScheduleList,
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyPatientsSectionView extends StatelessWidget {
  const MyPatientsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        MyPatientsView(),
        ChoseDateButtonView(),
      ],
    );
  }
}

class ChoseDateButtonView extends StatefulWidget {
  const ChoseDateButtonView({
    Key? key,
  }) : super(key: key);

  @override
  State<ChoseDateButtonView> createState() => _ChoseButtonViewState();
}

class _ChoseButtonViewState extends State<ChoseDateButtonView> {
  List<String> dateList = List.generate(7, (index) => index).map((number) {
    DateTime tempDate = DateTime.now().add(Duration(days: number));
    String formattedDate = DateFormat('dd-MM').format(tempDate);
    return formattedDate;
  }).toList();

  String selectedDate = DateFormat('dd-MM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HOMEPAGE_BUTTON_HEIGHT,
      width: HOMEPAGE_BUTTON_WIDTH,
      padding:
          const EdgeInsets.only(left: MARGIN_MEDIUM_2x, right: MARGIN_MEDIUM),
      decoration: BoxDecoration(
          color: BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_SMALL)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDate,
          onChanged: (val) {
            setState(() {
              selectedDate = val!;
            });
          },
          items: dateList.map<DropdownMenuItem<String>>((date) {
            return DropdownMenuItem(
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text((date == dateList[0]) ? 'Today' : date)),
              value: date,
            );
          }).toList(),
          dropdownColor: BUTTON_COLOR,
          isExpanded: true,
          style: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(MARGIN_LARGE),
          iconEnabledColor: Colors.white,
          // icon: Icon(Icons.down),
        ),
      ),
    );
  }
}

class MyPatientsView extends StatelessWidget {
  const MyPatientsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          MY_PATIENTS,
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2x,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          '12 total',
          style: TextStyle(color: Colors.white, fontSize: TEXT_SMALL_2x),
        ),
      ],
    );
  }
}

class SearchAndProfileView extends StatelessWidget {
  const SearchAndProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              left: MARGIN_MEDIUM_2x,
            ),
            height: MARGIN_XXLARGE,
            decoration: BoxDecoration(
              color: BUTTON_COLOR,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: SEARCH,
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    size: MARGIN_LARGE,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2x,
        ),
        SizedBox(
          width: MARGIN_XXLARGE,
          height: MARGIN_XXLARGE,
          child: Stack(
            children: [
              const Positioned.fill(
                child: CircleAvatar(
                  radius: MARGIN_XXLARGE / 2,
                  child: Icon(Icons.person),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: MARGIN_MEDIUM_2x,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                          color: Colors.white, fontSize: TEXT_SMALL_2x),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
