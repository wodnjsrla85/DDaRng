import 'package:app/model/station.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Choice extends StatefulWidget {
  String select;
  final ValueChanged<String> onChanged;
  Choice({super.key, required this.select, required this.onChanged});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  List<String> choices = [];

  List<String> multipleSelected = [];

  void setSingleSelected(String? value) {
    if (value != null) {
      widget.select = value;
      widget.onChanged(value); // 👈 부모에게 알림
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getStation();
  }

  getStation() async {
    final stationBox = Hive.box<Station>('bycle');
    for (var station in stationBox.values) {
      choices.add(station.st_name);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: 220,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: const Color.fromARGB(255, 113, 113, 113), // 테두리 색상
              // 테두리 두께
            ),
            borderRadius: BorderRadius.circular(12), // 모서리 둥글기
          ),
          clipBehavior: Clip.antiAlias,
          child: PromptedChoice<String>.single(
            title: '정거장 선택',
            confirmation: true,
            value: widget.select,
            onChanged: setSingleSelected,
            itemCount: choices.length,
            itemBuilder: (state, i) {
              return RadioListTile(
                value: choices[i],
                groupValue: state.single,
                onChanged: (value) {
                  state.select(choices[i]);
                },
                title: ChoiceText(choices[i], highlight: state.search?.value),
              );
            },
            modalFooterBuilder: ChoiceModalFooter.create(
              mainAxisAlignment: MainAxisAlignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 7.0,
              ),
              children: [
                (state) {
                  return TextButton(
                    onPressed: () => state.closeModal(confirmed: false),
                    child: const Text('취소'),
                  );
                },
                (state) {
                  return SizedBox(width: 10);
                },
                (state) {
                  return TextButton(
                    onPressed: () => state.closeModal(confirmed: true),
                    child: const Text('확인'),
                  );
                },
              ],
            ),
            promptDelegate: ChoicePrompt.delegatePopupDialog(
              maxHeightFactor: .5,
              constraints: const BoxConstraints(maxWidth: 300),
            ),
            anchorBuilder: ChoiceAnchor.create(inline: true),
          ),
        ),
      ),
    );
  }
}
