import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // JSONを使用する為に追加

class AddHabitPage extends StatelessWidget {
  final TextEditingController _habitController = TextEditingController();
  final TextEditingController _habitDetailController = TextEditingController();

  AddHabitPage({super.key});

  Future<void> _saveHabit(BuildContext context) async {
    // SharedPreferences のインスタンスを取得
    var prefs = await SharedPreferences.getInstance();

    // 現在の習慣リストを首都k
    String? habitsJson = prefs.getString("habits");
    String? habitsDetailsJson = prefs.getString("habitsDetails");
    List<String> habits =
        habitsJson != null ? List<String>.from(json.decode(habitsJson)) : [];
    List<String> habitsDetails = habitsDetailsJson != null
        ? List<String>.from(json.decode(habitsDetailsJson))
        : [];

    // 新しい習慣をリストに追加
    habits.add(_habitController.text);
    habitsDetails.add(_habitDetailController.text);
    await prefs.setString("habits", json.encode(habits));
    await prefs.setString("habitsDetails", json.encode(habitsDetails));

    // (3)前の画面に戻る
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // 背景色を青に設定
          actions: [
            TextButton(
              onPressed: () {
                _saveHabit(context); // 保存と戻る処理
              },
              child: const Text('保存', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 習慣化したいこと(主題)テキスト
              const Text(
                ' 習慣化したいこと',
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
              // 余白
              const SizedBox(height: 8),
              // 主題　テキストフォーム
              TextField(
                controller: _habitController,
                decoration: const InputDecoration(
                  labelText: 'テキストを入力',
                  border: OutlineInputBorder(),
                ),
              ),

              // 習慣化したいこと(詳細)テキスト
              const Text(
                ' 詳細',
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
              // 余白
              const SizedBox(height: 8),
              // 詳細テキストボックス入力
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: _habitDetailController,
                  maxLines: 3, // 文字数に応じて行数を増やす
                  decoration: const InputDecoration(
                    labelText: 'テキストを入力',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
