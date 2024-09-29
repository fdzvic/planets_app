import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/paths/paths_images.dart';

class CardPlanet extends StatelessWidget {
  const CardPlanet({
    super.key,
    this.name,
    this.diameter,
    this.mass,
    this.pathImage,
  });

  final String? name;
  final String? diameter;
  final String? mass;
  final String? pathImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.blue4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
            child: Hero(
              tag: "img_hero",
              child: Image.network(
                pathImage ?? "",
                width: 120,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    images.noImageAvailable,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  name,
                  height: 1.5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
