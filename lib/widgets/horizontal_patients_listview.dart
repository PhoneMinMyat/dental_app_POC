import 'package:dental_app/models/vos/schedule_vo.dart';
import 'package:dental_app/resources/colors.dart';
import 'package:dental_app/resources/dimens.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class HorizontalPatientsListView extends StatelessWidget {
  final List<ScheduleVO> scheduleList;
  final Function onTap;
  final bool isHome;
  const HorizontalPatientsListView(
    this.onTap, {
    required this.isHome,
    required this.scheduleList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: SizedBox(
            height: (isHome)
                ? HOMEPAGE_SCHEDULE_ITEM_HEIGHT
                : DETAILS_PAGE_HORIZONTAL_LIST_HEIGHT,
            child: ListView.builder(
              itemCount: scheduleList.length,
              padding: const EdgeInsets.only(left: MARGIN_XLARGE),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => (isHome)
                  ? ScheduleListItemView(schedule: scheduleList[index])
                  : DetailsItem(
                      schedule: scheduleList[index],
                    ),
            ),
          ),
        ),
        Visibility(
          visible: !isHome,
          child: DotsIndicator(
            dotsCount: scheduleList.length,
            decorator: DotsDecorator(
              size: const Size(20, 5),
              activeSize: const Size(20, 5),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
    );
  }
}

class DetailsItem extends StatelessWidget {
  final ScheduleVO schedule;
  const DetailsItem({
    required this.schedule,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: HOMEPAGE_SCHEDULE_ITEM_WIDTH,
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2x),
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_XLARGE, vertical: MARGIN_MEDIUM_2x),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2x),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimeAndConfirmSectionView(schedule: schedule),
          const TreatmentSectionView(),
          const SizedBox(
            height: MARGIN_MEDIUM_2x,
          ),
          Row(
            children: const [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              Text('Arther Clayton')
            ],
          )
        ],
      ),
    );
  }
}

class TreatmentSectionView extends StatelessWidget {
  const TreatmentSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const[
         Text(
          'Teeth Drilling',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
         SizedBox(
          height: MARGIN_MEDIUM,
        ),
         Text(
          'Lorem Ipsum has been the industrys 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: TEXT_SMALL_2x, height: 1.3),
        ),
      ],
    );
  }
}

class TimeAndConfirmSectionView extends StatelessWidget {
  const TimeAndConfirmSectionView({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final ScheduleVO schedule;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: MARGIN_CARD_MEDIUM_2,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          '${schedule.startTime}-${schedule.endTime}',
          style: const TextStyle(fontSize: TEXT_SMALL_2x),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM, vertical: MARGIN_SMALL),
          color: Colors.lightGreenAccent,
          child: const Text(
            'Confirmed',
            style: TextStyle(color: Colors.blue, fontSize: TEXT_SMALL_2x),
          ),
        )
      ],
    );
  }
}

class ScheduleListItemView extends StatelessWidget {
  final ScheduleVO schedule;
  const ScheduleListItemView({
    required this.schedule,
    Key? key,
  }) : super(key: key);

  Color getBackGroundColor() {
    return (schedule.isSelect == true) ? MEDIUM_BLUE_COLOR : BUTTON_COLOR;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: HOMEPAGE_SCHEDULE_ITEM_WIDTH,
      //height: HOMEPAGE_SCHEDULE_ITEM_HEIGHT,
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2x),
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_XLARGE, vertical: MARGIN_MEDIUM_2x),
      decoration: BoxDecoration(
        //color: (schedule.isSelect == true) ? MEDIUM_BLUE_COLOR : BUTTON_COLOR,
        gradient: LinearGradient(
            colors: [LIGHT_BLUE_COLOR, getBackGroundColor()],
            stops: const [0.05, 0.05]),
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2x),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OfficeAndNumberOfPatientsView(
          office: schedule.office,
          numberOfPatients: schedule.numberOfPatients,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        ItemTimeView(schedule: schedule),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Row(children: [
          ...List.generate(
            schedule.numberOfPatients,
            (index) => Row(
              children: const [
                CircleAvatar(
                  maxRadius: MARGIN_MEDIUM_2x,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MARGIN_SMALL,
                )
              ],
            ),
          ),
          const Spacer(),
          Visibility(
              visible: schedule.isSelect,
              child: const CircleAvatar(
                backgroundColor: DARK_BLUE_COLOR,
                radius: MARGIN_MEDIUM_2x,
                child: Icon(Icons.check),
              ))
        ])
      ]),
    );
  }
}

class ItemTimeView extends StatelessWidget {
  const ItemTimeView({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final ScheduleVO schedule;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          color: Colors.white70,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          '${schedule.startTime} - ${schedule.endTime}',
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class OfficeAndNumberOfPatientsView extends StatelessWidget {
  const OfficeAndNumberOfPatientsView({
    Key? key,
    required this.numberOfPatients,
    required this.office,
  }) : super(key: key);

  final String office;
  final int numberOfPatients;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        children: [
          TextSpan(text: office),
          TextSpan(
              text: ' / $numberOfPatients patients',
              style: const TextStyle(
                  color: Colors.white60, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
