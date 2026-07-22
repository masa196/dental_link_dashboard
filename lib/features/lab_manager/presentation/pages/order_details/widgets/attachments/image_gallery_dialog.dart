// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ImageGalleryDialog extends StatefulWidget {
  const ImageGalleryDialog({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  final List<String> images;

  final int initialIndex;

  @override
  State<ImageGalleryDialog> createState() =>
      _ImageGalleryDialogState();
}


class _ImageGalleryDialogState extends State<ImageGalleryDialog> {

  late PageController _pageController;

  late int currentIndex;


  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    _pageController = PageController(
      initialPage: currentIndex,
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void _next() {

    if (currentIndex < widget.images.length - 1) {

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }



  void _previous() {

    if (currentIndex > 0) {

      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }



  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,

      insetPadding: const EdgeInsets.all(24),

      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 900,
          maxHeight: 700,
        ),

        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),


        child: Stack(
          children: [


            //--------------------------------------------------
            // Images
            //--------------------------------------------------

            PageView.builder(

              controller: _pageController,

              itemCount: widget.images.length,


              onPageChanged: (index){

                setState(() {
                  currentIndex = index;
                });

              },


              itemBuilder: (context,index){

                return InteractiveViewer(

                  child: Center(

                    child: Image.network(
                      widget.images[index],

                      fit: BoxFit.contain,


                      errorBuilder:
                          (context,error,stackTrace){

                        return const Icon(
                          Icons.broken_image,
                          color: Colors.white,
                          size: 60,
                        );
                      },

                    ),

                  ),
                );
              },

            ),



            //--------------------------------------------------
            // Close Button
            //--------------------------------------------------

            Positioned(
              top: 16,
              right: 16,

              child: IconButton(

                onPressed: (){
                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),




            //--------------------------------------------------
            // Previous Button
            //--------------------------------------------------

            if(currentIndex > 0)

              Positioned(
                left: 16,
                top: 0,
                bottom: 0,

                child: Center(

                  child: _NavigationButton(
                    icon: Icons.chevron_left,
                    onTap: _previous,
                  ),

                ),
              ),





            //--------------------------------------------------
            // Next Button
            //--------------------------------------------------

            if(currentIndex < widget.images.length - 1)

              Positioned(
                right: 16,
                top: 0,
                bottom: 0,

                child: Center(

                  child: _NavigationButton(
                    icon: Icons.chevron_right,
                    onTap: _next,
                  ),

                ),
              ),




            //--------------------------------------------------
            // Counter
            //--------------------------------------------------

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,


              child: Center(

                child: Container(

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),


                  decoration: BoxDecoration(

                    color:
                    Colors.black.withOpacity(.5),

                    borderRadius:
                    BorderRadius.circular(20),

                  ),


                  child: Text(

                    "${currentIndex + 1} / ${widget.images.length}",

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



class _NavigationButton extends StatelessWidget {

  const _NavigationButton({
    required this.icon,
    required this.onTap,
  });


  final IconData icon;

  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,


      child: Container(

        width: 45,
        height: 45,


        decoration: BoxDecoration(

          color:
          Colors.black.withOpacity(.45),

          shape: BoxShape.circle,

        ),


        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),

      ),
    );
  }
}