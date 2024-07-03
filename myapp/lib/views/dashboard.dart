import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:myapp/controllers/DashboardController.dart';
import 'package:myapp/widgets/StoryList.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Friendzy",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 39, 50, 56),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 254, 254),
              shape: const CircleBorder(
                side: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 192, 209, 218),
                ),
              ),
            ),
            onPressed: () {
              log("Notification press");
            },
            child: const Icon(
              Icons.notifications_none,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Gap(20),
          // Stories List
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.error.value.isNotEmpty) {
              return Center(child: Text('Error: ${controller.error.value}'));
            } else {
              return StoriesList(stories: controller.stories.value);
            }
          }),
          const Gap(20),
          // Custom TabBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 230, 255),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                labelColor: Colors.blueGrey,
                dividerColor: Colors.transparent,
                controller: controller.tabController, // Ensure controller is used
                unselectedLabelColor: Colors.blueGrey,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                padding: const EdgeInsets.all(5),
                labelStyle: const TextStyle(
                fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                tabs: const[
                   Tab(text: 'Make Friends'),
                  Tab(text: 'Search Partners'),
                ],
              ),
            ),
          ),
          const Gap(20),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: controller.tabController, // Ensure controller is used
              children: [
               Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.error.value.isNotEmpty) {
                    return Center(child: Text('Error: ${controller.error.value}'));
                  } else {
                    return ListView.builder(
                      itemCount: controller.posts.length,
                      itemBuilder: (context, index) {
                        var post = controller.posts[index];
                        log(post.toString());
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                          child:  Container(
                            height: Get.height * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(post['imageUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(post['title']),
                                  subtitle: Text(post['body']),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),],
            ),
          ),
        ],
      ),
    );
  }
}