import '../models/bitki_model.dart';
import '../models/toprak_model.dart';

/// Firestore yok / hata / Windows masaüstü gibi ortamlarda kullanılacak örnek veriler.
class YerelOrnekVeriler {
  YerelOrnekVeriler._();

  static const String _img = 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?auto=format&fit=crop&w=600&q=60';

  static final List<ToprakModel> topraklar = [
    ToprakModel(
      id: 'killi_toprak',
      ad: 'Killi Toprak',
      renk: 'Koyu kahverengi-kırmızımsı',
      phAralik: '6.5-7.5',
      suTutma: 'Yüksek',
      havalanma: 'Düşük',
      ozellikler:
          'Ağır yapılıdır, sıkışmaya eğilimlidir. Besin tutma kapasitesi yüksektir.',
      avantajlar: const ['Besin maddelerince zengin', 'Suyu uzun süre tutar'],
      dezavantajlar: const ['Sıkışma riski', 'Zayıf havalanma'],
      resimUrl:
          'https://images.unsplash.com/photo-1461354464878-ad92f492a5a0?auto=format&fit=crop&w=800&q=60',
    ),
    ToprakModel(
      id: 'kumlu_toprak',
      ad: 'Kumlu Toprak',
      renk: 'Açık kahverengi-sarımsı',
      phAralik: '5.5-7.0',
      suTutma: 'Düşük',
      havalanma: 'Yüksek',
      ozellikler:
          'Hafif yapılıdır, hızlı drenaj yapar. Su ve besin tutma kapasitesi düşüktür.',
      avantajlar: const ['İyi havalanır', 'Kolay işlenir'],
      dezavantajlar: const ['Hızlı kurur', 'Besin yıkanması'],
      resimUrl:
          'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=800&q=60',
    ),
    ToprakModel(
      id: 'tinli_toprak',
      ad: 'Tınlı Toprak',
      renk: 'Kahverengi',
      phAralik: '6.0-7.5',
      suTutma: 'Orta-Yüksek',
      havalanma: 'Orta',
      ozellikler:
          'Kum, silt ve kil dengelidir. Tarım için ideal toprak tiplerindendir.',
      avantajlar: const ['Verimlidir', 'Su-besin dengesi iyidir'],
      dezavantajlar: const ['Erozyona açık olabilir'],
      resimUrl:
          'https://images.unsplash.com/photo-1523413651479-597eb2da0ad6?auto=format&fit=crop&w=800&q=60',
    ),
    ToprakModel(
      id: 'kirecli_toprak',
      ad: 'Kireçli Toprak',
      renk: 'Açık kahverengi-grimsi',
      phAralik: '7.5-8.5',
      suTutma: 'Orta',
      havalanma: 'Orta',
      ozellikler:
          'Kireç oranı yüksektir, pH genelde alkalidir. Mikro besin alımı zorlaşabilir.',
      avantajlar: const ['Yapı stabilitesi iyi', 'Drenaj genelde iyi'],
      dezavantajlar: const ['Demir/çinko noksanlığı riski', 'Yüksek pH'],
      resimUrl:
          'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=800&q=60',
    ),
  ];

