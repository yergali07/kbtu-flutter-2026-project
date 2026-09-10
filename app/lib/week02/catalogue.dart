import 'models.dart';

class Library {
  final List<LibraryItem> items = [];

  late final DateTime openedAt;
  bool isOpen = false;

  String? _cachedReport;

  void add(LibraryItem item) {
    items.add(item);
    _cachedReport = null;
  }

  void open() {
    if (isOpen) return;
    openedAt = DateTime.now();
    isOpen = true;
  }

  List<Book> get books => items.whereType<Book>().toList();

  Book? findByTitle(String title) {
    for (final book in books) {
      if (book.title == title) return book;
    }
    return null;
  }

  String countryOf(String title) =>
      findByTitle(title)?.author.country ?? 'unknown';

  String describeOf(String title) {
    final book = findByTitle(title);
    if (book == null) return 'no such book';

    final description = book.description;
    if (description == null) return book.describe();

    return '${book.describe()} - $description';
  }

  List<String> get allTitles => items.map((item) => item.title).toList();

  List<Book> get publishedAfter2010 =>
      books.where((book) => book.year > 2010).toList();

  // fold and not reduce: reduce crashes on an empty list and its result must
  // stay a Book, but here we add up ints, so we need fold's starting value 0.
  double get averagePages => books.isEmpty
      ? 0
      : books.fold(0, (sum, book) => sum + book.pages) / books.length;

  Map<String, int> get booksByAuthor => {
    for (final name in authorNames)
      name: books.where((book) => book.author.name == name).length,
  };

  Set<String> get authorNames => books.map((book) => book.author.name).toSet();

  Set<Genre> get genres => books.map((book) => book.genre).toSet();

  List<String> get displayLines => [
    'CATALOGUE',
    for (final book in books) '${book.title} (${book.year})',
    ...authorNames,
    if (books.any((book) => book.pages == 0)) '(incomplete data)',
  ];

  String report() => _cachedReport ??= displayLines.join('\n');
}
