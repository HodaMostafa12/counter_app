import 'dart:ffi';

import 'package:counter_app/apiApp/viewmodel/user_viewModel.dart';
import 'package:counter_app/base/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('calling getData');
      ref.read(userViewmodelProvider.notifier).getUserData();
    });
  }

  Widget build(BuildContext context) {
    final dashboard = ref.watch(userViewmodelProvider).data?.user ?? [];
    print('<<<<<<<<<<<<<<<<<<<<${dashboard.length}>>>>>>>>>>>>>>>>>>>>');
    return BaseScaffold(
        appBar: AppBar(
          title: Text("unit testing app"),
        ),
        viewModel: userViewmodelProvider,
        body: dashboard == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index >= dashboard.length) {
                        return SizedBox
                            .shrink(); // Safety check for index out of bounds
                      }
                      final user = dashboard[index];
                      return ListTile(
                        title: Text("${user.name}"),
                      );
                    },
                    itemCount: dashboard.length,
                  ))
                ],
              ));
  }
}
