import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';



class ProfileAvatar extends StatelessWidget {

  const ProfileAvatar({
    super.key,
    this.image,
    this.onImageTap,
  });



  final dynamic image;

  /// سيتم استخدامه لاحقاً عند إضافة تعديل الصورة
  final VoidCallback? onImageTap;



  @override
  Widget build(BuildContext context) {


    final scheme = context.scheme;



    return Stack(

      clipBehavior:
      Clip.none,


      children:[



        Container(

          padding:
          const EdgeInsets.all(5),


          decoration:
          BoxDecoration(

            shape:
            BoxShape.circle,


            color:
            Colors.white,


            boxShadow:[

              BoxShadow(

                color:
                scheme.shadow
                .withValues(alpha:0.14),


                blurRadius:
                18,


                offset:
                const Offset(0,8),

              ),

            ],

          ),



          child: CircleAvatar(

            radius:56,


            backgroundColor:
            scheme.primary
            .withValues(alpha:0.08),


            backgroundImage:
            _resolveImage(),


            child:
            _resolveImage() == null

            ? Icon(

              Icons.person_outline,

              size:48,

              color:
              scheme.primary,

            )

            : null,


          ),

        ),




        PositionedDirectional(

          bottom:2,

          end:2,


          child: InkWell(

            onTap:
            onImageTap,


            borderRadius:
            BorderRadius.circular(20),



            child: Container(

              width:30,

              height:30,


              decoration:
              BoxDecoration(

                color:
                Colors.white,


                shape:
                BoxShape.circle,


                boxShadow:[

                  BoxShadow(

                    color:
                    scheme.shadow
                    .withValues(alpha:0.12),


                    blurRadius:
                    12,


                    offset:
                    const Offset(0,4),

                  ),

                ],

              ),


              child: Icon(

                Icons.camera_alt_outlined,

                size:15,


                color:
                scheme.primary,

              ),

            ),

          ),

        ),



      ],

    );
  }





  ImageProvider? _resolveImage(){


    if(image == null){
      return null;
    }



    if(image is String && image.isNotEmpty){

      return NetworkImage(image);

    }


    return null;

  }
}