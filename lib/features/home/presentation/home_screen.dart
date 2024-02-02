import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/presentation/injection/home_screen_injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/presentation/widgets/tech_updates_list_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final results = ref.watch(homeScreenUpdatesFutureProvider);

    return results.when(
        loading: () => const CircularProgressIndicator(),
        data: (response) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: const Text('Home Screen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          body: ListView.builder(
              itemCount: results.value?.success?.length,
              itemBuilder: (context, index){
                return TechUpdatesListItem(technologyPostsData: results.value?.success, index: index,);
              }),
        ),
        error: (Object e, _) => const Center(
          child: Text('please try after sometime'),
        ));
  }
}
