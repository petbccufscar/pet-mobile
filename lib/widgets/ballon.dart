import "package:flutter/material.dart";

class BallonContainer extends StatefulWidget {
  BallonContainer(
      {Key? key,
      required this.borderRadius,
      required this.title,
      required this.child,
      required this.readMore,
      required this.cndLeiaMais,
      required this.backGroundColor,
      required this.onTap})
      : super(key: key);

  final BorderRadiusGeometry borderRadius;
  final String title;
  final Widget child;
  final bool readMore;
  final bool cndLeiaMais;
  final Color backGroundColor;
  final Function()? onTap;

  @override
  _BallonContainerState createState() => _BallonContainerState();
}

class _BallonContainerState extends State<BallonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backGroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: widget.child,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: widget.cndLeiaMais
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            widget.readMore ? "Ler menos" : "Ler mais",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                              widget.readMore
                                  ? Icons.navigate_before
                                  : Icons.navigate_next,
                              color: Colors.white),
                          onPressed: widget.onTap,
                        ),
                      ],
                    )
                  : null)
        ],
      ),
    );
  }
}
