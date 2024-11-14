// import 'package:base_project/add_habit_page.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'edit_habit_page.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   List<String> habits = [];
//   List<String> habitsDetails = [];

//   // 各習慣の7日間の状態を保持するリスト
//   List<List<bool>> habitsCheck = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHabit();
//   }

//   Future<void> _loadHabit() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? habitsJson = prefs.getString("habits");
//     String? habitsDetailsJson = prefs.getString("habitsDetails");

//     if ((habitsJson != null) && (habitsDetailsJson != null)) {
//       setState(() {
//         habits = List<String>.from(json.decode(habitsJson));
//         habitsDetails = List<String>.from(json.decode(habitsDetailsJson));

//         // 各習慣に対して7日間の初期状態（未完了）を設定
//         habitsCheck =
//             List.generate(habits.length, (_) => List.filled(7, false));
//       });
//     }
//   }

//   Future<void> _saveHabits() async {
//     var prefs = await SharedPreferences.getInstance();
//     await prefs.setString("habits", json.encode(habits));
//   }

//   Future<void> _deleteHabit(int index) async {
//     var prefs = await SharedPreferences.getInstance();

//     habits.removeAt(index);
//     habitsDetails.removeAt(index);
//     habitsCheck.removeAt(index);

//     await prefs.setString("habits", json.encode(habits));
//     await prefs.setString("habitsDetails", json.encode(habitsDetails));

//     setState(() {});
//   }

//   void _toggleCheck(int habitIndex, int dayIndex) {
//     setState(() {
//       habitsCheck[habitIndex][dayIndex] = !habitsCheck[habitIndex][dayIndex];
//     });
//   }

//   Future<void> _navigateToDetailPage(int habitIndex) async {
//     final updatedHabit = await Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => EditHabitPage(
//           habit: habits[habitIndex],
//         ),
//       ),
//     );

//     if (updatedHabit != null) {
//       setState(() {
//         habits[habitIndex] = updatedHabit;
//         _saveHabits(); // 保存
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [
//         IconButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               return AddHabitPage();
//             })).then((_) {
//               _loadHabit();
//             });
//           },
//           icon: const Icon(Icons.add),
//         )
//       ], backgroundColor: Colors.blue, title: const Text("Habit Tracker")),
//       body: Center(
//         child: ListView.builder(
//             itemCount: habits.length,
//             itemBuilder: (context, habitIndex) {
//               return GestureDetector(
//                 onTap: () {
//                   _navigateToDetailPage(habitIndex);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(8.0),
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 81, 225, 250),
//                       borderRadius: BorderRadius.circular(10.0)),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             habits[habitIndex],
//                             style: Theme.of(context).textTheme.headlineLarge,
//                           ),
//                           IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 _deleteHabit(habitIndex);
//                               }),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(7, (dayIndex) {
//                           return GestureDetector(
//                             onTap: () {
//                               _toggleCheck(habitIndex, dayIndex);
//                             },
//                             child: Container(
//                               width: 44,
//                               height: 32,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 2.0),
//                               decoration: BoxDecoration(
//                                 color: habitsCheck[habitIndex][dayIndex]
//                                     ? Colors.green
//                                     : Colors.grey,
//                                 shape: BoxShape.rectangle,
//                               ),
//                               child: habitsCheck[habitIndex][dayIndex]
//                                   ? const Icon(Icons.circle,
//                                       color: Colors.white, size: 16)
//                                   : null,
//                             ),
//                           );
//                         }),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }

import 'package:base_project/add_habit_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'edit_habit_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> habits = [];
  List<String> habitsDetails = [];

  // 各習慣の7日間の状態を保持するリスト
  List<List<bool>> habitsCheck = [];

  @override
  void initState() {
    super.initState();
    _loadHabit();
  }

  Future<void> _loadHabit() async {
    var prefs = await SharedPreferences.getInstance();
    String? habitsJson = prefs.getString("habits");
    String? habitsDetailsJson = prefs.getString("habitsDetails");

    if ((habitsJson != null) && (habitsDetailsJson != null)) {
      setState(() {
        habits = List<String>.from(json.decode(habitsJson));
        habitsDetails = List<String>.from(json.decode(habitsDetailsJson));

        // 各習慣に対して7日間の初期状態（未完了）を設定
        habitsCheck =
            List.generate(habits.length, (_) => List.filled(7, false));
      });
    }
  }

  Future<void> _saveHabits() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("habits", json.encode(habits));
    await prefs.setString("habitsDetails", json.encode(habitsDetails));
  }

  Future<void> _deleteHabit(int index) async {
    var prefs = await SharedPreferences.getInstance();

    habits.removeAt(index);
    habitsDetails.removeAt(index);
    habitsCheck.removeAt(index);

    await prefs.setString("habits", json.encode(habits));
    await prefs.setString("habitsDetails", json.encode(habitsDetails));

    setState(() {});
  }

  void _toggleCheck(int habitIndex, int dayIndex) {
    setState(() {
      habitsCheck[habitIndex][dayIndex] = !habitsCheck[habitIndex][dayIndex];
    });
  }

  Future<void> _navigateToDetailPage(int habitIndex) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditHabitPage(
          habit: habits[habitIndex],
          habitDetail: habitsDetails[habitIndex],
        ),
      ),
    );

    if (result != null) {
      setState(() {
        habits[habitIndex] = result['habit'];
        habitsDetails[habitIndex] = result['habitDetail'];
        _saveHabits(); // 保存
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddHabitPage();
            })).then((_) {
              _loadHabit();
            });
          },
          icon: const Icon(Icons.add),
        )
      ], backgroundColor: Colors.blue, title: const Text("Habit Tracker")),
      body: Center(
        child: ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, habitIndex) {
              return GestureDetector(
                onTap: () {
                  _navigateToDetailPage(habitIndex);
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 81, 225, 250),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            habits[habitIndex],
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteHabit(habitIndex);
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(7, (dayIndex) {
                          return GestureDetector(
                            onTap: () {
                              _toggleCheck(habitIndex, dayIndex);
                            },
                            child: Container(
                              width: 44,
                              height: 32,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                color: habitsCheck[habitIndex][dayIndex]
                                    ? Colors.green
                                    : Colors.grey,
                                shape: BoxShape.rectangle,
                              ),
                              child: habitsCheck[habitIndex][dayIndex]
                                  ? const Icon(Icons.circle,
                                      color: Colors.white, size: 16)
                                  : null,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
