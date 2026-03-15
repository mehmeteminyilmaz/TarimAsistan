class ToprakModel {
  final String id;
  final String ad;
  final String renk;
  final String phAralik;
  final String suTutma;
  final String havalanma;
  final String ozellikler;
  final List<String> avantajlar;
  final List<String> dezavantajlar;
  final String resimUrl;

  ToprakModel({
    required this.id,
    required this.ad,
    required this.renk,
    required this.phAralik,
    required this.suTutma,
    required this.havalanma,
    required this.ozellikler,
    required this.avantajlar,
    required this.dezavantajlar,
    required this.resimUrl,
  });

  factory ToprakModel.fromMap(String id, Map<String, dynamic> data) {
    return ToprakModel(
      id: id,
      ad: data['ad'] ?? '',
      renk: data['renk'] ?? '',
      phAralik: data['ph_aralik'] ?? '',
      suTutma: data['su_tutma'] ?? '',
      havalanma: data['havalanma'] ?? '',
      ozellikler: data['ozellikler'] ?? '',
      avantajlar: List<String>.from(data['avantajlar'] ?? const []),
      dezavantajlar: List<String>.from(data['dezavantajlar'] ?? const []),
      resimUrl: data['resim_url'] ?? '',
    );
  }
}

