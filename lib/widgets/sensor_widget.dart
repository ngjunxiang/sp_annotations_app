import 'package:flutter/material.dart';

import '../utilities/radio_options.dart';

class SensorWidget extends StatefulWidget {
  @override
  _SensorWidgetState createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  SensorOption _option = SensorOption.Geolocation;

  String getSensorOptionText(SensorOption sensorOption) {
    switch (sensorOption) {
      case SensorOption.Geolocation:
        return 'Geolocation';
        break;
      case SensorOption.GeolocationSensor:
        return 'Geolocation + Sensor';
        break;
      default:
        return 'Unknown';
    }
  }

  Widget _buildRadioListTile(SensorOption sensorOption) {
    return RadioListTile(
      title: Text(getSensorOptionText(sensorOption)),
      activeColor: Theme.of(context).primaryColor,
      value: sensorOption,
      groupValue: _option,
      onChanged: (SensorOption value) {
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
                    'Sensor',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
              Divider(),
              _buildRadioListTile(SensorOption.Geolocation),
              _buildRadioListTile(SensorOption.GeolocationSensor),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    print(_option);
                  },
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
