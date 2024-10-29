import 'package:flutter/material.dart';

void main() {
  runApp(const NotasApp());
}

class NotasApp extends StatelessWidget {
  const NotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotaScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotaScreen extends StatefulWidget {
  const NotaScreen({super.key});

  @override
  State<NotaScreen> createState() => _NotasState();
}

class _NotasState extends State<NotaScreen> {
  final List<String> _iconUrls = [
    'https://cdn.pixabay.com/photo/2022/11/25/09/33/car-7615816_1280.jpg',
    'https://cdn.pixabay.com/photo/2024/10/17/16/14/waterfall-9128051_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/11/07/06/52/forest-8371211_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/10/27/20/11/crow-8346196_1280.jpg',
    'https://cdn.pixabay.com/photo/2024/09/19/07/30/horses-9057949_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/10/29/05/11/autumn-7554430_1280.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galería"),
      ),
      body: _buildImageGrid(orientacion),
      backgroundColor: const Color.fromARGB(255, 206, 201, 236),
    );
  }

  /// Genera una cuadrícula de imágenes.
  Widget _buildImageGrid(Orientation orientacion) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientacion == Orientation.portrait ? 2 : 3, // Número de columnas
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _iconUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ImagenPantalla(
                  imageUrl: _iconUrls[index],
                ),
              ),
            );
            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Botón $result')),
              );
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              _iconUrls[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class ImagenPantalla extends StatelessWidget {
  final String imageUrl;

  const ImagenPantalla({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen Detallada'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
