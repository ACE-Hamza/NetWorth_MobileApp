import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworthPage extends StatefulWidget {
  const NetworthPage({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final amount;

  @override
  _NetworthPageState createState() => _NetworthPageState();
}

class _NetworthPageState extends State<NetworthPage> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  late final Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _animation = IntTween(begin: 0, end: widget.amount).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _animation,
              builder: (context, value, child) {
                return Text(
                  'Your total net worth is $value',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}