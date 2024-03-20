import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:social_crossplatform/responsive/responsive.dart';

class ExtensionsScreen extends StatelessWidget {
  const ExtensionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Extensions',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Responsive(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: [
            if (!kIsWeb)
              _buildExtensionCard(
                icon: Icons.live_tv,
                title: 'Live Stream',
                route: '/start-live-stream',
                context: context,
              ),
            _buildExtensionCard(
              icon: Icons.message_outlined,
              title: 'Chat Bot',
              route: '/chat-bot',
              context: context,
            ),
            _buildExtensionCard(
              icon: Icons.mic_outlined,
              title: 'Speech to Text',
              route: '/speech-to-text',
              context: context,
            ),
            if (!kIsWeb)
              _buildExtensionCard(
                icon: Icons.image_search,
                title: 'Image to Text',
                route: '/image-to-text',
                context: context,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionCard({
    required IconData icon,
    required String title,
    required String route,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Routemaster.of(context).push(route);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
