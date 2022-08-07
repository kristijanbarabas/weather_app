import 'dart:io';
// omogućava nam korištenje sleep() metode kojom ćemo simulirati čekanje da se zadatak završi

void main() {
  performTasks();
}

// dodamo async modifier
void performTasks() async {
  task1();
  String task2Result = await task2();
  // task 3 sada čeka da se izvrši task2 jer su mu potrebni podaci iz task2, jer kada bi se odmah izvršio vratio bi null
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

// task2 treba 3 sekunde da završi i dok on ne završi task3 se neće pokrenuti jer je glavna funkcija perfromTasks sinkronizirana i sve se odvija po reduž
// future je isto kao promises u JS-u
Future<String> task2() async {
  // simulacija trajanja funkcije
  Duration threeSeconds = Duration(seconds: 3);
  late String result;
// sleep je sync funkcija
  // sleep(threeSeconds);
  // simulacija async delaya - funkcija delayed ima dva argumenta, jedan je Duration pa tu stavimo threeSeconds a druga je callback funkcija koja će nešto napraviti; delayed je async metoda jer vraća future (sve metode koje vraćaju future su asyn)
  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2Data');
}
