import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_market/core/routes/route_names.dart';
import 'package:lux_market/features/auth/presentation/widgets/elevated_wg.dart';
import 'package:lux_market/features/auth/presentation/widgets/gradient_background_wg.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  final String email;

  const ForgotPasswordOtpPage({super.key, required this.email});

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _agreedToTerms = false;

  late DateTime _expiresAt;
  Timer? _timer;

  String _otp = "";
  Duration _remaining = Duration.zero;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();

    // expires_at ni birinchi init qilib ol
    _expiresAt = DateTime.now().add(Duration(seconds: 45));

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    // darhol 1 marta hisoblab qo'yamiz (UI yangilansin)
    _syncRemaining();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      _syncRemaining();

      if (_canResend) {
        timer.cancel();
      }
    });
  }

  void _syncRemaining() {
    final now = DateTime.now();
    final diff = _expiresAt.difference(now);

    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
      _canResend = _remaining == Duration.zero;
    });
  }

  void _resendCode() {
    if (!_canResend) return;

    _otpController.clear();
    setState(() => _otp = "");

    // resend => API chaqiradi
    // context.read<CustomerSendEmailBloc>().add(
    //   CustomerSendEmail(email: widget.email),
    // );
  }

  bool get _isButtonEnabled => _otp.length == 6;

  String get _remainingText {
    final seconds = _remaining.inSeconds;
    if (seconds <= 0) return "0";
    return seconds.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child:
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 141),
                  const Text(
                    'Emailingizni tasdiqlang',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1030),
                      height: 1.15,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tasdiqlash kodi ${widget.email} emailga yuborildi',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B6480),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 40),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.70),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Elektron pochta manzilingizni tasdiqlang',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D2050),
                              ),
                            ),

                            const SizedBox(height: 12),
                            Pinput(
                              controller: _otpController,
                              length: 4,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => setState(() => _otp = value),
                              onCompleted: (pin) => setState(() => _otp = pin),
                              defaultPinTheme: PinTheme(
                                width: 83,
                                height: 61,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                decoration: BoxDecoration(color: Color(0xffF2EEF8),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xffCCCCCC),
                                  ),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 83,
                                height: 61,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xff6A85F1),
                                    width: 1.3,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            const SizedBox(height: 18),
                            ElevatedWidget(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.newPasswordPage);
                              },
                              text: "Tasdiqlash",
                              textColor: Colors.white,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Pochta manzilingizga kelgan kodni kiriting.",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _canResend
                            ? "Tasdiqlash kodini olmadingizmi?"
                            : "Qayta yuborish $_remainingText s",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: _canResend ? _resendCode : null,
                        child: Text(
                          "Qayta yuborish",
                          style: TextStyle(
                            color: _canResend
                                ? Colors.blue
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
      ),
    );
  }
}
