class HelpSeekerProfile {
  final String name;
  final String description;
  final String country;
  final String experience;
  final String skills;
  final double rating;
  final String? imageUrl;

  HelpSeekerProfile({
    this.imageUrl,
    required this.name,
    required this.description,
    required this.country,
    required this.experience,
    required this.skills,
    required this.rating,
  });
}