  static final List<BitkiModel> bitkiler = [
    BitkiModel(
      id: 'domates',
      ad: 'Domates',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Orta-Yüksek',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Temmuz-Eylül',
      resimUrl: _img,
      bakimIpuclari: const ['Düzenli sulama', 'Destek gerekir'],
    ),
    BitkiModel(
      id: 'bugday',
      ad: 'Buğday',
      kategori: 'tahil',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.5',
      suIhtiyaci: 'Orta',
      ekimZamani: 'Ekim-Kasım',
      hasatZamani: 'Haziran-Temmuz',
      resimUrl: _img,
      bakimIpuclari: const ['Azot dengesi', 'Hasat zamanlaması'],
    ),
    BitkiModel(
      id: 'misir',
      ad: 'Mısır',
      kategori: 'tahil',
      uygunTopraklar: const ['tinli_toprak', 'killi_toprak'],
      phIhtiyaci: '5.8-7.0',
      suIhtiyaci: 'Yüksek',
      ekimZamani: 'Nisan-Mayıs',
      hasatZamani: 'Eylül-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Sıra arası', 'Besin ihtiyacı yüksek'],
    ),
    BitkiModel(
      id: 'pamuk',
      ad: 'Pamuk',
      kategori: 'tahil',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '5.8-8.0',
      suIhtiyaci: 'Orta-Yüksek',
      ekimZamani: 'Nisan-Mayıs',
      hasatZamani: 'Eylül-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Sıcak iklim', 'Haşarat takibi'],
    ),
    BitkiModel(
      id: 'karpuz',
      ad: 'Karpuz',
      kategori: 'meyve',
      uygunTopraklar: const ['kumlu_toprak', 'tinli_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Yüksek',
      ekimZamani: 'Nisan-Mayıs',
      hasatZamani: 'Temmuz-Eylül',
      resimUrl: _img,
      bakimIpuclari: const ['Geniş alan', 'Düzenli sulama'],
    ),
    BitkiModel(
      id: 'kavun',
      ad: 'Kavun',
      kategori: 'meyve',
      uygunTopraklar: const ['kumlu_toprak', 'tinli_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Yüksek',
      ekimZamani: 'Nisan-Mayıs',
      hasatZamani: 'Temmuz-Ağustos',
      resimUrl: _img,
      bakimIpuclari: const ['Sıcak ortam', 'Mantar hastalıklarına dikkat'],
    ),
    BitkiModel(
      id: 'havuc',
      ad: 'Havuç',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Orta',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Haziran-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Derin toprak', 'İnceltme'],
    ),
    BitkiModel(
      id: 'patates',
      ad: 'Patates',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '5.0-6.5',
      suIhtiyaci: 'Orta',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Haziran-Eylül',
      resimUrl: _img,
      bakimIpuclari: const ['Toprak işleme', 'Çürüklük kontrolü'],
    ),
    BitkiModel(
      id: 'sogan',
      ad: 'Soğan',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Orta',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Temmuz-Eylül',
      resimUrl: _img,
      bakimIpuclari: const ['Kuru hasat', 'Nem dengesi'],
    ),
    BitkiModel(
      id: 'salatalik',
      ad: 'Salatalık',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Yüksek',
      ekimZamani: 'Nisan-Mayıs',
      hasatZamani: 'Haziran-Eylül',
      resimUrl: _img,
      bakimIpuclari: const ['Tırmanma desteği', 'Düzenli sulama'],
    ),
    BitkiModel(
      id: 'biber',
      ad: 'Biber',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Orta-Yüksek',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Temmuz-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Sıcak ortam', 'Güneş'],
    ),
    BitkiModel(
      id: 'patlican',
      ad: 'Patlıcan',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'killi_toprak'],
      phIhtiyaci: '5.5-7.0',
      suIhtiyaci: 'Orta-Yüksek',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Temmuz-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Destek', 'Haşarat takibi'],
    ),
    BitkiModel(
      id: 'marul',
      ad: 'Marul',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Orta-Yüksek',
      ekimZamani: 'Mart-Mayıs',
      hasatZamani: 'Mayıs-Temmuz',
      resimUrl: _img,
      bakimIpuclari: const ['Hızlı büyüme', 'Gölge koruması'],
    ),
    BitkiModel(
      id: 'lahana',
      ad: 'Lahana',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'killi_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Yüksek',
      ekimZamani: 'Mart-Nisan',
      hasatZamani: 'Haziran-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Düzenli sulama', 'Kelebek zararlıları'],
    ),
    BitkiModel(
      id: 'elma',
      ad: 'Elma',
      kategori: 'agac',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0-7.0',
      suIhtiyaci: 'Orta',
      ekimZamani: 'Sonbahar / İlkbahar',
      hasatZamani: 'Eylül-Ekim',
      resimUrl: _img,
      bakimIpuclari: const ['Budama', 'Hastalık kontrolü'],
    ),
    BitkiModel(
      id: 'zeytin',
      ad: 'Zeytin',
      kategori: 'agac',
      uygunTopraklar: const ['kirecli_toprak', 'tinli_toprak'],
      phIhtiyaci: '6.0-8.0',
      suIhtiyaci: 'Düşük-Orta',
      ekimZamani: 'İlkbahar',
      hasatZamani: 'Kasım-Aralık',
      resimUrl: _img,
      bakimIpuclari: const ['Kuraklığa dayanıklı', 'Budama'],
    ),
  ];

  static ToprakModel? toprakById(String id) {
    try {
      return topraklar.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<BitkiModel> bitkilerByToprak(String toprakId) {
    return bitkiler
        .where((b) => b.uygunTopraklar.contains(toprakId))
        .toList();
  }
}
