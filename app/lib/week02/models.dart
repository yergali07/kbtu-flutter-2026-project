abstract class LibraryItem {
  const LibraryItem({required this.title, required this.year});

  final String title;
  final int year;

  String describe();

  bool get isOld => year < 2000;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrow: $title';
}

class Author {
  const Author({required this.name, this.country});

  final String name;
  final String? country;

  @override
  String toString() => 'Author($name, ${country ?? 'unknown'})';
}

enum Genre {
  craft('Craft'),
  theory('Theory'),
  unknown('Unknown');

  const Genre(this.label);

  final String label;

  static Genre fromString(String? raw) {
    if (raw == 'craft') return Genre.craft;
    if (raw == 'theory') return Genre.theory;
    return Genre.unknown;
  }
}

class Book extends LibraryItem with Borrowable {
  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final Object? title = json['title'];
    final Object? year = json['year'];
    final Object? pages = json['pages'];
    final Object? author = json['author'];
    final Object? country = json['country'];
    final Object? genre = json['genre'];
    final Object? description = json['description'];

    return Book(
      title: title is String ? title : 'Untitled',
      year: year is int ? year : 0,
      pages: pages is int ? pages : 0,
      author: Author(
        name: author is String ? author : 'Unknown',
        country: country is String ? country : null,
      ),
      genre: Genre.fromString(genre is String ? genre : null),
      description: description is String ? description : null,
    );
  }

  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String describe() => '$title ($year) by ${author.name} - ${genre.label}';

  @override
  String toString() =>
      'Book($title, $year, $pages p., ${author.name}, ${genre.label})';
}

class Magazine extends LibraryItem {
  const Magazine({
    required super.title,
    required super.year,
    required this.issue,
  });

  final int issue;

  @override
  String describe() => '$title #$issue ($year)';

  @override
  String toString() => 'Magazine($title #$issue, $year)';
}

class Ghost implements LibraryItem {
  const Ghost({required this.title, required this.year});

  @override
  final String title;

  @override
  final int year;

  @override
  String describe() => '$title ($year) - missing from the shelves';

  @override
  bool get isOld => true;

  @override
  String toString() => 'Ghost($title, $year)';
}
