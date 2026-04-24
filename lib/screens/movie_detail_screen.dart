import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/movie.dart';
import '../widgets/gradient_background.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  late YoutubePlayerController _youtubeController;

  int _likes = 142;
  int _neutrals = 35;
  int _dislikes = 8;
  String _selectedReaction = "";

  List<String> comments = [
    "Keren sih tapi masih kurang keren",
    "Gaperlu masuk kelas karna udah berkelas",
    "Kata Ryan Keren",
    "Kata Rayhan GG",
    "Kata Rava PCnya ngelag",
    "Kata Doni HomeSick",
    "Kata Maskel dah oke lek",
  ];

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerUrl);
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        comments.insert(0, _commentController.text.trim());
        _commentController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  void _handleReaction(String type) {
    setState(() {
      if (_selectedReaction == "like") _likes--;
      if (_selectedReaction == "neutral") _neutrals--;
      if (_selectedReaction == "dislike") _dislikes--;

      if (_selectedReaction == type) {
        _selectedReaction = "";
      } else {
        _selectedReaction = type;
        if (type == "like") _likes++;
        if (type == "neutral") _neutrals++;
        if (type == "dislike") _dislikes++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    widget.movie.imageUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [const Color(0xFF0A002A), Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white54,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.releaseYear,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.access_time,
                          color: Colors.white54,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.duration,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          widget.movie.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 8,
                      children: widget.movie.genres
                          .map(
                            (genre) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                genre,
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 25),
                    Text(
                      "Sutradara : ${widget.movie.director}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Aktor        : ${widget.movie.actors}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 25),

                    const Text(
                      "SINOPSIS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.movie.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      "TRAILER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      "REAKSI ANDA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildReactionButton(
                          icon: Icons.thumb_up_alt_rounded,
                          label: "Suka",
                          count: _likes,
                          isSelected: _selectedReaction == "like",
                          activeColor: Colors.greenAccent,
                          onTap: () => _handleReaction("like"),
                        ),
                        _buildReactionButton(
                          icon: Icons.sentiment_neutral_rounded,
                          label: "Biasa",
                          count: _neutrals,
                          isSelected: _selectedReaction == "neutral",
                          activeColor: Colors.amberAccent,
                          onTap: () => _handleReaction("neutral"),
                        ),
                        _buildReactionButton(
                          icon: Icons.thumb_down_alt_rounded,
                          label: "Kurang",
                          count: _dislikes,
                          isSelected: _selectedReaction == "dislike",
                          activeColor: Colors.redAccent,
                          onTap: () => _handleReaction("dislike"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Divider(color: Colors.white10, thickness: 1),
                    const SizedBox(height: 20),

                    const Text(
                      "KOMENTAR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Tulis pendapatmu...",
                              hintStyle: const TextStyle(color: Colors.white38),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.05),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                            onPressed: _addComment,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: comments.map((comment) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent.withOpacity(
                                  0.2,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Guest User",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      comment,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReactionButton({
    required IconData icon,
    required String label,
    required int count,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? activeColor : Colors.white10,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? activeColor : Colors.white54,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count.toString(),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
