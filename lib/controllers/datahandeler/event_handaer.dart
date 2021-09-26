import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';

class Eventhanderler {
  final String docname;
  var pethandeler = PetdbHandeler();

  Eventhanderler(this.docname);

  Future addevent(Event e) async {
    List<Event> eventlist = [];

    eventlist = await pethandeler.getEvents(docname);

    eventlist.add(e);

    await pethandeler.setEvents(docname, eventlist);
  }

  Future<List<Event>> getallevent() async {
    List<Event> eventlist = [];

    eventlist = await pethandeler.getEvents(docname);

    return eventlist;
  }
}
