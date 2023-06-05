import 'dart:developer';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Carousel",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return  ChildWidget(index: index,);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
   ChildWidget({
    super.key,
    required this.index
  });

  int index;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderObject = context.findRenderObject() as RenderBox;
      final offsetY = renderObject.localToGlobal(Offset.zero).dx;
      final deviceHeight = MediaQuery.of(context).size.height;
      final relativePosition = offsetY / deviceHeight;
      log(relativePosition.toString());
    });
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
            color: Colors.red[200], borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            "Box $index",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
