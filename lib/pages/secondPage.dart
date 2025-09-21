import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class SecondPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<String?> getSchema(DateTime dateTime) async {
    final day = DateFormat('EEEE').format(dateTime);
    final snapshot = await _database.child('Alice').child(day).get();

    if (snapshot.exists) {
      final value = snapshot.value;
      if (value is String) {
        return value;
      } else if (value is Map) {
        // Если вдруг это Map, преобразуем в строку
        return value.toString();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now(); // Исправлено: теперь это объект DateTime

    return Scaffold(
      appBar: AppBar(
        title: Text('Schema för ${DateFormat('EEEE').format(currentDate)}'), // Показываем день недели в заголовке
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Schema',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),

            // Кнопка для загрузки расписания
            ElevatedButton(
              onPressed: () {
                // Здесь можно обновить состояние если используем StatefulWidget
                // или использовать другую логику
              },
              child: Text('Hämta schema för ${DateFormat('EEEE').format(currentDate)}'),
            ),

            SizedBox(height: 30),

            FutureBuilder<String?>(
              future: getSchema(currentDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!;
                  // Отображаем данные в удобном формате
                  return Column(
                    children: [
                      Text('Schema för ${DateFormat('EEEE').format(currentDate)}:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      // Пример отображения данных
                      Text('Data: ${data.toString()}'),
                      // Или более структурированно:
                      // for (var entry in data.entries)
                      //   Text('${entry.key}: ${entry.value}'),
                    ],
                  );
                } else {
                  return Text('Inget schema hittades för ${DateFormat('EEEE').format(currentDate)}');
                }
              },
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tillbaka'),
            ),
          ],
        ),
      ),
    );
  }
}