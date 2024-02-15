import 'package:flutter/material.dart';
import 'package:kmbased/main.dart';
import 'package:kmbased/services/nfc.dart';
import 'package:nfc_manager/nfc_manager.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
          print('second page to');
          _tagId = "tag.data: $tagId";
          print('tagid: $_tagId');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Text('tag id: $_tagId'),
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Text('back'))
      ])),
    );
  }
}
