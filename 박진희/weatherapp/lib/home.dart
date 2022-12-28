import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'weather_model.dart';

class Post {
  final int temp; //현재 온도
  final int tempMin; //최저 온도
  final int tempMax; //최고 온도

  Post({
    // 생성자
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      temp: json['temp'],
      tempMin: json['tempMin'],
      tempMax: json['tempMax'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //var post = fetchPost(); // 화면이 build할 때마다 호출
    String cityName = "부천시"; // 지역
    int currTemp = 0; // 현재 온도
    int maxTemp = 0; // 최고
    int minTemp = -5; // 최저
    String time = "오후 2:00";
    String weather = "맑음";
    Size size = MediaQuery.of(context).size;
    //var brightness = MediaQuery.of(context).platformBrightness;
    //bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: weather == "맑음"
                ? Color.fromARGB(255, 88, 197, 248)
                : //Color.fromARGB(255, 106, 162, 240),
                Colors.black54,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.cloud,
                              color: Colors.blue,
                            ),
                            Align(
                              child: Text(
                                '오늘의 날씨', // 어플 이름
                                style: GoogleFonts.questrial(
                                  color: const Color(0xff1D1617),
                                  fontSize: size.height * 0.02,
                                ),
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.retweet, // 새로고침
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: Align(
                          child: Text(
                            cityName, // 지역 이름
                            style: GoogleFonts.questrial(
                              color: Colors.white,
                              fontSize: size.height * 0.06,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.005,
                        ),
                        child: Align(
                          child: Text(
                            time, // 시간
                            style: GoogleFonts.questrial(
                              color: Colors.black54,
                              fontSize: size.height * 0.025,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: Align(
                          child: Text(
                            '$currTemp˚C', // 현재 온도
                            style: GoogleFonts.questrial(
                              color: Colors.white,
                              //Color.fromARGB(31, 53, 50, 50),
                              // currTemp <= 0
                              //     ? Colors.blue
                              //     : currTemp > 0 && currTemp <= 15
                              //         ? Colors.indigo
                              //         : currTemp > 15 && currTemp < 30
                              //             ? Colors.deepPurple
                              //             : Colors.pink,
                              fontSize: size.height * 0.12,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.25),
                        // child: Divider( // 선
                        //   color: isDarkMode ? Colors.white : Colors.black,
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.005,
                        ),
                        child: Align(
                          child: Text(
                            weather, // 날씨
                            style: GoogleFonts.questrial(
                              color: Colors.black,
                              fontSize: size.height * 0.025,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          bottom: size.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$minTemp˚C', // 최저기온
                              style: GoogleFonts.questrial(
                                color: Colors.black,
                                fontSize: size.height * 0.025,
                                //letterSpacing: 1.0,
                              ),
                            ),
                            Text(
                              '/',
                              style: GoogleFonts.questrial(
                                color: Colors.grey,
                                fontSize: size.height * 0.03,
                                letterSpacing: 3.0,
                              ),
                            ),
                            Text(
                              '$maxTemp˚C', // 최고기온
                              style: GoogleFonts.questrial(
                                color: Colors.black,
                                fontSize: size.height * 0.025,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.02,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    left: size.width * 0.03,
                                  ),
                                  child: Text(
                                    '주간 날씨',
                                    style: GoogleFonts.questrial(
                                      color: Colors.black,
                                      fontSize: size.height * 0.023,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.width * 0.005),
                                child: Column(
                                  children: [
                                    // api 사용
                                    sevenDay(
                                      "12/19", // 날짜
                                      "맑음", // 날씨
                                      minTemp, //최저기온
                                      maxTemp, //최고기온
                                      size,
                                    ),
                                    sevenDay(
                                      "12/20",
                                      "흐림",
                                      -5,
                                      5,
                                      size,
                                    ),
                                    sevenDay(
                                      "12/21",
                                      "맑음",
                                      -2,
                                      7,
                                      size,
                                    ),
                                    sevenDay(
                                      "12/22",
                                      "맑음",
                                      3,
                                      10,
                                      size,
                                    ),
                                    sevenDay(
                                      "12/23",
                                      "흐림",
                                      5,
                                      12,
                                      size,
                                    ),
                                    sevenDay(
                                      "12/24",
                                      "맑음",
                                      4,
                                      7,
                                      size,
                                    ),
                                    sevenDay(
                                      "12/25",
                                      "맑음",
                                      -2,
                                      1,
                                      size,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sevenDay(String day, String weather, int minTemp, int maxTemp, size) {
    return Padding(
      padding: EdgeInsets.all(
        size.height * 0.005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Text(
                  day, // 날짜
                  style: GoogleFonts.questrial(
                    color: Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.25,
                  ),
                  child: Text(
                    weather, // 날씨
                    style: GoogleFonts.questrial(
                      color: Colors.black,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.15,
                  ),
                  child: Text(
                    '$minTemp˚C', // 최저기온
                    style: GoogleFonts.questrial(
                      color: Colors.black54,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Text(
                    '$maxTemp˚C', // 최고기온
                    style: GoogleFonts.questrial(
                      color: Colors.white,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=bucheon&appid=3f06009ef24b1d8ba85842527c0af434&units=metric'));

  if (response.statusCode == 200) {
    print('성공');
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('실패');
  }
}
