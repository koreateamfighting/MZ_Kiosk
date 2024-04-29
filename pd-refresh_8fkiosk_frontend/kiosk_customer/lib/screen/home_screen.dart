import 'package:flutter/material.dart';
import 'menu_choice_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  //final Future<List<CafeMenuListModel>> cafeMenus = ApiService.getMenuInfo();



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home.jpg'),
          //fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Text(
                  'MZ 8F',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Cafeteria Bar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF411A1A),
                  ),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.01),
                    child: OutlinedButton(
                      onPressed: () {
                     
                                              
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuChoiceScreen(),
                          ),
                        );

                        // ignore: avoid_print
                        print('Move to Menu Choice Screen');
                        //MenuChoiceScreen;
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF251D1D),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Order in Cafe',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.17,
                            ),
                            child: Icon(
                              Icons.touch_app_outlined,
                              size: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
