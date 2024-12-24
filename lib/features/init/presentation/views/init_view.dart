import 'dart:math';
import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../authentication/presentation/views/screens/login/login_view.dart';
import '../../../nav_bar/bottom_nav_bar.view.dart';
import 'init_view_model.dart';

class InitView extends StatelessWidget {
  static const String route = '/';

  const InitView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitViewModel>(
      create: (context) => sl<InitViewModel>()..init(),
      child: BlocListener<InitViewModel, bool>(
        listener: (context, state) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            state ? NavigationView.route : LoginView.route,
            (route) => false,
          );
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: SvgPicture.asset('assets/logo.svg'),
              ),
              const Positioned(
                top: 280,
                left: 0,
                right: 0,
                child: Spinner(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Spinner extends StatefulWidget {
  const Spinner({
    super.key,
  });

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(
            _animationController.value * 2 * pi,
          ),
          child: child,
        );
      },
      child: SvgPicture.asset('assets/brand-pin.svg'),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
