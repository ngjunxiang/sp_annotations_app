import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_annotations_app/providers/geolocation_provider.dart';

import '../utilities/enums.dart';

class GroupWidget extends StatefulWidget {
  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> with WidgetsBindingObserver {
  var _isLoading = false;
  String _selectedGroup;
  List<String> _groupList;
  final _groupTextController = TextEditingController();
  GeolocationProvider geolocationProvider;

  @override
  initState() {
    super.initState();
    _groupList = ['Group 1', 'Group 2', 'Group 3', 'Others'];
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    if (appLifecycleState == AppLifecycleState.paused) {
      print('paused');
      geolocationProvider.stopRecordingGeolocation(true);
    }

    if (appLifecycleState == AppLifecycleState.resumed) {
      print('resumed');
      geolocationProvider.startRecordingGeolocation();
    }
  }

  Widget _buildDropdownMenu(MediaQueryData mediaQueryData) {
    return Container(
      width: mediaQueryData.size.width * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 42,
        underline: SizedBox(),
        hint: Text('Select Group'),
        // Not necessary for Option 1
        value: _selectedGroup,
        onChanged: (newValue) {
          setState(() {
            _selectedGroup = newValue;

            if (_selectedGroup != 'Others') {
              _groupTextController.clear();
            }
          });
        },
        items: _groupList.map((data) {
          return DropdownMenuItem<String>(
            child: Text(data),
            value: data,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGroupTextFormField(MediaQueryData mediaQueryData) {
    return Container(
      width: mediaQueryData.size.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Group Name',
        ),
        keyboardType: TextInputType.text,
        controller: _groupTextController,
        enabled: _selectedGroup == 'Others',
      ),
    );
  }

  Widget _buildStartStopButton(ScaffoldState scaffold) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: geolocationProvider.started
            ? () {
                geolocationProvider.stopRecordingGeolocation(false);
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Geolocation recording stopped!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            : () {
                geolocationProvider.startRecordingGeolocation();
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Geolocation recording started!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
        child: Text(
          geolocationProvider.started ? 'Stop' : 'Start',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  Widget _buildUploadButton(ScaffoldState scaffold) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: _isLoading ? null : () async {
          print(_isLoading);
          setState(() {
            _isLoading = true;
          });
          scaffold.showSnackBar(
            SnackBar(
              content: Text(
                'Uploading file now...',
                textAlign: TextAlign.center,
              ),
            ),
          );
          print(_isLoading);
          Future.delayed(Duration(seconds: 2)).then((_) {
            setState(() {
              _isLoading = false;
            });
            scaffold.showSnackBar(
              SnackBar(
                content: Text(
                  'File uploaded successfully!',
                  textAlign: TextAlign.center,
                ),
              ),
            );
            print(_isLoading);
          });
        },
        child: _isLoading
            ? Container(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(),
              )
            : Text(
                'Upload',
                style: Theme.of(context).textTheme.button,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scaffold = Scaffold.of(context);
    geolocationProvider = Provider.of<GeolocationProvider>(context);

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
                    'Group',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildDropdownMenu(mediaQuery),
                  _buildStartStopButton(scaffold),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildGroupTextFormField(mediaQuery),
                  _buildUploadButton(scaffold),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
