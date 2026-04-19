import 'package:flutter/material.dart';
import 'package:lux_market/features/auth/presentation/widgets/elevated_wg.dart';

class TermsBottomSheet extends StatelessWidget {
  final VoidCallback onAccept;

  const TermsBottomSheet({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "So‘nggi yangilanish",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "12–Aprel, 2026",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Text(
                    "1. Kirish",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Ilovamizga xush kelibsiz. Ushbu ilovadan foydalanish orqali siz quyidagi foydalanish shartlari va qoidalariga rozilik bildirasiz. Iltimos, ilovadan foydalanishdan oldin ushbu shartlar bilan tanishib chiqing.",
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "2. Foydalanish qoidalari",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "• Ilovadan faqat qonuniy maqsadlarda foydalanish kerak",
                  ),
                  Text(
                    "• Noto‘g‘ri yoki yolg‘on ma’lumot kiritish taqiqlanadi",
                  ),
                  Text(
                    "• Boshqa foydalanuvchilarga hurmat bilan munosabatda bo‘lish zarur",
                  ),
                  Text(
                    "• Ilovadagi mahsulotlar va xizmatlar bo‘yicha barcha kelishuvlar foydalanuvchi va do‘kon o‘rtasida amalga oshiriladi",
                  ),

                  SizedBox(height: 20),

                  Text(
                    "3. Buyurtma va javobgarlik",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text("• Ilova faqat vositachi platforma hisoblanadi"),
                  Text("• Mahsulot sifati uchun do‘kon javobgar"),
                  Text("• Narx va kelishuvlar chat orqali amalga oshiriladi"),

                  SizedBox(height: 20),

                  Text(
                    "4. Maxfiylik siyosati",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text("• Sizning shaxsiy ma’lumotlaringiz himoyalanadi"),
                  Text(
                    "• Ma’lumotlar uchinchi shaxslarga berilmaydi (qonuniy holatlar bundan mustasno)",
                  ),
                  SizedBox(height: 20),

                  Text(
                    "5.  Cheklovlar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "• Qoidalarni buzgan foydalanuvchilar bloklanishi mumkin",
                  ),
                  Text("• Soxta faoliyat aniqlansa akkaunt o‘chiriladi"),
                  SizedBox(height: 20),

                  Text(
                    "6.  Aloqa",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "• Ushbu Maxfiylik siyosati bo‘yicha savollaringiz bo‘lsa, biz bilan bog‘laning:",
                  ),

                  SizedBox(height: 10),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),

          ElevatedWidget(
            onPressed: () {
              onAccept();
              Navigator.pop(context);
            },
            text: "Qabul qilaman",
            textColor: Colors.white,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
