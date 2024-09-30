import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/paths/paths_images.dart';

class CardPlanet extends StatelessWidget {
  const CardPlanet({
    super.key,
    this.name,
    this.pathImage,
    this.imageHeight,
  });

  final String? name;
  final String? pathImage;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.blue4,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: imageHeight,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
              child: Image.network(
                pathImage ?? "",
                loadingBuilder: (context, child, loadingProgress) =>
                    const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
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
          const Expanded(child: SizedBox(height: 10)),
          CustomText(
            name,
            height: 1.5,
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
