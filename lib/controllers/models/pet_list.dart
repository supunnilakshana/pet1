import 'package:pet1/screens/components/dropdown_list.dart';

final List<ListItem> doglist = [
  ListItem(0, "Select pet's species"),
  ListItem(1, "Small Breed"),
  ListItem(2, "Medium"),
  ListItem(3, "Large Breed"),
  ListItem(4, "Gaint"),
];

// pet types
//dog
const int small = 1;
const int medium = 2;
const int large = 3;
const int gaint = 4;

final List<ListItem> catlist = [
  ListItem(0, "Select pet's species"),
  ListItem(1, "First Value"),
  ListItem(2, "Second Item"),
  ListItem(3, "Third Item"),
  ListItem(4, "Fourth Item"),
  ListItem(5, "s Value"),
  ListItem(6, "Secosdnd Item"),
  ListItem(10, "Third Item"),
  ListItem(7, "Fourth Item"),
  ListItem(8, "First Value"),
  ListItem(9, "Second Item"),
  ListItem(11, "Third Item"),
  ListItem(12, "Fourth Item"),
];

final List<ListItem> genderlist = [
  ListItem(0, "Select pet's gender"),
  ListItem(1, "male"),
  ListItem(2, "female"),
];

final List<VaccinedesItem> vaccineList = [
  VaccinedesItem(
      id: "0",
      name: "Rabies Vaccine",
      type: 'dog',
      description:
          "Rabies is a serious disease caused by a virus that attacks the nerves and brain of warm-blooded animals (mammals). In the United States, wild animals such as raccoons, skunks, foxes, and bats are most likely to carry rabies. Although rare, pet dogs and cats who have not been vaccinated can get it.",
      imgurl: "assets/images/rabiesvaccine.jpg"),
  VaccinedesItem(
      id: "1",
      name: "Parvovirus Vaccine",
      type: 'dog',
      description:
          "Rabies is a serious disease caused by a virus that attacks the nerves and brain of warm-blooded animals (mammals). In the United States, wild animals such as raccoons, skunks, foxes, and bats are most likely to carry rabies. Although rare, pet dogs and cats who have not been vaccinated can get it.",
      imgurl: "assets/images/parvovirusvaccine.jpg"),
  VaccinedesItem(
      id: "2",
      name: "DHL Vaccine",
      type: 'dog',
      description:
          "Rabies is a serious disease caused by a virus that attacks the nerves and brain of warm-blooded animals (mammals). In the United States, wild animals such as raccoons, skunks, foxes, and bats are most likely to carry rabies. Although rare, pet dogs and cats who have not been vaccinated can get it.",
      imgurl: "assets/images/dhlvaccinepng.png"),
  VaccinedesItem(
      id: "3",
      name: "Anti-Rabies Vaccine",
      type: 'cat',
      description: "description",
      imgurl: "assets/images/antiRabiesVaccine.jpg"),
  VaccinedesItem(
      id: "4",
      name: "Tricat Vaccine",
      type: 'cat',
      description: "description",
      imgurl: "assets/images/tricat.jpg")
];

class VaccinedesItem {
  final String id;
  final String name;
  final String type;
  final String description;
  final String imgurl;

  VaccinedesItem(
      {required this.id,
      required this.name,
      required this.type,
      required this.description,
      this.imgurl = "assets/icons/vaccineiconnon.png"});
}

final List<String> homeAnimation = [
  'assets/animations/homeanimi1.json',
  'assets/animations/homeanimi2.json',
  'assets/animations/homeanimi3.json',
  'assets/animations/homeanimi4.json',
  'assets/animations/homeanimi5.json',
  'assets/animations/peteventhome.json',
  'assets/animations/homeanimi6.json',
  'assets/animations/homeanimi7.json',
  'assets/animations/homeanimi8.json',
];
