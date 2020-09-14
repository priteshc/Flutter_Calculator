import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculator',
    home: Mycalculator(),
    theme: ThemeData(
        primaryColor: Colors.indigo, accentColor: Colors.indigoAccent),
  ));
}

class Mycalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return statecal();
  }
}

class statecal extends State<Mycalculator> {
  final minpadd = 5.0;
  var currency = ['None', 'Dollar', 'Rupees', 'other'];
  var current = 'Rupees';
  var myresult = '';
  var formkey = GlobalKey<FormState>();

  TextEditingController principle = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();

  @override
  void initState() {
    super.initState();
    current = currency[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculator1'),
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.all(minpadd * 2),
            child: ListView(
              children: [
                imageasset(),
                Padding(
                    padding: EdgeInsets.only(top: minpadd, bottom: minpadd),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: principle,
                      validator: (value) => value.isEmpty?'please enter priciple amount':null,
                      decoration: InputDecoration(
                          labelText: 'Principle',
                          hintText: 'Enter Principle eg.2000',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: minpadd, bottom: minpadd),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: roi,
                      validator: (value) => value.isEmpty?'please enter ROI':null,
                      decoration: InputDecoration(
                          labelText: 'Rate of Interst',
                          hintText: 'In percent',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: minpadd, bottom: minpadd),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: term,
                              validator: (value) => value.isEmpty?'please enter Tearm':null,
                              decoration: InputDecoration(
                              labelText: 'Tearm',
                              hintText: 'Tearm In year',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: minpadd * 5,
                        ),
                        Expanded(
                            child: DropdownButtonFormField(
                          items: currency
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) => setState(() {
                            this.current = value;
                          }),
                              validator: (value) => value =='None'?'please select':null,
                          value: current,
                        )),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: minpadd, bottom: minpadd),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                color: Colors.deepOrange,
                                textColor: Colors.white,
                                child: Text('Calculate'),
                                onPressed: () => setState(() {
                                     if(formkey.currentState.validate()) {
                                       this.myresult = calculate();
                                     }
                                }))),
                        Container(
                          width: minpadd * 5,
                        ),
                        Expanded(
                            child: RaisedButton(
                                color: Colors.amber,
                                textColor: Colors.white,
                                child: Text('Reset'),
                                onPressed: () => setState(() {
                                      reseatall();
                                    }))),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(minpadd * 2), child: Text(myresult))
              ],
            ),
          ),
        ));
  }

  Widget imageasset() {
    AssetImage image = AssetImage('images/currency.png');
    Image image1 = Image(
      image: image,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image1,
      margin: EdgeInsets.all(minpadd * 10),
    );
  }

  String calculate() {
    double princ = double.parse(principle.text);
    double ratei = double.parse(roi.text);
    double terms = double.parse(term.text);

    double total = princ + (princ * ratei * terms) / 100;
    String result =
        'After $terms years,youe invest will be $total amount $current';

    return result;
  }

  void reseatall() {
    principle.text = '';
    roi.text = '';
    term.text = '';
    current = currency[0];
    myresult = '';
  }
}
