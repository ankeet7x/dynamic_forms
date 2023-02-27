import 'package:dynamic_form_handling/api_caller.dart';
import 'package:dynamic_form_handling/form_handler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FormController> formData = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  fetchFormList() async {
    List<dynamic> listOfForms = await getFormList();
    for (var form in listOfForms) {
      formData.add(
        FormController(
          textEditingController: TextEditingController(),
          labelText: form['label'],
          required: form['required'],
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchFormList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic form"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: formData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      FormController formController = formData[index];
                      return TextFormField(
                        controller: formController.textEditingController,
                        validator: formController.required
                            ? (String? val) {
                                if (val != null && val.isNotEmpty) {
                                  return null;
                                }
                                return "Required";
                              }
                            : null,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: formController.labelText,
                        ),
                      );
                    },
                  ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> data = {};
                  for (var item in formData) {
                    if (item.textEditingController.text.isNotEmpty) {
                      data.addAll({
                        item.labelText: item.textEditingController.text,
                      });
                    }
                  }
                  print(data);
                }
              },
              child: const Text(
                "Click here",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
