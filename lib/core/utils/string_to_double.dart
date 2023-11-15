double resultOfProgress(String degree) {
  print(degree);
  List<String> parts = degree.toString().split('/');
  double numerator = double.parse(parts[0].trim());
  double denominator = double.parse(parts[1].trim());
  double result = numerator / denominator;
  print(result.toString());
  return result;
}
