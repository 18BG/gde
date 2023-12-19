// import 'package:flutter/material.dart';

// class PublicationWidget extends StatelessWidget {
//   PublicationWidget({
//     Key? key,
//     required this.imagesrc,
//     required this.description,
//     required this.username,
//     required this.structureName,
//     this.listimage,
//   }) : super(key: key);

//   final String imagesrc;
//   final String description;
//   final String structureName;
//   final String username;
//   final List<String>? listimage;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(width: 2, color: Colors.blue),
//                 ),
//                 child: ClipOval(
//                   child: Image.network(
//                     imagesrc,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     structureName,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     username,
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 16),
//           listimage != null
//               ? SizedBox(
//                   height: 120,
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 8,
//                     ),
//                     itemCount: listimage!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           listimage![index],
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               : Container(),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildButton("Like", Icons.thumb_up),
//               _buildButton("Comment", Icons.comment),
//               _buildButton("Share", Icons.share),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton(String label, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.grey),
//         SizedBox(width: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:gde/models/publication_model.dart';
import 'package:gde/widgets/mytext.dart';

class PublicationWidget extends StatelessWidget {
  PublicationWidget(
      {Key? key,
      required this.username,
      this.listimage,
      required this.publication})
      : super(key: key);

  final String username;
  final List<String>? listimage;
  final Publication publication;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.blue),
                ),
                child: ClipOval(
                  child: Image.network(
                    publication.structure!.logo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      publication.structure!.nom,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      publication.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    CText(
                      username,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            publication.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          listimage != null ? _buildImageGrid(context) : Container(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _buildButton("Like", Icons.thumb_up),
              _buildButton("Comment", Icons.comment),
              const SizedBox(
                width: 15,
              ),
              _buildButton("Share", Icons.share),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    if (listimage != null && listimage!.isNotEmpty) {
      return Wrap(
        spacing: 6.0,
        runSpacing: 8.0,
        children: listimage!.map((imageUrl) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: (MediaQuery.of(context).size.width - 45) /
                  min(listimage!.length, 3),
              height: (MediaQuery.of(context).size.width - 45) /
                  min(listimage!.length, 3),
            ),
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}
