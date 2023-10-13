// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';

List<_Content> _contents = [
  _Content(
    subtitle:
        'Research firms predict that products and services for application development that employ visual, declarative techniques instead of programming',
    title:
        'Experience the new normal in the digital innovations and transformation',
    widget: Image.asset('assets/managed-file-transfer-landing-page.png'),
  ),
  _Content(
    subtitle:
        'Continuous innovations, consistent scaling, ever Green effectiveness',
    title: 'Platform for modernising your digital business',
    widget: Image.asset('assets/e-invoicing-landing-page.png'),
  ),
  _Content(
    subtitle:
        'Embracing ingress platform stack to design, build and rollout your digital transformation initiatives and innovations',
    title: 'Transforming customer data into actionable insights',
    widget: Image.asset(
      'assets/online-lending-landing-page.png',
    ),
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Color> colorss = [
    const Color.fromARGB(255, 255, 248, 214),
    const Color.fromARGB(255, 248, 232, 238),
    const Color.fromARGB(255, 227, 242, 193),
  ];
  final GlobalKey<OnboardingScreenState> gKey = GlobalKey();

  double get currentOffset {
    bool inited = pageController.hasClients &&
        pageController.position.hasContentDimensions;

    return inited ? pageController.page! : pageController.initialPage * 1.0;
  }

  int get currentIndex {
    return currentOffset.round() % _contents.length;
  }

  double scaleValue(double input) {
    double mappedValue = input - 1;
    return mappedValue.abs().clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: MediaQuery.sizeOf(context).height,
            color: colorss[currentIndex],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height - 150,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: _contents.length,
                      itemBuilder: (context, index) {
                        double _value = 0.0;
                        double vp = 1;
                        double scale = max(vp, (currentOffset - index).abs());
                        if (pageController.position.haveDimensions) {
                          _value =
                              index.toDouble() - (pageController.page ?? 0);
                          _value = (_value * .7).clamp(-1, 1);
                        }
                        return Opacity(
                          opacity: scaleValue(_value),
                          child: Transform.scale(
                            scale: scaleValue(_value),
                            child: Container(
                              color: Colors.blue[500],
                              child: OnBoardingContent(
                                content: _contents[index],
                                angle: pi * _value,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: DotIndicator(
                    currentIndex: currentIndex,
                    controller: pageController,
                    length: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: currentIndex == _contents.length - 1
                            ? null
                            : () {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInToLinear,
                                );
                              },
                        child: const Text('Next'),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: currentIndex == _contents.length - 1
                            ? const AnimatedOnBoardingButton()
                            : OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: currentIndex == _contents.length - 1
                                    ? null
                                    : () {
                                        pageController.animateToPage(
                                          _contents.length - 1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInToLinear,
                                        );
                                      },
                                child: const Text('Skip'),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent(
      {Key? key, required this.content, required this.angle})
      : super(key: key);
  final _Content content;
  final double angle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 3,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                content.title,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).height / 200 * 6,
                    ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                content.subtitle,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: MediaQuery.sizeOf(context).height / 200 * 4.2,
                    ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Transform.rotate(
            angle: angle,
            child: content.widget,
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  DotIndicator(
      {super.key,
      this.length = 5,
      this.currentIndex = -1,
      required this.controller});
  int length;
  int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [...List.generate(length, (index) => buildDotIndicator(index))],
    );
  }

  Widget buildDotIndicator(int indexx) {
    return InkWell(
      onTap: () {
        controller.previousPage(
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 11,
          width: currentIndex == indexx ? 30 : 11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:
                currentIndex == indexx ? Colors.blue[700] : Colors.transparent,
            border: Border.all(
              width: currentIndex == indexx ? 0 : 1.5,
              color:
                  currentIndex == indexx ? Colors.transparent : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedOnBoardingButton extends StatefulWidget {
  const AnimatedOnBoardingButton({super.key});

  @override
  State<AnimatedOnBoardingButton> createState() =>
      _AnimatedOnBoardingButtonState();
}

class _AnimatedOnBoardingButtonState extends State<AnimatedOnBoardingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> shiverAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    initilizeAnimation();
    initController();
  }

  void initilizeAnimation() {
    shiverAnimation = TweenSequence(<TweenSequenceItem<double>>[
      ...genrateTweenSequence(),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          .855,
          curve: Curves.easeInOut,
        ),
      ),
    );

    scaleAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween(begin: 1, end: 1.35),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.35, end: 1),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          1,
          curve: Curves.slowMiddle,
        ),
      ),
    );
  }

  void initController() async {
    _controller.addListener(
      () => setState(() {}),
    );
    await Future.delayed(const Duration(milliseconds: 1000));
    _controller.forward();
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 950));
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RotationTransition(
          turns: shiverAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          _controller.reset();
        },
        child: const FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Explore"),
              SizedBox(
                width: 6,
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }

  List<double> discretize(double minValue, double maxValue, int length) {
    List<double> result = [];

    if (length <= 2) {
      result.addAll([minValue, maxValue]);
      return result;
    }

    double interval = (maxValue - minValue) / (length - 1);
    for (int i = 0; i < length; i++) {
      result.add(minValue + i * interval);
    }

    return result;
  }

  List<TweenSequenceItem<double>> genrateTweenSequence() {
    List<TweenSequenceItem<double>> _sequnce = [];
    final discreatedValues = discretize(0.9, 1.1, 7);
    final rearrangedValues = permutates(discreatedValues);
    rearrangedValues.insert(0, 1.0);
    rearrangedValues.insert(rearrangedValues.length, 1.0);

    for (int i = 0; i < rearrangedValues.length - 1; i++) {
      _sequnce.add(
        TweenSequenceItem<double>(
          tween: Tween(
            begin: rearrangedValues[i],
            end: rearrangedValues[i + 1],
          ),
          weight: 1,
        ),
      );
    }
    return _sequnce;
  }

  List<double> permutates(List<double> list) {
    List<double> _result = [];
    int length = list.length;

    for (int i = 0; i < length / 2; i++) {
      _result.add(list[i]);
      _result.add(list[length - 1 - i]);
    }
    if (length % 2 != 0) {
      _result.add(list[length ~/ 2]);
    }
    return _result;
  }
}

class _Content {
  _Content({
    required this.subtitle,
    required this.title,
    required this.widget,
  });
  String title;
  String subtitle;
  Widget widget;
}
