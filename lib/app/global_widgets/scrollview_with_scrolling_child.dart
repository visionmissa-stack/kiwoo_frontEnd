import 'package:flutter/widgets.dart';

class ScrollviewWithScrollingChild extends StatelessWidget {
  final Widget header;
  final Widget? fixHeader;
  final Widget body;
  final double? minExtent;
  final double? maxExtent;

  const ScrollviewWithScrollingChild({
    super.key,
    required this.header,
    required this.body,
    this.fixHeader,
    this.minExtent,
    this.maxExtent,
  });
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(child: header),
          if (fixHeader != null)
            SliverResizingHeader(
              minExtentPrototype: SizedBox(
                height: minExtent,
              ),
              maxExtentPrototype: SizedBox(
                height: maxExtent,
              ),
              child: fixHeader,
            )
        ];
      },
      body: body,
    );
  }
}
