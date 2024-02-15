import 'package:flutter/material.dart';
import 'package:kmbased/pages/secondpage.dart';
import 'package:kmbased/services/nfc.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyNFCScanner(),
    );
  }
}

class MyNFCScanner extends StatefulWidget {
  @override
  _MyNFCScannerState createState() => _MyNFCScannerState();
}

class _MyNFCScannerState extends State<MyNFCScanner> {
  String _tagId = "";
  bool _isScanning = false;
  nfcBackend nfcbackend = nfcBackend();

  @override
  void initState() {
    super.initState();

    _initNFC();
  }

  Future<void> _initNFC() async {
    // Start continuous scanning
    print('init nfc');

    // Start Session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        print('${tag.data}');
        // Do something with an NfcTag instance.
        String tagId = nfcbackend.extractTagId(tag);
        setState(() {
          print('main to');
          _tagId = "tag.data: $tagId";
          print('tagid: $_tagId');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _initNFC();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('NFC Scanner'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Scanning Status: $_isScanning'),
              SizedBox(height: 20),
              Text(
                'Tag ID: $_tagId',
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  child: Text('next page'))
            ],
          ),
        ),
      ),
    );
  }
}
