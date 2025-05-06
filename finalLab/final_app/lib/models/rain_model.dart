class Rain {
  final double? last1h;
  final double? last3h;

  Rain({this.last1h, this.last3h});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      last1h: json['1h']?.toDouble(),
      last3h: json['3h']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    '1h': last1h,
    '3h': last3h,
  };
}