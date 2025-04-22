import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rover_mars/cubit/nasa_cubit.dart';
import 'package:rover_mars/cubit/nasa_state.dart';
import 'package:rover_mars/screens/photo_info_screen.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Фотки Масяни'), centerTitle: true),
      body: BlocProvider(
        create: (context) => NasaCubit()..loadData(),
        child: BlocBuilder<NasaCubit, NasaState>(
          builder: (context, state) {
            if (state is NasaLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NasaErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ошибка загрузки данных'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<NasaCubit>().loadData(),
                      child: const Text('Ну попробуй еще'),
                    ),
                  ],
                ),
              );
            } else if (state is NasaLoadedState) {
              final photos = state.data.photos;
              if (photos == null || photos.isEmpty) {
                return const Center(child: Text('Нету фотак'));
              }
              return ListView.builder(
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoInfoScreen(photo: photo),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.network(
                            photo.imgSrc ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                            loadingBuilder: (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                          : null,
                                ),
                              );
                            },
                            errorBuilder: (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              return Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey[500],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sol: ${photo.sol} | Камера: ${photo.camera?.fullName ?? 'Неизвестно'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
