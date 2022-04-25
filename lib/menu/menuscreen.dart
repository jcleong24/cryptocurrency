import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyCryptoApp(),
    );
  }
}

class MyCryptoApp extends StatefulWidget {
  MyCryptoApp({Key? key}) : super(key: key);

  @override
  State<MyCryptoApp> createState() => _MyCryptoAppState();
}

class _MyCryptoAppState extends State<MyCryptoApp> {
  TextEditingController convertEditingController = TextEditingController();
  var select_type = "btc",
      select_fiat = "usd",
      unit = "",
      name = "",
      type = "",
      description = "No data available",
      description1 = "No fiat available";

  double value = 0.0, output = 0.0, bitcoin = 0.0;

  List<String> crypto_type = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
  ];

  List<String> fiat_type = [
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 253, 253),
        appBar: AppBar(title: const Text("Cryp-Cur")),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: Image.asset('assets/images/bc.png', height: 100, width: 500),
              ),

              const Text("Bitcoin Converter",
                  style: TextStyle(
                      height: -0.5,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
              DropdownButton(
                itemHeight: 50,
                value: select_type,
                onChanged: (newValue) {
                  setState(() {
                    select_type = newValue.toString();
                  });
                },
                items: crypto_type.map((select_type) {
                  return DropdownMenuItem( 
                    child: Text(             
                      select_type,
                    ),
                    value: select_type,
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: _loadCrypto, child: const Text("See Value"),
                  style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 109, 113, 122)),
                  ),
              const SizedBox(height: 10,
              ),
                Text(description, style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
               ),
              //fiat currency converter
              DropdownButton(
                itemHeight: 50,
                value: select_fiat,
                onChanged: (newValue) {
                  setState(() {
                    select_fiat = newValue.toString();
                  });
                },
                items: fiat_type.map((select_fiat) {
                  return DropdownMenuItem(
                    child: Text(
                      select_fiat,
                    ),
                    value: select_fiat,
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: _loadFiat, child: const Text("Load Fiat"),
                  style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 106, 108, 121))
                  ),
              const SizedBox(height: 10),

               Text(description1, style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
               ),

              const SizedBox(height: 10),
              Container(
                  width: 150,
                  child: TextField(
                      controller: convertEditingController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: "Bitcoin Coverter",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ))),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: _converter, child: const Text("Convert"),
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  ),
              const SizedBox(height: 10),
              Text(
                "Total Value = $unit " + output.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          )),
        ));
  }

  Future<void> _loadCrypto() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData["rates"][select_type]["name"];
      value = parsedData['rates'][select_type]['value'];
      unit = parsedData['rates'][select_type]['unit'];
      type = parsedData['rates'][select_type]['type'];

      setState(() {
        description = "$name value is $value \nType: $type";
        progressDialog.dismiss();
      });
    }
  }

  Future<void> _loadFiat() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData["rates"][select_fiat]["name"];
      value = parsedData['rates'][select_fiat]['value'];
      unit = parsedData['rates'][select_fiat]['unit'];
      type = parsedData['rates'][select_fiat]['type'];

      setState(() {
        description1 = "$name $unit is $value \nType: $type";;
      });
      progressDialog.dismiss();
    }
  }

  void _converter() {
    bitcoin = double.parse(convertEditingController.text);
    setState(() {
      output = bitcoin * value;
    });
  }
}
