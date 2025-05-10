import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:myeg_flutter_test/modules/product_listing/ui/pages/product_listing_page.dart';
import 'package:path_provider/path_provider.dart';

import 'modules/product_listing/bloc/product_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storageDir = await getApplicationSupportDirectory();

  try {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory("${storageDir.path}/flutter_test"),
    );
  } catch (e) {
    debugPrint('Error: Init Hydrated Storage Failed: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductCubit(),
          ),
        ],
        child: ProductListingPage(),
      ),
    );
  }
}
