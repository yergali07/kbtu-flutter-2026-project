// ignore_for_file: avoid_print

import 'catalogue.dart';
import 'data.dart';
import 'models.dart';
import 'shelf_state.dart';

void main() {
  final library = Library();
  library.open();

  for (final json in rawBooks) {
    library.add(Book.fromJson(json));
  }
  library.add(const Magazine(title: 'Dart Weekly', year: 2024, issue: 42));
  library.add(const Ghost(title: 'The Lost Manual', year: 1987));

  print('Opened at: ${library.openedAt}');
  print('');

  print(library.report());
  print('');

  print('All titles: ${library.allTitles}');
  print('After 2010: ${library.publishedAfter2010}');
  print('Average pages: ${library.averagePages}');
  print('Books by author: ${library.booksByAuthor}');
  print('Author names: ${library.authorNames}');
  print('Genres: ${library.genres}');
  print('');

  print('Country of Refactoring: ${library.countryOf('Refactoring')}');
  print('Country of Design Patterns: ${library.countryOf('Design Patterns')}');
  print('Country of Nothing Here: ${library.countryOf('Nothing Here')}');
  print('Describe Refactoring: ${library.describeOf('Refactoring')}');
  print('Find missing title: ${library.findByTitle('Nothing Here')}');
  print('');

  final cleanCode = library.findByTitle('Clean Code');
  if (cleanCode == null) {
    print('Clean Code is not in the library');
  } else {
    print(cleanCode.describe());
    print(cleanCode.borrowLabel());
    print('isLong: ${cleanCode.isLong}, isOld: ${cleanCode.isOld}');
    print('copyWith: ${cleanCode.copyWith(year: 2009, pages: 500)}');
  }
  print('');

  for (final item in library.items) {
    print('${item.describe()} (old: ${item.isOld})');
  }
  print('');

  final stats = statsOf(library.books);
  print('Stats record: $stats');
  print('count = ${stats.count}');
  print('avgPages = ${stats.avgPages}');
  print('');

  print(describe(const Empty()));
  print(describe(Ready(library.books)));
  print(describe(const Broken('water damage on shelf 3')));
}
