Future<List<dynamic>> getFormList() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    {
      "label": "username",
      "required": true,
    },
    {
      "label": "password",
      "required": false,
    },
  ];
}
