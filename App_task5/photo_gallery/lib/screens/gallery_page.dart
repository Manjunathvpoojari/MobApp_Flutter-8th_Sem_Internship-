import 'package:flutter/material.dart';
import 'full_view_page.dart';

class GalleryPage extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
  ];

  void showOptions(BuildContext context, int index, Color color) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.fullscreen),
              title: Text("View Full"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullViewPage(color: color, photoNumber: index + 1),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Shared Photo ${index + 1}")),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted Photo ${index + 1}")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Gallery")),

      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return GestureDetector(
            onTap: () {
              showOptions(context, index, colors[index]);
            },

            child: Stack(
              children: [
                Container(margin: EdgeInsets.all(8), color: colors[index]),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    "Photo ${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
