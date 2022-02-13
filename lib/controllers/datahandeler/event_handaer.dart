import 'package:pet1/controllers/firedbhandeler/pethandeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';

class Eventhanderler {
  final String docname;
  var pethandeler = PetdbHandeler();

  Eventhanderler(this.docname);

  Future addevent(EventModel e) async {
    List<EventModel> eventlist = [];

    eventlist = await pethandeler.getEvents(docname);

    eventlist.add(e);

    await pethandeler.setEvents(docname, eventlist);
  }

  Future<List<EventModel>> getallevent() async {
    List<EventModel> eventlist = [];

    eventlist = await pethandeler.getEvents(docname);

    return eventlist;
  }
}
