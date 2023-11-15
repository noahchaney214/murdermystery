import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'timeProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: const MaterialApp(
        home: Profile(),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});



  @override
  Widget build(BuildContext context) {
    var timerProvider = Provider.of<TimerProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Murder Mystery'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/scroll.jpg'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: <Widget>[
            const RoundTimerWidget(),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)
                ),
                onPressed: timerProvider.timerRunning == false ? timerProvider.startTimer : null,
                child: const Text('Start Timer'),
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)
                ),
                onPressed: timerProvider.timerRunning == true ? timerProvider.pauseTimer : null,
                child: const Text('Pause Timer'),
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)
                ),
                onPressed: timerProvider.cancelTimer,
                child: const Text('Cancel Timer'),
              ),
            ),
          ],
        ),
      ),
      drawer: const HamburgerMenu(),
    );
  }
}

class RoundTimerWidget extends StatelessWidget {
  const RoundTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var timerProvider = Provider.of<TimerProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Round ${timerProvider.roundNumber}'),
              ClockWidget(countdownSeconds: timerProvider.totalTimeInSeconds - timerProvider.elapsedTimeInSeconds),
            ],
          ),
        ),
        LinearProgressIndicator(
          value: timerProvider.elapsedTimeInSeconds / timerProvider.totalTimeInSeconds,
        ),
      ],
    );
  }
}


class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              // Adjust the height of the container
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Handle option 1
              },
            ),
            ListTile(
              title: const Text('Inventory'),
              onTap: () {
                // Handle option 2
              },
            ),
            ListTile(
              title: const Text('Tasks'),
              onTap: () {
                // Handle option 3
              },
            ),
            ListTile(
              title: const Text('Guess'),
              onTap: () {
                // Handle option 4
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Handle option 5
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  final int countdownSeconds;

  const ClockWidget({Key? key, required this.countdownSeconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int minutes = countdownSeconds ~/ 60;
    int seconds = countdownSeconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return Text('$minutesStr:$secondsStr');
  }
}
