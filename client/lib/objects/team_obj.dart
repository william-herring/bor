class Team {
  final int id;
  final String code;
  final String title;
  final String leader;
  final String members; //TODO: Change to List<String>

  Team({
    required this.id,
    required this.code,
    required this.title,
    required this.leader,
    required this.members
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      leader: json['leader'],
      members: json['members'],
    );
  }
}