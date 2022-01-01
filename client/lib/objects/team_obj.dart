//Due to a bug in the dartServer analysis-driver, you must import dart:core as "core"
import 'dart:core' as core;

class Team {
  final core.int id;
  final core.String code;
  final core.String title;
  final core.String leader;
  final core.String members; //TODO: Change to List<String>

  Team({
    required this.id,
    required this.code,
    required this.title,
    required this.leader,
    required this.members
  });

  factory Team.fromJson(core.Map<core.String, core.dynamic> json) {
    return Team(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      leader: json['leader'],
      members: json['members'],
    );
  }
}