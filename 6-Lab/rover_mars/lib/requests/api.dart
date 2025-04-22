import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getNasaData() async {
  // Ссылка по моему 9-ому варианту перенаправляла на главную страницу Nasa
  // https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=70&api_key=tFJFa0xwFWaVrbEKGdukZOjSjdJpd6ChWoTdzunj
  // И не было проблем с Cors

  // Почему я выбрал perseverance? Потому что на нем прикреплена алюминиевая табличка в дань уважения медицинским работникам, смотрите википедию по этому роверу
  // А я в свою очередь на сменах в Space Station 14 отыграл уже 200 часов на медицинском отделе, мне это нравится, вульпа-пульпа на Главном враче - это имба
  // Вот Вам и лор ситуации, я на смену
  Uri url = Uri.parse(
    'https://api.nasa.gov/mars-photos/api/v1/rovers/perseverance/photos?sol=70&api_key=tFJFa0xwFWaVrbEKGdukZOjSjdJpd6ChWoTdzunj',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
