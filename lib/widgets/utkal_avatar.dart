import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar on 07-07-2020 06:14 PM.
///
class ExellenticoCircleAvatar extends StatelessWidget {
  final String userId;
  final String name;
  final String imageUrl;
  final double radius;
  const ExellenticoCircleAvatar(this.imageUrl,
      {this.userId, this.name, this.radius});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Hero(
      tag: userId ?? UniqueKey().toString(),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        imageBuilder: (context, provider) => CircleAvatar(
          backgroundImage: provider,
          radius: radius ?? 32,
        ),
        errorWidget: (c, s, d) => AvatarPlaceholder(
          name ?? 'U',
          backgroundColor: colorScheme.primary,
          radius: radius ?? 32,
          textColor: Colors.white,
        ),
        placeholder: (context, url) => AvatarPlaceholder(
          name ?? 'U',
          backgroundColor: colorScheme.primary,
          radius: radius ?? 32,
          textColor: Colors.white,
        ),
      ),
    );
  }
}

class AvatarPlaceholder extends StatelessWidget {
  final String firstLetter;
  final double radius;
  final Color backgroundColor, textColor;
  AvatarPlaceholder(this.firstLetter,
      {this.radius, this.backgroundColor, this.textColor})
      : assert(firstLetter != null, firstLetter.isNotEmpty);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CircleAvatar(
      child: Text(
        firstLetter.toUpperCase()[0],
        style: TextStyle(fontSize: 24, color: textColor ?? Colors.white),
      ),
      backgroundColor: backgroundColor ?? colorScheme.primary,
      radius: radius ?? 32,
    );
  }
}
