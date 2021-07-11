import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NetworthPage.dart';
import 'NumberInputDialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xff222747),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.grey.shade800,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 56, vertical: 16)
            ),
          ),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        cardColor: Color(0xff444968)
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var assetAmount = 0;
  var liabilitiesAmount = 0;

  void setAssetAmount(int asset){
    setState(() {
      assetAmount = asset;
    });
  }

  void setLiabilitiesAmount(int liabilities){
    setState(() {
      liabilitiesAmount = liabilities;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 48),
                Text(
                  'Add your assets and liabilities',
                      style: theme.textTheme.headline5,
                ),
                SizedBox(height: 102),
                AmountCard(
                  title: 'Assets',
                  amount: assetAmount,
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return NumberInputDialog(
                        onTap: setAssetAmount,
                        title: 'Assets',
                        amount: assetAmount,
                        );
                    },
                  ),
                ),
                SizedBox(height: 16),
                AmountCard(
                  title: 'Liabilities',
                  amount: liabilitiesAmount,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return NumberInputDialog(
                        onTap: setLiabilitiesAmount,
                        title: 'Liabilities',
                        amount: liabilitiesAmount,
                      );
                    },
                  ),
                ),
                SizedBox(height: 102),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NetworthPage(amount: assetAmount - liabilitiesAmount),
                        fullscreenDialog: true,
                      ),
                    ),
                    child: Text(
                      'Calculate',
                      style: theme.textTheme.button!.copyWith(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class AmountCard extends StatelessWidget {
  const AmountCard({
    Key? key,
    required this.title,
    required this.amount,
    this.onTap,
}) : super(key: key);

  final String title;
  final int amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      height: 148,
      width: size.width * 0.8,
      child:Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 4),
              Text(amount.toString(), style: Theme.of(context).textTheme.headline6),

            ],
          ),
        ),
      ),
    );
  }
}

