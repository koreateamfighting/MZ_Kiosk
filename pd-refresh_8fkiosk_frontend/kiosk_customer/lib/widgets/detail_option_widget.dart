import 'package:flutter/material.dart';
import 'package:kiosk_customer/models/detail_option_model.dart';

class DetailOption extends StatefulWidget {
  final DetailOptionModel option;

  const DetailOption({
    super.key,
    required this.option,
  });

  @override
  State<DetailOption> createState() => _DetailOptionState();
}

class _DetailOptionState extends State<DetailOption> {
  late String title;
  late List<CheckboxOptions> checkbox;

  @override
  void initState() {
    title = widget.option.title;
    checkbox = widget.option.options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF670808),
                Color(0xFF605252),
              ],
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              const Icon(
                Icons.check_box_outlined,
                color: Color(0xFFF67B08),
              ),
              Text(
                ' $title',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for (var i = 0; i < checkbox.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 12.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (checkbox[i].checked == false) {
                      for (var j = 0; j < checkbox.length; j++) {
                        checkbox[j].checked = false;
                      }
                      setState(() {
                        checkbox[i].checked = true;
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: checkbox[i].checked
                            ? const Color(0xFF965E32)
                            : const Color(0xFFF2E7DE),
                      ),
                    ),
                    width: 120,
                    height: 80,
                    child: Text(
                      checkbox[i].label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
