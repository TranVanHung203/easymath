class ChucDonvi {
  final String name;
  final String url;
  final int number;

  const ChucDonvi({
    required this.name,
    required this.url,
    required this.number,
  });

  factory ChucDonvi.fromJson(Map<String, dynamic> json) => ChucDonvi(
    name: json['name'] as String,
    url: json['url'] as String,
    number: (json['number'] as num).toInt(),
  );

  Map<String, dynamic> toJson() => {'name': name, 'url': url, 'number': number};
}
