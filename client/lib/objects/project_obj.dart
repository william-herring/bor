class Project {
  final String title;
  final String description;
  final String teamCode;
  final bool open;

  Project({
    required this.title,
    required this.description,
    required this.open,
    required this.teamCode
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        title: json['title'],
        description: json['description'],
        open: json['open'],
        teamCode: json['team_code'],
    );
  }
}