import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';

class Eventhanderler {
  final String docname;
  var pethandeler = PetdbHandeler();

  Eventhanderler(this.docname);

  addevent(Event e) async {
    List<Event> eventlist = [];
    print("pass");
    eventlist = await pethandeler.getEvents(docname);
    print("pass");
    eventlist.add(e);
    print("pass");
    await pethandeler.setEvents(docname, eventlist);
    print("pass");
  }
}
