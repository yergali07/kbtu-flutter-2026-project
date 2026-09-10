import 'models.dart';

sealed class ShelfState {
  const ShelfState();
}

class Empty extends ShelfState {
  const Empty();
}

class Ready extends ShelfState {
  const Ready(this.books);

  final List<Book> books;
}

class Broken extends ShelfState {
  const Broken(this.message);

  final String message;
}

String describe(ShelfState state) => switch (state) {
  Empty() => 'Shelf is empty',
  Ready(books: final books) => 'Shelf is ready with ${books.length} book(s)',
  Broken(message: final message) => 'Shelf is broken: $message',
};

({int count, double avgPages}) statsOf(List<Book> books) {
  if (books.isEmpty) return (count: 0, avgPages: 0);

  var total = 0;
  for (final book in books) {
    total += book.pages;
  }
  return (count: books.length, avgPages: total / books.length);
}
