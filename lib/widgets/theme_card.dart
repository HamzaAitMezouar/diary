import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCard extends StatelessWidget {
  final Size size;
  final String title;
  final String image;
  final String desc;
  final String background;
  final String? subtitle;
  final bool connected;
  final Function() click;
  final Color? textColor;
  final Color? locationColor;
  final Color? iconColor;
  const AppCard(
      {super.key,
      required this.desc,
      required this.connected,
      this.subtitle,
      required this.background,
      required this.click,
      required this.image,
      required this.size,
      this.textColor,
      this.locationColor,
      this.iconColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: click,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  image: AssetImage(
                    background,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(left: 25, top: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    desc,
                    maxLines: 3,
                    style: GoogleFonts.abel(
                      color: textColor ?? Colors.black,
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: size.height * 0.05,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: locationColor ?? Colors.black.withOpacity(0.2),
                        ),
                        Expanded(
                          child: Text(
                            'Casablanca, Maroc',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: '',
                              color: locationColor ?? const Color.fromARGB(255, 58, 57, 57).withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: size.height * 0.08,
                    child: Row(
                      children: [
                        Badge(
                          backgroundColor: connected == true ? Colors.green : const Color.fromARGB(255, 236, 16, 0),
                          largeSize: 14,
                          smallSize: 14,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: iconColor ?? const Color.fromARGB(255, 235, 230, 230),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    image,
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.aBeeZee(
                                  color: textColor ?? Colors.black,
                                  textStyle: Theme.of(context).textTheme.displayLarge,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                subtitle ?? 'G4S',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.aBeeZee(
                                  color: textColor ?? Colors.black.withOpacity(0.5),
                                  textStyle: Theme.of(context).textTheme.displayLarge,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
