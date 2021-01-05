import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp((MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _currency = ['Rupees','Doller','Pound'];
  var valueByUser='Rupees';
  String result='';
  TextEditingController principle = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController time = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(

      appBar: AppBar(
        title: Text('Interest Calculator'),
        centerTitle: true,
      ),
      body: Form(
key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(

            children: <Widget>[
              Container(
                margin: EdgeInsets.all(50),
                child: Image(
                  image: AssetImage('images/money.png',),
                  width: 125,
                    height: 125,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (String value ){
                               if(value.isEmpty) {
                      return 'Please Enter Principal Amount';
                    }
                  },
                  controller: principle,
                  keyboardType: TextInputType.number,
                  style: textStyle,

                  decoration:InputDecoration(
                    labelText: 'Principle Amount',
                    labelStyle: textStyle,
                    hintText: 'Enter Principle Amount eg.200',
                    errorStyle: TextStyle(color: Colors.red,fontSize: 16),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (String value){
                    if(value.isEmpty){
                      // ignore: missing_return
                      return 'Please Enter Rate of intrest';
                    }
                  },
                  controller: roi,
                  keyboardType: TextInputType.number,
                  style: textStyle,

                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 16
                    ),
                    labelText: 'Rate of Interest',
                    labelStyle: textStyle,
                    hintText: 'Enter Rate of Interest in percent',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (String value){
                            if(value.isEmpty){
                              // ignore: missing_return
                              return 'Please Enter Time in years';
                            }
                          },
                          controller: time,
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16
                              ),
                              labelText: 'Time',
                              labelStyle: textStyle,
                              hintText: 'Enter time in year',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currency.map((String value ){
                          return DropdownMenuItem<String>(
                            child: Text(value,style: textStyle,),
                            value: value,
                          );
                        }).toList(),
                        value: valueByUser,
                        onChanged: (String newValueSelected){
                          setState(() {
                            valueByUser = newValueSelected;
                          });
                        },

                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Calculate',textScaleFactor: 1.5,),
                      onPressed: (){
                        setState(() {
                          if(formKey.currentState.validate()) {
                            double pamount = double.parse(principle.text);
                            double roiamount = double.parse(roi.text);
                            double tamount = double.parse(time.text);
                            double ans = pamount +
                                (pamount * roiamount * tamount) / 100;
                            result =
                            'After $tamount years, Your investment will be worth $ans  $valueByUser';
                          }});
                      },

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
               Expanded(child:   RaisedButton(
                 color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text('Reset',textScaleFactor: 1.5,),
                    onPressed: (){
                   setState(() {
                     principle.text='';
                     roi.text='';
                     time.text='';
                     valueByUser=_currency[0];
                     result='';
                   });
                    },
                  )),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(result,style: textStyle,),
              )

            ],
          ),
        ),
      ),
    );
  }
}
