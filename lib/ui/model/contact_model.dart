import 'package:alison/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  late final List<Contact> _contact = List.generate(100, (index) {
    return Contact(
      name: "${faker.person.firstName()} ${faker.person.lastName()}",
      email: faker.internet.email(),
      phoneNumber: faker.randomGenerator.integer(3999999999).toString(),
    );
  });

  List<Contact> get contacts => _contact;

  void changeFavoriteStatus(int index) {
    _contact[index].isFavorite = !_contact[index].isFavorite;
    _sortContact();
    notifyListeners();
  }

  void _sortContact() {
    _contact.sort(((a, b) {
      int comparisionResult = compareBasedOnFavoriteStatus(a, b);
      if (comparisionResult == 0) {
        comparisionResult = compareAlphabetically(a, b);
      }
      return comparisionResult;
    }));
  }

  int compareBasedOnFavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      return -1;
    } else if (b.isFavorite) {
      return 1;
    } else {
      return 0;
    }
  }

  int compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
}
