import 'package:get/get.dart';

class WeddingController extends GetxController {
  List<Map<String, dynamic>> venues = [
    {
      "name": "Marigold Banquets N Conventions",
      "location": "Pune, India",
      "price": 100000,
      "capacity": 1500,
      "image":
          "https://cdn0.weddingwire.in/vendor/9107/3_2/960/jpg/wedding-venue-marigold-banquets-n-conventions-event-space4_15_179107-158703044195983.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "name": "Aarti Lawns",
      "location": "Pimpri, Pune",
      "price": 50000,
      "capacity": 500,
      "image":
          "https://cdn0.weddingwire.in/vendor/6540/3_2/960/jpg/avp-6620_15_486540-174229855299065.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "name": "Nakshatra Palace",
      "location": "Shivapur, Pune",
      "price": 200000,
      "capacity": 1500,
      "image":
          "https://cdn0.weddingwire.in/vendor/5047/3_2/960/jpg/banquet-halls-nakshatra-the-royal-wedding-facade_15_315047-163781093916868.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "name": "Hotel Rajmudra",
      "location": "Hinjawadi, Pune",
      "price": 150000,
      "capacity": 1000,
      "image":
          "https://cdn0.weddingwire.in/vendor/4081/3_2/960/jpeg/whatsapp-image-2024-11-15-at-7-32-27-pm_15_404081-173167975690190.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "name": "The Grand Heritage Resorts",
      "location": "Wagholi, Pune",
      "price": 400000,
      "capacity": 10000,
      "image":
          "https://cdn0.weddingwire.in/vendor/4757/3_2/960/jpg/family-friendly-resorts-pune_15_364757-174099876057624.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "name": "Malhar Resort",
      "location": "Pune-Solapur Road, Pune",
      "price": 40000,
      "capacity": 300,
      "image":
          "https://cdn0.weddingwire.in/vendor/3863/3_2/960/jpeg/whatsapp-image-2024-11-28-at-12-39-56-pm_15_483863-173278205699214.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "name": "MDS Banquets & Lawns",
      "location": "Pimpri, Pune",
      "price": 200000,
      "capacity": 2000,
      "image":
          "https://cdn0.weddingwire.in/vendor/9656/3_2/960/jpeg/whatsapp-image-2023-09-25-at-7-21-36-pm_15_439656-169564992788348.webp",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
  ];

  Rx<bool> isVisibleNavBar = true.obs;

  void changeNavBarVisiblity(bool val) {
    isVisibleNavBar.value = val;
  }
}
