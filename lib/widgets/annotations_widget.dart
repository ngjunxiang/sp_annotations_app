import 'package:flutter/material.dart';

import '../utilities/radio_options.dart';

class AnnotationsWidget extends StatefulWidget {
  @override
  _AnnotationsWidgetState createState() => _AnnotationsWidgetState();
}

class _AnnotationsWidgetState extends State<AnnotationsWidget> {
  RecordOption _option;
  List<String> annotations = const [
    'Empty',
    'Empty',
    'Empty',
    'Empty',
    'Empty',
    'Empty',
  ];

  String getRecordOptionText(RecordOption recordOption) {
    switch (recordOption) {
      case RecordOption.PhysicallyImpaired:
        return 'Physically Impaired';
        break;
      case RecordOption.VisuallyImpaired:
        return 'Visually Impaired';
        break;
      case RecordOption.WheelchairBound:
        return 'Wheelchair Bound';
        break;
      default:
        return 'Unknown';
    }
  }

  Widget _buildRadioListTile(RecordOption recordOption) {
    return RadioListTile(
      title: Text(getRecordOptionText(recordOption)),
      activeColor: Theme.of(context).primaryColor,
      value: recordOption,
      groupValue: _option,
      onChanged: (RecordOption value) {
        setState(() {
          _option = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
          elevation: 3.0,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text(
                    'Annotation',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
              Divider(),
              _buildRadioListTile(RecordOption.PhysicallyImpaired),
              _buildRadioListTile(RecordOption.VisuallyImpaired),
              _buildRadioListTile(RecordOption.WheelchairBound),
              Divider(),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  children: annotations
                      .map((value) => Card(
                            child: Center(
                              child: Text(value),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
