class Meta {
  final int itemsPerPage;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  Meta(this.itemsPerPage, this.totalItems, this.currentPage, this.totalPages);

  Meta.fromJson(Map<String, dynamic> json)
      : itemsPerPage = json['itemsPerPage'],
        totalItems = json['totalItems'],
        currentPage = json['currentPage'],
        totalPages = json['totalPages'];
}
