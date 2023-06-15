import 'package:app/view/app.dart';
import 'package:flutter/widgets.dart';
//just first push
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(await App.withDependency());
}
