import 'package:alison/data/contact.dart';
import 'package:alison/data/db/contact_dao.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  final ContactDao _contactDao = ContactDao();
  List<Contact> _contact = [
    Contact(name: "Dimmy", email: "Dummy", phoneNumber: "Dummy")
  ];

  List<Contact> get contacts => _contact;

  bool _isLoading = true;
  bool get isloading => _isLoading;

  Future loadContact() async {
    _isLoading = true;
    notifyListeners();
    _contact = await _contactDao.getAllInSortedOrder();
    _isLoading = false;
    notifyListeners();
  }

  Future addContact(Contact contact) async {
    await _contactDao.insert(contact);
    await loadContact();
    notifyListeners();
  }

  Future editContact(Contact contact) async {
    print("Contact saving...");
    await _contactDao.update(contact);
    print("Contact saved , Loading...");
    await loadContact();
    print("Contact Load");
    notifyListeners();
  }

  Future deleteContact(Contact contact) async {
    await _contactDao.delete(contact);
    await loadContact();
    notifyListeners();
  }

  Future changeFavoriteStatus(Contact contact) async {
    contact.isFavorite = !contact.isFavorite;
    await _contactDao.update(contact);
    await _contactDao.getAllInSortedOrder();
    notifyListeners();
  }
}
