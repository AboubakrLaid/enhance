import 'package:enhance/refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class RefreshButton extends StatefulWidget {
  const RefreshButton({super.key});

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  final List<String> _items = List.generate(20, (index) => "item $index");
  bool refresh = true;
  bool isCollapsed = true;
  late ScrollController _scrollController;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<Refresh>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              forceElevated: true,
              // pinned: true,
              // floating: true,
              // snap: true,
              expandedHeight: 150,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("fsd"),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AnimatedSlide(
                  offset: refresh
                      ? const Offset(0,  1)
                      : const Offset(0, -6),
                  duration: const Duration(milliseconds: 200),
                  child: ElevatedButton(
                    onPressed: () async {
                      String newItem = "item ${_items.length}";
                      await _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 360),
                        curve: Curves.decelerate,
                      );
                      setState(
                        () async {
                          _items.add(newItem);
                        },
                      );
                    },
                    child: Text("$refresh"),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListView.builder(
                    controller: _scrollController,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        child: Text(
                          _items[_items.length - index - 1],
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            refresh = !refresh;
            // _animationController.status == AnimationStatus.completed
            //     ? _animationController.forward()
            //     : _animationController.reset();
          });
        }),
      ),
    );
  }
}
