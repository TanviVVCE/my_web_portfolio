import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? longDescription;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String category;
  final bool featured;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    this.longDescription,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    required this.category,
    this.featured = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    longDescription,
    imageUrl,
    technologies,
    githubUrl,
    liveUrl,
    category,
    featured,
  ];
}
