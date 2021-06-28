import 'package:currency_converter/controllers/home.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late HomeController _controller;

  @override
  void initState() {
    this._controller = new HomeController(context, this);
    this._controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
        actions: [
          IconButton(
            onPressed: this._controller.addRateBtn,
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: buildBody,
      // floatingActionButton: buildFAB // Build the FAB for debugging purposes
    );
  }

  get buildBody {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextField,
            Divider(),
            Container(
              height: height * 4/5,
              child: buildRatesList,
            )
          ],
        ),
      ),
    );
  }

  get buildTextField => TextField(
    controller: this._controller.textController,
    onChanged: (s) => this._controller.calculate(),
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: "Ex: \$500 of any currency"
    ),
  );

  get buildRatesList => ListView.builder(
    itemCount: this._controller.allRates.length,
    itemBuilder: (c,i) {
      final rate = this._controller.allRates[i];
      final rateChange = this._controller.values[i];
      return ListTile(
        onLongPress: () => this._controller.deleteRateBtn(rate),
        leading: Text(rate.fromFlag),
        title: Text(rateChange),
        trailing: Text(rate.toFlag),
      );
    }
  );

  get buildFAB => FloatingActionButton(
    onPressed: () {
      showCurrencyPicker(
        context: context,
        showCurrencyName: false,
        onSelect: (Currency currency) {
          // this._controller.addRate(currency);
        }
      );
    }
  );
}