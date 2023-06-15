import 'dart:convert';


import 'dart:typed_data';

import 'package:app/model/record.dart';
import 'package:app/model/write_record.dart';
import 'package:app/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditExternalModel with ChangeNotifier {
  EditExternalModel(this._repo, this.old) {
    if (old == null) return;
    final record = ExternalRecord.fromNdef(old!.record);
    firstController.text = record.domain;
    lastController.text = record.type;
    emailController.text = record.dataString;
    // numController.text=record.number;
  }

  final Repository _repo;
  final WriteRecord? old;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  // final TextEditingController numController=TextEditingController();
  final TextEditingController emailController = TextEditingController();
  

  Future<Object> save() async {
    if (!formKey.currentState!.validate())
      throw('Form is invalid.');

    final record = ExternalRecord(
      domain: firstController.text,
      type: lastController.text,
      // number:numController.text,
      data: Uint8List.fromList(utf8.encode(emailController.text)),
      
    );

    return _repo.createOrUpdateWriteRecord(WriteRecord(
      id: old?.id,
      record: record.toNdef(),
    ));
  }
}

class EditExternalPage extends StatelessWidget {
  static Widget withDependency([WriteRecord? record]) => ChangeNotifierProvider<EditExternalModel>(
    create: (context) => EditExternalModel(Provider.of(context, listen: false), record),
    child: EditExternalPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Info'),
      ),
      body: Form(
        key: Provider.of<EditExternalModel>(context, listen: false).formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: Provider.of<EditExternalModel>(context, listen: false).firstController,
              decoration: InputDecoration(labelText: 'Name',  helperText: ''),
              keyboardType: TextInputType.text,
              validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: Provider.of<EditExternalModel>(context, listen: false).lastController,
              decoration: InputDecoration(labelText: 'Phone', helperText: ''),
              keyboardType: TextInputType.text,
              validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            ),
            SizedBox(height: 12),
            // TextFormField(
            //   controller: Provider.of<EditExternalModel>(context, listen: false).numController,
            //   decoration: InputDecoration(labelText: 'Phone', helperText: ''),
            //   keyboardType: TextInputType.number,
            //   validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            // ),
            // SizedBox(height: 12),
            TextFormField(
              controller: Provider.of<EditExternalModel>(context, listen: false).emailController,
              decoration: InputDecoration(labelText: 'Email', helperText: ''),
              keyboardType: TextInputType.text,
              validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () => Provider.of<EditExternalModel>(context, listen: false).save()
                .then((_) => Navigator.pop(context))
                .catchError((e) => print('=== $e ===')),
            ),
          ],
        ), 
     ),
);
}
}