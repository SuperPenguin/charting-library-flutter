import 'package:flutter/material.dart';
import 'package:chart/components/tvchart/tvchart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isOnChartTab = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _isOnChartTab = _tabController.index == 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final hideAppBar =
            _isOnChartTab && orientation == Orientation.landscape;

        return Scaffold(
          appBar: !hideAppBar
              ? AppBar(
                  brightness: Brightness.dark,
                  title: const Text('Chart Example'),
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Home'),
                      Tab(text: 'Chart Library'),
                    ],
                  ),
                )
              : null,
          body: Container(
            padding: EdgeInsets.only(
              top: !hideAppBar ? 0 : MediaQuery.of(context).padding.top,
            ),
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(
                  child: Text('Home Body'),
                ),
                TVChart(),
              ],
            ),
          ),
        );
      },
    );
  }
}
