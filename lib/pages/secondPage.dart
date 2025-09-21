import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

class SecondPage extends StatelessWidget {
  // final DatabaseReference _database = FirebaseDatabase.instance.ref();
  //
  // Future<Map<String, dynamic>?> getSchema(String day) async {
  //   final snapshot = await _database.child('Alice').child(day).get();
  //   if (snapshot.exists) {
  //     return Map<String, dynamic>.from(snapshot.value as Map);
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schema'),
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
              child: Text('Hämta schema för Tisdag'),
            ),

            SizedBox(height: 30),

            // FutureBuilder для отображения асинхронных данных
            // FutureBuilder<Map<String, dynamic>?>(
            //   future: getSchema('Tisdag'),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (snapshot.hasData && snapshot.data != null) {
            //       final data = snapshot.data!;
            //       // Отображаем данные в удобном формате
            //       return Column(
            //         children: [
            //           Text('Schema för Tisdag:',
            //               style: TextStyle(fontWeight: FontWeight.bold)),
            //           SizedBox(height: 10),
            //           // Пример отображения данных
            //           Text('Data: ${data.toString()}'),
            //           // Или более структурированно:
            //           // for (var entry in data.entries)
            //           //   Text('${entry.key}: ${entry.value}'),
            //         ],
            //       );
            //     } else {
            //       return Text('Inget schema hittades');
            //     }
            //   },
            // ),

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