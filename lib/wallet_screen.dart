import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(),
            Container(
              width: 355,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.wallet_outlined)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 288.0, top: 25, bottom: 25),
              child: Text(
                "Add Money",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // color: Colors.blueGrey,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('\$ 100')),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // color: Colors.blueGrey,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('\$ 1000')),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        //   color: Colors.blueGrey,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('\$ 2000')),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // color: Colors.blueGrey,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('\$ 5000')),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 255,
              child: MaterialButton(
                textColor: Colors.white,
                color: Colors.green.shade700,
                onPressed: () {},
                child: Text("Add Money"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
