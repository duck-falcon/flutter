import 'package:flutter/material.dart';
import 'pages/list_page.dart';
import 'pages/home.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'pages/task_create.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final taskNotifier = TasksNotifier();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TasksNotifier>(create: (context) => taskNotifier),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/list': (context) => const ListPage(),
        '/task_create': (context) => const TaskCreate(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  // ボトムメニューの遷移先画面, 上から0,1,...
  final _pages = [
    const Home(title: 'Flutter Demo Home Page'),
    const ListPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return LoginPage();

    return Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages));
  }
}
