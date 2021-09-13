import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

import 'burc_liste.dart';
import 'models/strings.dart';

// ignore: must_be_immutable
class BurcDetay extends StatefulWidget {
  int gelenIndex;
  BurcDetay(this.gelenIndex);

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color baskinRenk;
  PaletteGenerator paletteGenerator;
  @override
  void initState() {
    super.initState();
    secilenBurc = BurcListesi.tumBurclar[widget.gelenIndex];
    baskinRengiBul();
  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(
            AssetImage('images/' + secilenBurc.burcBuyukResim));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint('seçilen renk : ' + paletteGenerator.dominantColor.toString());
      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        primary: false,
        slivers: [
          SliverAppBar(
            pinned: true,
            primary: true,
            expandedHeight: 200,
            backgroundColor: baskinRenk != null ? baskinRenk : Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'images/' + secilenBurc.burcBuyukResim,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
              title: Text(secilenBurc.burcAdi + ' Burcu\'nun Özellileri'),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.pink[100],
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(4),
                  child: Text(
                    secilenBurc.burcDetayi,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
