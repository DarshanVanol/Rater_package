library rater;

import 'package:flutter/material.dart';


class Rating extends StatefulWidget {
  final int initialRating;
  final Function(int rating) onChangeRating;
  final Axis direction;
  final Color activeColor;
  final Color inActiveColor;
  final int rateOutOf;
  final double iconSize;
  final IconData iconData;
  final EdgeInsetsGeometry entityPadding;
  final bool enableLable;
  final List<String>? lables;
  final double verticalLabelSpace;
  final double entityWidth;
  final TextStyle activeLableStyle;
  final TextStyle inActiveLableStyle;

  const Rating({
    super.key,
    required this.onChangeRating,
    this.lables,
    this.entityWidth = 40.0,
    this.initialRating = -1,
    this.enableLable = false,
    this.iconData = Icons.star,
    this.direction = Axis.horizontal,
    this.activeColor = Colors.amber,
    this.inActiveColor = Colors.grey,
    this.rateOutOf = 5,
    this.iconSize = 30.0,
    this.entityPadding = const EdgeInsets.symmetric(horizontal: 5.0),
    this.activeLableStyle = const TextStyle(
      color: Colors.amber,
    ),
    this.inActiveLableStyle = const TextStyle(
      color: Colors.grey,
    ),
    this.verticalLabelSpace = 0.0,
  });

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int rate = -1;
  late List<_RatingModel> _listOfRating;
  @override
  void initState() {
    if (widget.lables != null && widget.lables!.length == widget.rateOutOf) {
      _listOfRating = List.generate(widget.rateOutOf,
              (index) => _RatingModel(widget.lables![index], false, index));
    } else {
      _listOfRating = List.generate(
          widget.rateOutOf, (index) => _RatingModel("", false, index));
    }

    setState(() {
      rate = widget.initialRating;
      for (int i = 0; i < rate; i++) {
        _listOfRating[i].shouldCount = true;
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rateOutOf,
      shrinkWrap: true,
      scrollDirection: widget.direction,
      itemBuilder: (context, index) {
        final item = _listOfRating[index];
        return _RatingEntity(
          verticalLableSpacing: widget.verticalLabelSpace,
          activeLableStyle: widget.activeLableStyle,
          inActiveLableStyle: widget.inActiveLableStyle,
          currentRate: rate,
          enableLable: widget.enableLable,
          lable: item.review,
          padding: widget.entityPadding,
          iconData: widget.iconData,
          iconSize: widget.iconSize,
          activeColor: widget.activeColor,
          inActiveColor: widget.inActiveColor,
          onTap: () => _onRatingChange(item),
          ratingModel: _listOfRating[index],
          entityWidth: widget.entityWidth,
        );
      },
    );
  }

  void _onRatingChange(_RatingModel item) {
    setState(() {
      if (rate == item.id) {
        for (_RatingModel element in _listOfRating) {
          element.shouldCount = false;
        }
        rate = -1;
      } else {
        rate = item.id;
        for (int i = 0; i < _listOfRating.length; i++) {
          if (i <= item.id) {
            _listOfRating[i].shouldCount = true;
          } else {
            _listOfRating[i].shouldCount = false;
          }
        }
      }
    });
    widget.onChangeRating(rate + 1);
  }
}

class _RatingEntity extends StatelessWidget {
  final Function() onTap;
  final _RatingModel ratingModel;
  final Color activeColor;
  final Color inActiveColor;
  final IconData iconData;
  final double iconSize;
  final bool enableLable;
  final EdgeInsetsGeometry padding;
  final String lable;
  final double verticalLableSpacing;
  final double entityWidth;

  final TextStyle activeLableStyle;
  final TextStyle inActiveLableStyle;

  final int currentRate;
  const _RatingEntity(
      {
        required this.onTap,
        required this.enableLable,
        required this.iconData,
        required this.ratingModel,
        required this.activeColor,
        required this.inActiveColor,
        required this.iconSize,
        required this.padding,
        required this.lable,
        required this.activeLableStyle,
        required this.inActiveLableStyle,
        required this.currentRate,
        required this.verticalLableSpacing,
        required this.entityWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: entityWidth,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  onTap: onTap,
                  child: Icon(
                    iconData,
                    size: iconSize,
                    color:
                    ratingModel.shouldCount ? activeColor : inActiveColor,
                  )),
              SizedBox(
                height: verticalLableSpacing,
              ),
              enableLable
                  ? Text(lable,
                  overflow: TextOverflow.ellipsis,
                  style: ratingModel.id == currentRate
                      ? activeLableStyle
                      : inActiveLableStyle)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
class _RatingModel {
  final String review;
  bool shouldCount;
  final int id;

  _RatingModel(this.review, this.shouldCount, this.id);
}