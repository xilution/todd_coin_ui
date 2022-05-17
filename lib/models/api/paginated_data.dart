class PaginatedData<T> {
  final int itemsPerPage;
  final int totalItems;
  final int currentPage;
  final int totalPages;
  final List<T> rows;

  PaginatedData(this.itemsPerPage, this.totalItems, this.currentPage,
      this.totalPages, this.rows);
}
