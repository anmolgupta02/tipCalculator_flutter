import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String tip;
  final localController = TextEditingController();
  final selectorList = [true, false, false];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Tip Calculator"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please Enter Total Amount"),
              SizedBox(
                width: 70,
                child: TextField(
                  controller: localController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "₹100.0",
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  maxLength: 5,
                  maxLengthEnforced: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ToggleButtons(children: [
                Text("10%"),
                Text("15%"),
                Text("20%"),
              ],
                  isSelected: selectorList,
              onPressed: onPressedSelection,),
              SizedBox(
                height: 20,
              ),

              if(tip!=null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text("Here's what you need to pay for your tip: ₹$tip",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              SizedBox(height: 20,),
              FlatButton(onPressed: calculateTip,
                  child: Text("Click here To Calculate Tip"),
              color: Colors.blue[900],
              textColor: Colors.white,
              height: 40,
              ),

            ],
          ),
        ),
      ),
    );
  }
  void onPressedSelection(int index){
    setState(() {
      for(int i=0; i<selectorList.length; i++){
        if(i==index){
          selectorList[i]=true;
        }else{
          selectorList[i]=false;
        }
      }
    });
  }

  void calculateTip(){
    if(!checkNullInput()){
      print("entered Calculation");
      final total_amount = double.parse(localController.text);
      final tipSelector = selectorList.indexWhere((element) => element);
      final tipPercentage = [0.1, 0.15, 0.2][tipSelector];

      final calculatedTip = (total_amount*tipPercentage).toStringAsFixed(2);
      print(calculatedTip);
      setState(() {
        tip = calculatedTip.toString();

      });

    }else{

      print("Skipped Calculation");
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Enter in the field")));
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please Enter Something!")));
    }

  }

  bool checkNullInput() {
    String inputtedAmount = localController.text;
    if(inputtedAmount==''){
      print("Text Empty");
      return true;
    }else{
      print("Text not empty");
      return false;
    }

  }
}

