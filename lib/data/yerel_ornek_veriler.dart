import '../models/bitki_model.dart';
import '../models/toprak_model.dart';

/// Firestore yok / hata / Windows masaüstü gibi ortamlarda kullanılacak örnek veriler.
class YerelOrnekVeriler {
  YerelOrnekVeriler._();

  static final List<ToprakModel> topraklar = [
    ToprakModel(
      id: 'killi_toprak',
      ad: 'Killi Toprak',
      renk: 'Koyu kahverengi–kırmızımsı, ıslakken koyulaşır',
      phAralik: '6.5–7.5 (nötre yakın)',
      suTutma: 'Yüksek — uzun süre nem tutar',
      havalanma: 'Düşük — sıkışınca kökler zorlanır',
      ozellikler:
          'Killi topraklar ince taneli kil minerallerinden zengindir; ıslandığında yapışkan, kuruduğunda çatlar. Besin elementlerini (özellikle potasyum ve magnezyum) güçlü tutar. Ağır yapısı nedeniyle işlenmesi zordur; erken ilkbaharda “tav” bulmadan sürüm yapılmamalıdır. Organik madde (kompost, yanmış gübre) ve kaba kum/yeşil gübre ile yapı iyileştirilebilir. Sebze ve derin kökler için drenaj kanalları veya yükseltilmiş yataklar faydalıdır.',
      avantajlar: const [
        'Besin maddelerini uzun süre tutar; gübre verimi yüksektir',
        'Kurak dönemlerde bitkiye su sağlayabilir',
        'Toprak sıcaklığını görece dengeli tutar',
        'Erozyona karşı genellikle daha dayanıklıdır',
      ],
      dezavantajlar: const [
        'Islakken sıkışır; kök gelişimi ve havalanma bozulur',
        'İlkbaharda geç ısınır; erken ekim gecikebilir',
        'İşlenmesi güçtür; makine yükü artar',
        'Aşırı sulamada kök çürümesi riski yükselir',
      ],
      resimUrl:
          'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?auto=format&fit=crop&w=900&q=70',
    ),
    ToprakModel(
      id: 'kumlu_toprak',
      ad: 'Kumlu Toprak',
      renk: 'Açık kahverengi–sarımsı, taneler elle hissedilir',
      phAralik: '5.5–7.0',
      suTutma: 'Düşük — hızla kurur',
      havalanma: 'Yüksek — kökler bol oksijen alır',
      ozellikler:
          'Kumlu topraklar iri taneli yapıdadır; suyu ve çözünmüş besinleri hızla aşağıya geçirir. Bu yüzden sık ama kısa sulama ve azot gibi yıkanan besinlerin bölünerek verilmesi gerekir. Toprak erken ısınır; erken sebze ve kök bitkileri için avantajlıdır. Organik madde, kompost ve yeşil gübre ile su tutma kapasitesi artırılabilir. Rüzgâr erozyonuna açık alanlarda örtü bitkisi veya malç önerilir.',
      avantajlar: const [
        'Havalanması mükemmeldir; kök hastalıkları daha az görülür',
        'Kolay işlenir; erken ekime uygundur',
        'Çabuk ısınır; erken ürün için avantajlıdır',
        'Fazla su birikmez; su basması riski düşüktür',
      ],
      dezavantajlar: const [
        'Sık sulama ve gübreleme ihtiyacı yüksektir',
        'Besinler yağış/sulama ile yıkanır',
        'Kuraklık stresi hızlı gelişir',
        'Rüzgâr erozyonu ve yüzey kuruluğu sık görülür',
      ],
      resimUrl:
          'https://images.unsplash.com/photo-1509316785289-025f5b846b35?auto=format&fit=crop&w=900&q=70',
    ),
    ToprakModel(
      id: 'tinli_toprak',
      ad: 'Tınlı Toprak',
      renk: 'Orta kahverengi, ufalanabilir yapı',
      phAralik: '6.0–7.5',
      suTutma: 'Orta–yüksek — dengeli nem',
      havalanma: 'Orta — kökler için yeterlidir',
      ozellikler:
          'Tınlı toprak, kum–silt–kil dengesinin iyi olduğu “bahçe toprağı” tipidir. Su tutma ile drenaj arasında denge kurar; çoğu sebze, meyve ve tarla ürünü için ideal kabul edilir. Organik madde oranı yüksek tutulursa yapı yıllarca korunur. Aşırı işleme veya çıplak bırakma erozyonu artırabilir. Çiftçiler için hedef: her yıl kompost/yeşil gübre ile organik maddeyi %2–3 bandında tutmak.',
      avantajlar: const [
        'Çoğu ürün için en uygun genel amaçlı toprak tipidir',
        'Su ve hava dengesi iyidir; kökler sağlıklı gelişir',
        'İşlenmesi kolaydır; makine ve el aletiyle rahattır',
        'Besin tutma kapasitesi orta–yüksektir',
      ],
      dezavantajlar: const [
        'Organik madde azalırsa yapı bozulup “tozumaya” başlar',
        'Yamaçlarda erozyona açık hale gelebilir',
        'Aşırı sulama veya sıkışma verimi düşürür',
        'İyi yönetim yoksa zamanla killi veya kumlu karakter kazanabilir',
      ],
      resimUrl:
          'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?auto=format&fit=crop&w=900&q=70',
    ),
    ToprakModel(
      id: 'kirecli_toprak',
      ad: 'Kireçli Toprak',
      renk: 'Açık kahverengi–grimsi, bazen beyazımsı parçacıklar',
      phAralik: '7.5–8.5 (alkali)',
      suTutma: 'Orta — genelde hızlı süzülür',
      havalanma: 'Orta–iyi',
      ozellikler:
          'Kireçli (kalkerli) topraklarda kalsiyum karbonat yüksektir; pH alkalidir. Demir, çinko ve manganez gibi mikro besinlerin bitkiye alınması zorlaşabilir (kloroz / sararma). Zeytin, bazı baklagiller ve alkaliyi seven türler için uygundur. Asidik gübreler, organik madde ve gerekirse kükürt/demir şelatları ile dengeleme yapılabilir. Sert kireç parçaları kök gelişimini engelliyorsa yüzey işleme veya toprak iyileştirme gerekebilir.',
      avantajlar: const [
        'Yapı genellikle stabildir; çamurlaşma azdır',
        'Drenaj çoğu yerde iyidir',
        'Bazı hastalıkların baskılanmasına yardımcı olabilir',
        'Zeytin ve bazı Akdeniz ürünleri için doğal uyum',
      ],
      dezavantajlar: const [
        'Yüksek pH; demir/çinko noksanlığı (sarı yaprak) sık görülür',
        'Fosforun yarayışlılığı düşebilir',
        'Asit seven bitkiler (ör. bazı meyveler) zor yetişir',
        'Sert kireç katmanları kök derinliğini sınırlayabilir',
      ],
      resimUrl:
          'https://images.unsplash.com/photo-1464226184884-fa280b87c399?auto=format&fit=crop&w=900&q=70',
    ),
  ];

