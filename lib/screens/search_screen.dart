import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/gradient_background.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = "";
  String _selectedGenre = "Semua";

  List<String> get _availableGenres {
    Set<String> genres = {"Semua"};
    for (var movie in allMovies) {
      genres.addAll(movie.genres);
    }
    return genres.toList();
  }

  List<Movie> get _filteredMovies {
    return allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesGenre =
          _selectedGenre == "Semua" || movie.genres.contains(_selectedGenre);

      return matchesSearch && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Cari Film',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Ketik judul film...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _availableGenres.length,
                  itemBuilder: (context, index) {
                    final genre = _availableGenres[index];
                    final isSelected = genre == _selectedGenre;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(genre),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedGenre = selected ? genre : "Semua";
                          });
                        },
                        selectedColor: Colors.blueAccent,

                        backgroundColor: Colors.black.withOpacity(0.4),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[300],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.white38,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: _filteredMovies.isEmpty
                    ? const Center(
                        child: Text(
                          "Film tidak ditemukan",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                          
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: _filteredMovies.length,
                        itemBuilder: (context, index) {
                          final movie = _filteredMovies[index];
                          return _buildMovieCard(movie, context);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(Movie movie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                movie.imageUrl,
                width: 80,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.releaseYear,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
