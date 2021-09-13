import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/models/strings.dart';
import 'package:flutter_burc_rehberi/utils/strings.dart';

class BurcListesi extends StatelessWidget {
  static List<Burc> tumBurclar;
  @override
  Widget build(BuildContext context) {
    tumBurclar = veriKaynagiHazirla();
    return Scaffold(
      appBar: AppBar(
        title: Text('Burç Rehberi'),
      ),
      body: listeyiHazirla(),
    );
  }

  List<Burc> veriKaynagiHazirla() {
    List<Burc> burclar = [];

    for (int i = 0; i < 12; i++) {
      String kucukResim = Strings.BURC_ADLARI[i].toLowerCase() +
          '${i + 1}.png'; // Koc -->  koc -> koc1 -> koc1.png
      String buyukResim = Strings.BURC_ADLARI[i].toLowerCase() +
          '_buyuk' +
          '${i + 1}.png'; // Koc--> koc -> koc_buyuk -> koc_buyuk1 -> koç_buyuk1.png
      Burc eklenecekBurc = Burc(
          Strings.BURC_ADLARI[i],
          Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i],
          kucukResim,
          buyukResim);
      burclar.add(eklenecekBurc);
    }
    return burclar;
  }

  Widget listeyiHazirla() {
    return ListView.builder(
      itemCount: tumBurclar.length,
      itemBuilder: (BuildContext context, int index) {
        return tekSatirBurc(context, index);
      },
    );
  }

  Widget tekSatirBurc(BuildContext context, int index) {
    Burc oanEklenenBurc = tumBurclar[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Card(
        elevation: 4,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/burcDetay/$index');
          },
          leading: Image.asset(
            'images/' + oanEklenenBurc.burcKucukResim,
          ),
          title: Text(
            oanEklenenBurc.burcAdi,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.pink),
          ),
          subtitle: Text(
            oanEklenenBurc.burcTarihi,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
