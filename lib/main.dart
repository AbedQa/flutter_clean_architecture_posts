import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts/core/app_theme.dart';
import 'package:flutter_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/add_update_delete_posts.dart/add_update_delete_posts_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (context) => di.sl<AddUpdateDeletePostsBloc>()),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const PostPage(),
      ),
    );
  }
}
