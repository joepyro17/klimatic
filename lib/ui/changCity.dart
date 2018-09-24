import 'package:flutter/material.dart';

class ChangeCity extends StatelessWidget{
  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.yellowAccent,
        title: new Text('Change City', style: new TextStyle( color: Colors.black, fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/first_screen.jpeg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),

          new ListView(       
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'ກະລຸນາພິມຊື່ເມືອງ',
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                )
              ),

              new ListTile(
                title: new FlatButton(
                  onPressed: () {
                    Navigator.pop(context,{
                      'enter': _cityFieldController.text
                    });
                  },
                  textColor: Colors.black,
                  color: Colors.yellowAccent,
                  child: new Text('ກວດສອບ'),
                )
              )
            ]
          )

        ],
      )
    );
  }
}
