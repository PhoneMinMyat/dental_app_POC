import 'package:dental_app/canvas/clock_painter.dart';
import 'package:dental_app/resources/colors.dart';
import 'package:dental_app/resources/demo_data.dart';
import 'package:dental_app/resources/dimens.dart';
import 'package:dental_app/widgets/horizontal_patients_listview.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MEDIUM_BLUE_COLOR,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Today',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: MARGIN_MEDIUM_2x,
          ),
          Icon(Icons.menu),
          SizedBox(
            width: MARGIN_MEDIUM_2x,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: double.infinity,
          // width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 0.4],
                  colors: [MEDIUM_BLUE_COLOR, DARK_BLUE_COLOR])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MARGIN_LARGE, vertical: MARGIN_MEDIUM_2x),
                child: OfficeAndPatientView(),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_2x,
              ),
              Center(
                child: SizedBox(
                  width: DETAILS_PAGE_CIRCULAR_CONTAINER_WIDTH,
                  height: DETAILS_PAGE_CIRCULAR_CONTAINER_HEIGHT,
                  child: Stack(
                    children: [
                      const Positioned.fill(child: ClockPainter()),
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 150,
                        child: Center(
                          child: MiddleTimeSectionView(),
                        ),
                      ),
                      Positioned(
                        left: 17,
                        top: 220,
                        child: Container(
                          width: MARGIN_XXLARGE,
                          height: MARGIN_XXLARGE,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MEDIUM_BLUE_COLOR,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.healing,
                            color: Colors.white,
                            size: MARGIN_MEDIUM_3x,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 150,
                        bottom: 0,
                        child: Container(
                          width: MARGIN_XXLARGE,
                          height: MARGIN_XXLARGE,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MEDIUM_BLUE_COLOR,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.local_hospital,
                            color: Colors.white,
                            size: MARGIN_MEDIUM_3x,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 65,
                        top: 30,
                        child: Container(
                          width: MARGIN_XXLARGE,
                          height: MARGIN_XXLARGE,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MEDIUM_BLUE_COLOR,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.health_and_safety,
                            color: Colors.white,
                            size: MARGIN_MEDIUM_3x,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_2x,
              ),
              HorizontalPatientsListView(() {},
                  isHome: false, scheduleList: demoScheduleList)
            ],
          ),
        ),
      ),
    );
  }
}

class MiddleTimeSectionView extends StatelessWidget {
  const MiddleTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          '2:45',
          style: TextStyle(color: Colors.white, fontSize: TEXT_BIG),
        ),
        Text(
          'pm',
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2x,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class OfficeAndPatientView extends StatelessWidget {
  const OfficeAndPatientView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Office No. 248',
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2x,
              fontWeight: FontWeight.w700),
        ),
        Text(
          '3 patients',
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_SMALL_2x,
          ),
        )
      ],
    );
  }
}