  static final List<BitkiModel> bitkiler = [
    BitkiModel(
      id: 'domates',
      ad: 'Domates',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Orta–yüksek; düzenli ve derin sulama',
      ekimZamani: 'Fideler: Mart–Nisan (don tehlikesi geçince)',
      hasatZamani: 'Temmuz–Eylül (çeşide göre)',
      resimUrl:
          'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Domates sıcak seven bir sebzedir; iyi ışıklı, rüzgârdan korunmuş yerlerde yüksek verim verir. Tınlı veya iyi iyileştirilmiş kumlu topraklarda kökler hızlı gelişir. Aşırı azot yaprakı artırıp meyveyi geciktirebilir; dengeli NPK ve kalsiyum (çiçek burnu çürüğünü önlemek için) önemlidir. Sırık çeşitlerde destek (çubuk/tel) şarttır. Sulama sabah veya akşam, yaprak ıslatmadan dip sulama şeklinde yapılmalıdır.',
      bakimIpuclari: const [
        'Haftada 2–3 kez derin sulayın; toprağın üstü kuruyunca tekrarlayın',
        'Sırık çeşitleri bağlayın ve yan sürgünleri (koltuk) alın',
        'Malç kullanarak nemi koruyun ve yabani otu azaltın',
        'Erken blight / mildiyö için havalandırma ve hastalıklı yaprak temizliği yapın',
        'Çiçek burnu çürüğünde kalsiyum dengesi ve düzenli sulamaya dikkat edin',
      ],
    ),
    BitkiModel(
      id: 'bugday',
      ad: 'Buğday',
      kategori: 'tahil',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.5',
      suIhtiyaci: 'Orta; yağışa bağlı, kardeşlenme ve başak dönemleri kritik',
      ekimZamani: 'Kışlık: Ekim–Kasım | Yazlık: Şubat–Mart',
      hasatZamani: 'Haziran–Temmuz (olgunlaşma ve nem oranına göre)',
      resimUrl:
          'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Buğday, Türkiye’de en yaygın tarla ürünlerinden biridir. İyi drenajlı tınlı–kumlu tın topraklarda kök sistemi derine iner. Azot, kardeşlenme ve başak dolumu dönemlerinde kritiktir; aşırı azot yatmaya (lodging) yol açabilir. Tohum yatağı ince hazırlanmalı, ekim derinliği çeşide göre ayarlanmalıdır. Yabancı ot mücadelesi erken dönemde verimi belirler. Hasatta dane nemi depolama için uygun seviyeye düşmüş olmalıdır.',
      bakimIpuclari: const [
        'Toprak analizine göre taban gübre + üstten azot bölünmüş uygulayın',
        'Kardeşlenme ve sapa kalkma döneminde yabancı ot kontrolü yapın',
        'Yatmayı önlemek için aşırı azot ve sık ekimden kaçının',
        'Pas ve septorya gibi hastalıklara karşı çeşidi ve rotasyonu seçin',
        'Hasatta dane nemini ölçün; erken hasat depolama kaybı yapar',
      ],
    ),
    BitkiModel(
      id: 'misir',
      ad: 'Mısır',
      kategori: 'tahil',
      uygunTopraklar: const ['tinli_toprak', 'killi_toprak'],
      phIhtiyaci: '5.8–7.0',
      suIhtiyaci: 'Yüksek; özellikle tepe püskülü ve dane dolumu döneminde',
      ekimZamani: 'Nisan–Mayıs (toprak sıcaklığı ~10–12 °C üzeri)',
      hasatZamani: 'Eylül–Ekim (dane tipi / silaj tipine göre)',
      resimUrl:
          'https://images.unsplash.com/photo-1551754655-cd27e38d0474?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Mısır, yüksek ışık ve sıcaklık isteyen, besin tüketimi fazla bir üründür. Derin ve verimli tınlı veya iyileştirilmiş killi topraklarda iyi sonuç verir. Azot ihtiyacı yüksektir; sıra arası ve sıra üzeri mesafeler çeşide göre ayarlanmalıdır. Kuraklık stresi tepe püskülü döneminde verimi sert düşürür. Yabancı ot kontrolü ilk 4–6 haftada kritiktir çünkü mısır yavaş başlar.',
      bakimIpuclari: const [
        'Ekimden önce toprak sıcaklığını kontrol edin; soğuk toprakta çimlenme zayıf olur',
        'Azotu 2–3 parçaya bölerek verin; damla/yağmurlama ile destekleyin',
        'Tepe püskülü döneminde su stresi bırakmayın',
        'Sıra arası çapayı erken yapın; ot rekabetini kesin',
        'Zararlı (mısır kurdu vb.) takibini yapın; gerektiğinde entegre mücadele uygulayın',
      ],
    ),
    BitkiModel(
      id: 'pamuk',
      ad: 'Pamuk',
      kategori: 'tahil',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '5.8–8.0',
      suIhtiyaci: 'Orta–yüksek; çiçeklenme ve koza dolumu kritik',
      ekimZamani: 'Nisan–Mayıs (sıcak toprak)',
      hasatZamani: 'Eylül–Ekim (koza açımına göre)',
      resimUrl:
          'https://images.unsplash.com/photo-1605000797499-95a51c5269b0?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Pamuk uzun ve sıcak bir büyüme mevsimi ister. İyi drenajlı tınlı–kumlu tın topraklarda kökler derinleşir. Aşırı azot vegetatif büyümeyi artırıp kozaları geciktirebilir. Sulama programı toprak tipine göre ayarlanmalı; su stresi erken dönemde dallanmayı, geç dönemde lif kalitesini bozar. Pamukta zararlı (yaprak biti, pembe kurt vb.) izleme düzenli yapılmalıdır.',
      bakimIpuclari: const [
        'Toprak sıcaklığı uygun olmadan ekmeyin',
        'Azot ve potasyumu dengeli tutun; aşırı azottan kaçının',
        'Çiçeklenme–koza döneminde sulamayı ihmal etmeyin',
        'Zararlı izleme (scouting) rutini oluşturun',
        'Hasatta koza olgunluğunu gözleyin; erken hasat lif kaybı yapar',
      ],
    ),
    BitkiModel(
      id: 'karpuz',
      ad: 'Karpuz',
      kategori: 'meyve',
      uygunTopraklar: const ['kumlu_toprak', 'tinli_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Yüksek; meyve büyüme döneminde bol su',
      ekimZamani: 'Nisan–Mayıs (fideli veya doğrudan tohum)',
      hasatZamani: 'Temmuz–Eylül',
      resimUrl:
          'https://images.unsplash.com/photo-1587049352846-4a222e784d38?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Karpuz sıcak iklim ve bol güneş ister. Kumlu veya hafif tınlı, iyi süzülen topraklarda şeker birikimi ve olgunlaşma daha iyidir. Geniş alan ister; sıra arası geniş tutulur. Erken dönemde azot, meyve tutumundan sonra potasyum ağırlıklı besleme tercih edilir. Aşırı sulama tatı düşürebilir; hasada yakın sulama azaltılır. Külleme ve antraknoz gibi hastalıklara karşı havalandırma ve rotasyon önemlidir.',
      bakimIpuclari: const [
        'Sıcak ve güneşli yer seçin; soğuk toprağa ekmeyin',
        'Malç ile nemi koruyun ve meyveyi topraktan ayırın',
        'Meyve tutumundan sonra potasyumu artırın',
        'Hasada yakın aşırı sulamadan kaçının (tat düşer)',
        'Hastalıklı yaprakları temizleyin; sıra arası havalanmayı sağlayın',
      ],
    ),
    BitkiModel(
      id: 'kavun',
      ad: 'Kavun',
      kategori: 'meyve',
      uygunTopraklar: const ['kumlu_toprak', 'tinli_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Yüksek; çiçeklenme ve meyve şişmesi kritik',
      ekimZamani: 'Nisan–Mayıs',
      hasatZamani: 'Temmuz–Ağustos',
      resimUrl:
          'https://images.unsplash.com/photo-1571575173700-afb9492e6efa?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Kavun, karpuza benzer şekilde sıcaklık ve güneş ister; aroma ve şeker için gündüz–gece sıcaklık farkı faydalıdır. İyi drenajlı kumlu–tınlı topraklar tercih edilir. Aşırı azot meyve kalitesini bozar. Sulama damla ile yapılırsa yaprak hastalıkları azalır. Olgunluk göstergeleri (renk, sap çatlak, koku) hasat zamanını belirler.',
      bakimIpuclari: const [
        'Ilık toprak ve bol güneş şarttır',
        'Damla sulama ile yaprak ıslanmasını azaltın',
        'Meyve tutumundan sonra potasyumu destekleyin',
        'Külleme riskine karşı sıra aralarını açık tutun',
        'Olgunluk belirtilerini kontrol ederek hasat edin',
      ],
    ),
    BitkiModel(
      id: 'havuc',
      ad: 'Havuç',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Orta; düzenli nem, su birikmeden',
      ekimZamani: 'Mart–Nisan (ve sonbahar ekimleri bölgeye göre)',
      hasatZamani: 'Haziran–Ekim (ekimden ~70–120 gün)',
      resimUrl:
          'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Havuç derin, taşsız ve sıkışmamış toprak ister; aksi halde kök çatallar veya kısa kalır. Hafif tınlı veya kumlu topraklar kök şekli için idealdir. Tohumlar yavaş çimlenir; toprak yüzeyi nemli tutulmalıdır. Sık ekimde inceltme şarttır. Taze gübre kökleri bozar; iyi yanmış kompost tercih edilir. Düzenli sulama çatlama riskini azaltır.',
      bakimIpuclari: const [
        'Taş ve sert katmanları temizleyin; derin gevşetin',
        'Çimlenme döneminde yüzeyi sürekli nemli tutun',
        'Sık bitkileri inceltin; köklerin genişlemesine yer açın',
        'Taze ahır gübresi kullanmayın',
        'Ani kuru–ıslak dalgalanmadan kaçının (kök çatlaması)',
      ],
    ),
    BitkiModel(
      id: 'patates',
      ad: 'Patates',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '5.0–6.5 (hafif asidik tercih)',
      suIhtiyaci: 'Orta; yumru oluşumunda düzenli su',
      ekimZamani: 'Mart–Nisan (don riski azalınca)',
      hasatZamani: 'Haziran–Eylül (erken / ana ürün)',
      resimUrl:
          'https://images.unsplash.com/photo-1518977676601-b53f82aba655?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Patates, gevşek ve iyi havalanan topraklarda yumru kalitesi yüksek olur. Hafif asidik pH kabuk hastalıklarını azaltmaya yardımcı olabilir. Ekimde gözlü yumru parçaları kullanılır; boğaz doldurma (toprak yığma) yeşil yumruyu önler. Aşırı sulama çürüme, dengesiz sulama çatlama/şekil bozukluğu yapar. Mildiyö gibi hastalıklara karşı rotasyon ve havalandırma önemlidir.',
      bakimIpuclari: const [
        'Boğaz doldurmayı 2–3 kez yapın; yumruları ışıktan koruyun',
        'Yumru oluşumunda düzenli nem sağlayın',
        'Aynı tarlaya peş peşe patates ekmeyin (rotasyon)',
        'Hastalıklı yaprakları temizleyin; mildiyöye karşı gözlem yapın',
        'Hasattan sonra yumruları gölgede kurutun, serin depolayın',
      ],
    ),
    BitkiModel(
      id: 'sogan',
      ad: 'Soğan',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Orta; baş oluşumunda düzenli, hasada yakın azaltılmış',
      ekimZamani: 'Mart–Nisan (tohum / arpacık)',
      hasatZamani: 'Temmuz–Eylül',
      resimUrl:
          'https://images.unsplash.com/photo-1518977956812-cd3dbadaaf31?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Soğan sığ köklü bir bitkidir; iyi süzülen, taşsız tınlı–kumlu topraklarda başlar düzgün gelişir. Azot erken dönemde yeşil aksamı destekler; geç dönemde fazla azot depolama ömrünü kısaltır. Yabancı ot rekabetine karşı hassastır. Hasatta yapraklar yatmaya başladığında söküm yapılır; kurutma (curing) depolama için kritiktir.',
      bakimIpuclari: const [
        'Erken dönemde ot mücadelesini aksatmayın',
        'Baş oluşumunda düzenli sulayın; hasada yakın sulamayı kesin',
        'Geç dönemde aşırı azot vermeyin',
        'Yapraklar yatınca hasat edin; gölgede kurutun',
        'Depolamada kuru, serin ve havalı ortam kullanın',
      ],
    ),
    BitkiModel(
      id: 'salatalik',
      ad: 'Salatalık',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Yüksek; düzenli nem şart',
      ekimZamani: 'Nisan–Mayıs',
      hasatZamani: 'Haziran–Eylül (sürekli hasat)',
      resimUrl:
          'https://images.unsplash.com/photo-1449300079323-02e209d9d3a6?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Salatalık hızlı büyüyen, nem ve sıcaklık seven bir sebzedir. Organik maddece zengin tınlı topraklarda verim yüksektir. Tırmanma (tel/çardak) hem alan tasarrufu hem hastalık azalması sağlar. Düzensiz sulama acılaşma ve şekil bozukluğuna yol açabilir. Erkek/dişi çiçek dengesi ve tozlaşma (açık alanda arılar) meyve tutumunu etkiler. Sık hasat verimi artırır.',
      bakimIpuclari: const [
        'Tel veya çardak ile dik büyütün',
        'Toprağı sürekli nemli tutun; kurumaya bırakmayın',
        'Organik madde ve dengeli gübreleme uygulayın',
        'Külleme için havalandırma sağlayın',
        'Meyveleri küçükken sık hasat edin',
      ],
    ),
    BitkiModel(
      id: 'biber',
      ad: 'Biber',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Orta–yüksek; stresten kaçının',
      ekimZamani: 'Fideler: Mart–Nisan, tarlaya don bitince',
      hasatZamani: 'Temmuz–Ekim',
      resimUrl:
          'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Biber sıcaklık ve güneş ister; gece soğukları büyümeyi yavaşlatır. İyi drenajlı tınlı topraklarda kök sağlığı iyidir. Aşırı azot yaprak artırıp çiçek dökmeye yol açabilir. Su stresi çiçek ve küçük meyve dökümüne neden olur. Destek çubukları rüzgârlı bölgelerde faydalıdır. Hasat olgunluk rengine göre (yeşil / kırmızı) yapılır.',
      bakimIpuclari: const [
        'Don riski geçmeden tarlaya dikmeyin',
        'Düzenli sulama ile çiçek dökümünü azaltın',
        'Aşırı azottan kaçının; potasyumu destekleyin',
        'Gerekiyorsa bitkiye destek bağlayın',
        'Zararlı (yaprak biti, trips) kontrolü yapın',
      ],
    ),
    BitkiModel(
      id: 'patlican',
      ad: 'Patlıcan',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'killi_toprak'],
      phIhtiyaci: '5.5–7.0',
      suIhtiyaci: 'Orta–yüksek',
      ekimZamani: 'Fideler: Mart–Nisan',
      hasatZamani: 'Temmuz–Ekim',
      resimUrl:
          'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Patlıcan uzun sıcak sezon ister. Organik maddece zengin, derin tınlı veya iyileştirilmiş killi topraklarda iyi gelişir. Destek ve budama (gereksiz sürgün alma) meyve kalitesini artırır. Düzenli sulama acılaşmayı ve şekil bozukluğunu azaltır. Colorado böceği gibi zararlılara karşı erken gözlem önemlidir.',
      bakimIpuclari: const [
        'Sıcak toprak ve bol güneş seçin',
        'Bitkiye destek verin; meyve yükünü taşıyın',
        'Düzenli sulayın; kuraklık stresi bırakmayın',
        'Zararlıları yaprak altında kontrol edin',
        'Parlak, sert meyveleri zamanında hasat edin',
      ],
    ),
    BitkiModel(
      id: 'marul',
      ad: 'Marul',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Orta–yüksek; sürekli hafif nem',
      ekimZamani: 'Mart–Mayıs (serin dönemler tercih)',
      hasatZamani: 'Mayıs–Temmuz (ekimden ~30–60 gün)',
      resimUrl:
          'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Marul serin havayı sever; aşırı sıcakta gövdeye kalkar (çiçeklenir) ve acılaşır. Nemli, organik maddece zengin tınlı topraklar idealdir. Hızlı büyüdüğü için azot ihtiyacı düzenli karşılanmalıdır. Sık ve sığ sulama tercih edilir. Gölgeleme tül ile yaz ekimlerinde kalite korunabilir.',
      bakimIpuclari: const [
        'Serin dönemlerde ekin; sıcak stresten koruyun',
        'Toprağı sürekli hafif nemli tutun',
        'Organik madde ve dengeli azot sağlayın',
        'Sık ekimde inceltme yapın',
        'Başlar dolunca gecikmeden hasat edin',
      ],
    ),
    BitkiModel(
      id: 'lahana',
      ad: 'Lahana',
      kategori: 'sebze',
      uygunTopraklar: const ['tinli_toprak', 'killi_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Yüksek; baş oluşumunda bol su',
      ekimZamani: 'Mart–Nisan / sonbahar ekimleri bölgeye göre',
      hasatZamani: 'Haziran–Ekim',
      resimUrl:
          'https://images.unsplash.com/photo-1594282486552-05b4b074f724?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Lahana serin iklim sebzesidir; nemli ve besince zengin tınlı–killi topraklarda başlar sıkı gelişir. Azot ve su ihtiyacı yüksektir. Lahana kelebeği larvaları yaprakları delik deşik eder; örtü veya entegre mücadele gerekir. Düzenli sulama baş çatlamasını azaltır. Rotasyon kök hastalıklarını azaltır.',
      bakimIpuclari: const [
        'Baş oluşumunda düzenli ve bol sulayın',
        'Lahana kelebeği için yaprak altını kontrol edin',
        'Dengeli azot verin; aşırı azot gevşek baş yapar',
        'Aynı familyadan peş peşe ekimden kaçının',
        'Başlar sıkılaşınca hasat edin',
      ],
    ),
    BitkiModel(
      id: 'elma',
      ad: 'Elma',
      kategori: 'agac',
      uygunTopraklar: const ['tinli_toprak', 'kumlu_toprak'],
      phIhtiyaci: '6.0–7.0',
      suIhtiyaci: 'Orta; özellikle meyve dolumu döneminde',
      ekimZamani: 'Fidan dikimi: sonbahar veya erken ilkbahar',
      hasatZamani: 'Eylül–Ekim (çeşide göre)',
      resimUrl:
          'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Elma, iyi drenajlı tınlı topraklarda uzun ömürlü ve verimli olur. Su biriken ağır killi alanlarda kök hastalıkları artar. Çoğu çeşit tozlayıcı (başka çeşit) ister. Kış budaması taç yapısını ve ışık girişini düzenler. Karaleke ve elma içkurdu gibi hastalık/zararlılara karşı entegre mücadele planı gerekir. Malç ve damla sulama genç fidanlarda tutmayı artırır.',
      bakimIpuclari: const [
        'İyi drenajlı yer seçin; su birikmesine izin vermeyin',
        'Tozlayıcı çeşit dikmeyi unutmayın',
        'Her kış şekil ve sağlık budaması yapın',
        'Karaleke ve zararlı izleme programı uygulayın',
        'Genç ağaçlarda düzenli sulama ve malç kullanın',
      ],
    ),
    BitkiModel(
      id: 'zeytin',
      ad: 'Zeytin',
      kategori: 'agac',
      uygunTopraklar: const ['kirecli_toprak', 'tinli_toprak'],
      phIhtiyaci: '6.0–8.0',
      suIhtiyaci: 'Düşük–orta; kuraklığa dayanıklı, gençlikte destek sulama',
      ekimZamani: 'Fidan: ilkbahar (don bitince)',
      hasatZamani: 'Kasım–Aralık (yeşil / siyah olgunluğa göre)',
      resimUrl:
          'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?auto=format&fit=crop&w=800&q=70',
      aciklama:
          'Zeytin Akdeniz iklimine uyumludur; kireçli ve taşlı topraklarda bile yaşayabilir. Aşırı sulama ve ağır killi, su tutan zemin kök çürümesine yol açar. Budama ışık girişini ve periyodisiteyi (bir yıl bol, bir yıl az ürün) yönetmeye yardım eder. Zeytin sineği hasat kalitesini belirler. Genç fidanlarda ilk 2–3 yıl düzenli sulama tutmayı güçlendirir.',
      bakimIpuclari: const [
        'Su basmayan, güneşli yamaç/düzlük tercih edin',
        'İlk yıllarda destek sulaması yapın',
        'Her yıl hafif–orta budama ile tacı açın',
        'Zeytin sineği mücadelesini hasat öncesi planlayın',
        'Aşırı gübre ve aşırı sudan kaçının',
      ],
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
