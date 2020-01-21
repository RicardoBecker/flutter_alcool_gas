import 'package:alcool_ou_gasolina/widgets/logo.widget.dart';
import 'package:alcool_ou_gasolina/widgets/submit-form.dart';
import 'package:alcool_ou_gasolina/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePageAndroid extends StatefulWidget {
  @override
  _HomePageAndroidState createState() => _HomePageAndroidState();
}

class _HomePageAndroidState extends State<HomePageAndroid> {
  Color _color = Colors.lightGreen;
  var _gasCrtl = MoneyMaskedTextController();
  var _alcCrtl = MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(
            milliseconds: 1200,
          ),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              _completed
                  ? Success(
                      result: _resultText,
                      reset: reset,
                    )
                  : SubmitForm(
                      gasCtrl: _gasCrtl,
                      alcCtrl: _alcCrtl,
                      submitFunc: calcular,
                      busy: _busy,
                    ),
            ],
          ),
        ));
  }

  Future calcular() {
    if (_alcCrtl.text != "0,00" && _gasCrtl.text != "0,00") {
      double alc =
          double.parse(_alcCrtl.text.replaceAll(new RegExp(r'[,.]'), "")) / 100;
      double gas =
          double.parse(_gasCrtl.text.replaceAll(new RegExp(r'[,.]'), "")) / 100;
      double res = alc / gas;

      setState(() {
        _color = Colors.deepOrange[200];
        _completed = false;
        _busy = false;
      });

      return new Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (res >= 0.7) {
            _resultText = "Melhor usar Gasolina!";
          } else {
            _resultText = "Vai no Álcool queridão!";
          }
          _completed = true;
          _busy = false;
        });
      });
    }
  }

  reset() {
    setState(() {
      _color = Colors.blue[200];
      _completed = false;
      _busy = false;
      _gasCrtl = new MoneyMaskedTextController();
      _alcCrtl = new MoneyMaskedTextController();
    });
  }
}
