class City{
  bool isSelected;
  final String city;
  final String country;
   String tempc;
   String condition;
  City({required this.condition,required this.tempc ,required this.isSelected, required this.city, required this.country});

  static List<City> citiesList = [
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'London',
        country: 'United Kindgom'),

    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Tokyo',
        country: 'Japan'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Delhi',
        country: 'India'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Beijing',
        country: 'China'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Paris',
        country: 'Paris'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Rome',
        country: 'Italy'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Lagos',
        country: 'Nigeria'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Amsterdam',
        country: 'Netherlands'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Barcelona',
        country: 'Spain'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Miami',
        country: 'United States'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Vienna',
        country: 'Austria'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Berlin',
        country: 'Germany'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Toronto',
        country: 'Canada'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Brussels',
        country: 'Belgium'),
    City(
        condition: '',
        tempc: '0',
        isSelected: false,
        city: 'Nairobi',
        country: 'Kenya'),
  ];

}