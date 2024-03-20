import 'package:flutter/material.dart';
import 'package:social_crossplatform/features/live_stream/utils.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveStreamScreen extends StatelessWidget {
  final String liveId, userId;
  final bool isHost;

  LiveStreamScreen({
    required this.liveId,
    required this.userId,
    required this.isHost,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: Utils.appId,
        appSign: Utils.appSignIn,
        userID: userId,
        userName: "FanZone_$userId",
        liveID: liveId,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
          ..audioVideoViewConfig.showAvatarInAudioMode = true
          ..audioVideoViewConfig.showSoundWavesInAudioMode = true,
      ),
    );
  }
}
