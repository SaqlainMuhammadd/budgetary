class IncomeData {
  final double amount;
  final String name;
  final DateTime date;
  final DateTime time;

  final String category;
  final String imageurl;

  IncomeData({
    required this.amount,
    required this.name,
    required this.date,
    required this.time,
    required this.category,
    required this.imageurl,
  });
}

class IncomeDataCategory {
  final String id;
  final List<dynamic> subcatagories;

  final String name;
  final String image;

  IncomeDataCategory(
      {required this.name,
      required this.image,
      required this.subcatagories,
      required this.id});
  static List<IncomeDataCategory> incomeCategories = [
    IncomeDataCategory(
      name: 'Bank',
      image: 'assets/images/fiance.png',
      id: 'diugcweuigceyfywifyiwu',
      subcatagories: [],
    ),
    IncomeDataCategory(
      name: 'Cash',
      image: 'assets/images/income.png',
      id: 'diugcweuigceyfywifeieu',
      subcatagories: [],
    ),
    IncomeDataCategory(
      name: 'Others',
      image: 'assets/images/others.png',
      id: 'diugcweuigjhcfhdcfcdd',
      subcatagories: [],
    ),
  ];
}

class ExpenceDataCategory {
  final String id;
  final List<dynamic> subcatagories;

  final String name;
  final String image;

  ExpenceDataCategory(
      {required this.name,
      required this.image,
      required this.subcatagories,
      required this.id});
  static List<ExpenceDataCategory> expenceCategories = [
    ExpenceDataCategory(
      name: 'Food/Drink',
      image: 'assets/images/food.png',
      id: 'diugcweuigceyfywifyiwu',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Family',
      image: 'assets/images/family.png',
      id: 'diugcweuigceyfywifeieu',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Home',
      image: 'assets/images/home.png',
      id: 'diugcweuigjhcfhdcfcdd',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Health',
      image: 'assets/images/health.png',
      id: 'diugcweuyuyhcfhdcfcdd',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Pets',
      image: 'assets/images/pets.png',
      id: 'diugyuuuyuyhcfhdcfcdd',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Shopping',
      image: 'assets/images/shopping.png',
      id: 'diugyuqqyuyhcfhdcfcdd',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Transport',
      image: 'assets/images/transport.png',
      id: 'diugyuqqyuyhcfhdcfcdd',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Travelling',
      image: 'assets/images/travel.png',
      id: 'diugyuccyuyhcfhdcfcdd',
      subcatagories: [],
    ),
    ExpenceDataCategory(
      name: 'Others',
      image: 'assets/images/others.png',
      id: 'diugyujjyuyhcfhdcfcdd',
      subcatagories: [],
    ),
  ];
}

List<String> iconList = [
  "assets/snabbicons/water  bill.png",
  "assets/snabbicons/shopping.png",
  "assets/snabbicons/tech.png",
  "assets/snabbicons/travel.png",
  "assets/snabbicons/rent.png",
  "assets/snabbicons/salary.png",
  "assets/snabbicons/rent.png",
  "assets/snabbicons/pet.png",
  "assets/snabbicons/personal savings.png",
  "assets/snabbicons/pension.png",
  "assets/snabbicons/others.png",
  "assets/snabbicons/clothing.png",
  "assets/snabbicons/children.png",
  "assets/snabbicons/others.png",
  "assets/snabbicons/entertainment.png",
  "assets/snabbicons/family.png",
  "assets/snabbicons/food drink.png",
  "assets/snabbicons/food drink(eating out).png",
  "assets/snabbicons/others.png",
  "assets/snabbicons/accomodation.png",
  "assets/snabbicons/others.png",
];
