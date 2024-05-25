class CurrencyModell {
  String? name;
  String? value;

  CurrencyModell({this.name, this.value});
  static List<CurrencyModell> currencyList = [
    CurrencyModell(name: "United States Dollar", value: "USD"),
    CurrencyModell(name: "Euro", value: "EUR"),
    CurrencyModell(name: "British Pound", value: "GBP"),
    CurrencyModell(name: "Japenese Yen", value: "JPY"),
    CurrencyModell(name: "Canadian Dollar", value: "CAD"),
    CurrencyModell(name: "Australian Dollar", value: "AUD"),
    CurrencyModell(name: "Swiss Franc", value: "CHF"),
    CurrencyModell(name: "Chinese Yaun", value: "CNY"),
    CurrencyModell(name: "Swedish Krona", value: "SEK"),
    CurrencyModell(name: "New Zealand Dollar", value: "NZD"),
    CurrencyModell(name: "Indian Rupee", value: "INR"),
    CurrencyModell(name: "Brazilian Real", value: "BRL"),
    CurrencyModell(name: "Russian Ruble", value: "RUB"),
    CurrencyModell(name: "South African Rand", value: "ZAR"),
    CurrencyModell(name: "Hong Kong Dollar", value: "HKD"),
    CurrencyModell(name: "Singapore Dollar", value: "SGD"),
    CurrencyModell(name: "Norwegian Krone", value: "NOK"),
    CurrencyModell(name: "Mexican Peso", value: "MXN"),
    CurrencyModell(name: "Turkish Lira", value: "TRY"),
    CurrencyModell(name: "South Korean Won", value: "KRW"),
    CurrencyModell(name: "Danish Krone", value: "DKK"),
    CurrencyModell(name: "Polish Zloty", value: "PLN"),
    CurrencyModell(name: "Thai Baht", value: "THB"),
    CurrencyModell(name: "Indonesian Rupiah", value: "IDR"),
    CurrencyModell(name: "Hungarian Forint", value: "HUF"),
    CurrencyModell(name: "Czech Koruna", value: "CZK"),
    CurrencyModell(name: "Pakistani Rupee", value: "PKR"),
    CurrencyModell(name: "German Euro", value: "DMK (Euro)"),
  ];
}

class CountryModell {
  String? name;
  String? value;

  CountryModell({this.name, this.value});
  static List<CountryModell> currencyList = [
    CountryModell(name: "Espanol", value: "es"),
    CountryModell(name: "Polish", value: "pl"),
    CountryModell(name: "Francias", value: "fr"),
    CountryModell(name: "English", value: "en"),
    CountryModell(name: "Italiano", value: "it"),
    CountryModell(name: "Danish", value: "da"),
    CountryModell(name: "Finnish", value: "fi"),
    CountryModell(name: "Swedish", value: "sv"),
    CountryModell(name: "German", value: "de"),
  ];
}
