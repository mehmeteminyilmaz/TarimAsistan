class BitkiModel {
  final String id;
  final String ad;
  final String kategori; // sebze / meyve / tahil / agac
  final List<String> uygunTopraklar;
  final String phIhtiyaci;
  final String suIhtiyaci;
  final String ekimZamani;
  final String hasatZamani;
  final String resimUrl;
  final List<String> bakimIpuclari;

  BitkiModel({
    required this.id,
    required this.ad,
    required this.kategori,
    required this.uygunTopraklar,
    required this.phIhtiyaci,
    required this.suIhtiyaci,
    required this.ekimZamani,
    required this.hasatZamani,
    required this.resimUrl,
    required this.bakimIpuclari,
  });

  factory BitkiModel.fromMap(String id, Map<String, dynamic> data) {
    return BitkiModel(
      id: id,
      ad: data['ad'] ?? '',
      kategori: data['kategori'] ?? '',
      uygunTopraklar:
          List<String>.from(data['uygun_topraklar'] ?? const <String>[]),
      phIhtiyaci: data['ph_ihtiyaci'] ?? '',
      suIhtiyaci: data['su_ihtiyaci'] ?? '',
      ekimZamani: data['ekim_zamani'] ?? '',
      hasatZamani: data['hasat_zamani'] ?? '',
      resimUrl: data['resim_url'] ?? '',
      bakimIpuclari:
          List<String>.from(data['bakim_ipuclari'] ?? const <String>[]),
    );
  }
}

