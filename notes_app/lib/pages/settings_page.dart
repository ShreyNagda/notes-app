import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              // border: const Border.fromBorderSide(
              //   BorderSide(color: Colors.grey, width: 1.5,),
              // ),
            ),
            padding: const EdgeInsets.all(2),
            height: 40.h,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  changeColor(Colors.primaries[index].shade400);
                },
                child: Card(
                  color: Colors.primaries[index].shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.primaries[index].shade400,
                      width: 2,
                    ),
                  ),
                ),
              ),
              itemCount: Colors.primaries.length,
            ),
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    DynamicColorTheme.of(context).setColor(color: color, shouldSave: true);
  }
}
