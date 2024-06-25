String buildLcdNumber(String number) {
  List<int> list1 = [0, 0, 0, 0];
  var numbers = number.split('').toList();
  String result = '';
  int length = 3;
  for (int i = length; i >= 0; i--) {
    if (numbers.isNotEmpty) {
      list1[i] += int.parse(numbers.last);
      numbers.removeLast();
    }
  }
  for (var element in list1) {
    result += element.toString();
  }
  return result;
}
