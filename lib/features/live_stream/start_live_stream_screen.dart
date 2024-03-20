import 'dart:math';
import 'package:flutter/material.dart';
import 'package:social_crossplatform/features/live_stream/live_stream_screen.dart';

class StartLiveStreamScreen extends StatefulWidget {
  const StartLiveStreamScreen({super.key});

  @override
  State<StartLiveStreamScreen> createState() => _StartLiveStreamScreenState();
}

class _StartLiveStreamScreenState extends State<StartLiveStreamScreen> {
  final liveIdController = TextEditingController();
  final String userId = Random().nextInt(900000 + 100000).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Live'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("Your user Id: $userId"),
            const SizedBox(height: 30),
            TextFormField(
              controller: liveIdController,
              decoration: const InputDecoration(
                labelText: "Join or Star a Live by enter ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveStreamScreen(
                      liveId: liveIdController.text,
                      userId: userId,
                      isHost: true,
                    ),
                  ),
                );
              },
              child: const Text("Start Live"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveStreamScreen(
                      liveId: liveIdController.text,
                      userId: userId,
                      isHost: false,
                    ),
                  ),
                );
              },
              child: const Text("Join Live"),
            ),
          ],
        ),
      ),
    );
  }
}
