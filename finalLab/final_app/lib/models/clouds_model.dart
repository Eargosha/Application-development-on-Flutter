class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all'] ?? 0);
  }

  Map<String, dynamic> toJson() => {'all': all};
}