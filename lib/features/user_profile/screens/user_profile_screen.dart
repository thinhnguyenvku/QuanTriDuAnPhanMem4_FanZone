import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:social_crossplatform/core/common/post_card.dart';
import 'package:social_crossplatform/features/auth/controller/auth_controller.dart';
import 'package:social_crossplatform/features/user_profile/controller/user_profile_controller.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;

  const UserProfileScreen({
    super.key,
    required this.uid,
  });

  navigateToEditUserProfile(BuildContext context) {
    Routemaster.of(context).push('/edit-user-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userProvider)!;

    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            user.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 45,
                          ),
                        ),
                        ref.watch(getUserDataProvider(users.uid)).when(
                              data: (data) {
                                if (data.uid == uid) {
                                  return Container(
                                    alignment: Alignment.bottomLeft,
                                    padding: const EdgeInsets.all(20),
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          navigateToEditUserProfile(context),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                      ),
                                      child: const Text('Edit Profile'),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                              error: (error, stackTrace) =>
                                  ErrorText(error: error.toString()),
                              loading: () => const Loader(),
                            ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'u/${user.name}',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            '${user.karma} karma',
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 2),
                      ]),
                    ),
                  ),
                ];
              },
              body: ref.watch(getUserPostsProvider(uid)).when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final post = data[index];
                          return PostCard(post: post);
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return ErrorText(error: error.toString());
                    },
                    loading: () => const Loader(),
                  ),
            ),
            error: ((error, stackTrace) => ErrorText(error: error.toString())),
            loading: () => const Loader(),
          ),
    );
  }
}
