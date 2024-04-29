import 'package:flutter/material.dart';
import 'package:kiosk_manager/models/daily_sales_model.dart';
import 'package:kiosk_manager/services/api_service.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DailySalesScreen extends StatefulWidget {
  const DailySalesScreen({super.key});

  @override
  State<DailySalesScreen> createState() => _DailySalesScreenState();
}

class _DailySalesScreenState extends State<DailySalesScreen> {
  Future<List<DailySalesModel>>? dailySalesFuture;
  List<String> dates = ['', ''];

  @override
  void initState() {
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    dates[0] = "${now.year}년 ${now.month}월 ${now.day}일";
    dates[1] = "${now.year}-$month-$day";
    dates[1] = "2023-08-16";

    dailySalesFuture = ApiService.getDailySales(dates[1]);
    super.initState();
  }

  void refreshScreen() {
    setState(() {
      dailySalesFuture = ApiService.getDailySales(dates[1]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailySalesModel>>(
      future: dailySalesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Column(
            children: [
              _buildHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: _buildDailySales(),
                  ),
                  Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data![index].name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data![index].count,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasData) {
          return Column(
            children: [
              _buildHeader(),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: _buildDailySales(),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  Flexible(
                    flex: 5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 3 / .4,
                        // mainAxisSpacing: 1.0,
                        // crossAxisSpacing: 1.0,
                      ),
                      //scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(
                                snapshot.data![index].name,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "|",
                                style: TextStyle(
                                  //decoration: TextDecoration.underline,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data![index].count,
                              style: const TextStyle(
                                //decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            // Container(
                            //   width: 150,
                            //   decoration: const BoxDecoration(
                            //     border: Border(
                            //       bottom: BorderSide(
                            //         color: Colors.black,
                            //         width: 2,
                            //       ),
                            //     ),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text(
                            //       snapshot.data![index].name,
                            //       style: const TextStyle(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: 30,
                            //   decoration: const BoxDecoration(
                            //     border: Border(
                            //       left: BorderSide(
                            //         color: Colors.black,
                            //         width: 2,
                            //       ),
                            //       bottom: BorderSide(
                            //         color: Colors.black,
                            //         width: 2,
                            //       ),
                            //     ),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text(
                            //       snapshot.data![index].count,
                            //       style: const TextStyle(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              _buildHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: _buildDailySales(),
                  ),
                  Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data![index].name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data![index].count,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.access_time_outlined,
            size: 42,
          ),
        ),
        Text(
          '일별 판매 내역',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildDailySales() {
    void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        dates[0] =
            "${args.value.year}년 ${args.value.month}월 ${args.value.day}일";
        dates[1] =
            "${args.value.year}-${args.value.month.toString().padLeft(2, '0')}-${args.value.day.toString().padLeft(2, '0')}";
      });
    }

    void requestDailySales() {
      refreshScreen();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 10.0,
            bottom: 10.0,
          ),
          child: Text(
            '날짜 검색',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: const Color(0xFF965E32),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    dates[0],
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF965E32),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    requestDailySales();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xBB965E32),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search_outlined,
                          size: 24,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SfDateRangePicker(
            onSelectionChanged: onSelectionChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: const Color(0xFF965E32),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 3,
                        bottom: 20,
                        left: 10,
                      ),
                      child: Text(
                        '일 별 판매 내역',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 15,
                      ),
                      child: Text(
                        '일 별 판매 내역',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 3,
                        bottom: 20,
                        right: 10,
                      ),
                      child: Text(
                        '판매 횟수',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                        bottom: 15,
                      ),
                      child: Text(
                        '판매 횟수',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
