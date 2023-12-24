class City {
  String city;
  String? tempc;
  String? condition;

  City({ this.condition,  this.tempc, required this.city});

  static List<City> citiesList = [

    City(
      city: 'Hebron Ps',
    ),
    City(
      city: 'Amman',
    ),
    City(
      city: 'Cairo',
    ),
    City(
      city: 'London',
    ),
    City(
      city: 'Tokyo',
    ),
    City(
      city: 'Paris',
    ),
    City(
      city: 'Lagos',
    ),
    City(
      city: 'Miami',
    ),
    City(
      city: 'Vienna',
    ),
    City(
      city: 'Berlin',
    ),

  ];

}

