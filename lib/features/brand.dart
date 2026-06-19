import 'package:flutter/material.dart';

const LinearGradient kBrandGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF5B7BF5), Color(0xFFB18BE8), Color(0xFFEFC6E8)],
);

class AppText extends StatelessWidget {
  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  const AppText({
    super.key,
    required this.data,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color = const Color(0xFFFFFFFF),
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class BrandLogo extends StatelessWidget {
  final double size;
  const BrandLogo({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/brand_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: kBrandGradient,
          borderRadius: BorderRadius.circular(size * 0.24),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.lock, color: const Color(0xFF1A1030), size: size * 0.5),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double radius;
  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 56,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: kBrandGradient,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: AppText(
          data: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class BrandField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixWidget;
  final TextInputType? keyboardType;
  const BrandField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.suffixWidget,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        border: Border.all(color: const Color(0xFF3A3A45)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
              cursorColor: const Color(0xFFB18BE8),
              decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                hintText: hintText,
                hintStyle:
                    const TextStyle(color: Color(0xFF8A8A93), fontSize: 16),
              ),
            ),
          ),
          if (suffixWidget != null) suffixWidget!,
        ],
      ),
    );
  }
}

class AuthScaffold extends StatelessWidget {
  final List<Widget> children;
  const AuthScaffold({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 660),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
