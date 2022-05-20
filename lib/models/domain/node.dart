class Node {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String baseUrl;

  Node(this.id, this.createdAt, this.updatedAt, this.baseUrl);

  Node.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        baseUrl = json['attributes']['baseUrl'];

  Map<String, dynamic> toJson() => {
        'type': 'node',
        'id': id,
        'attributes': {
          'baseUrl': baseUrl,
        }
      };
}
