class OnBoardingItem {
  final String title;
  final String subTitle;
  final String image;

  const OnBoardingItem({this.title, this.subTitle, this.image});
}

class OnBoardingItems {
  static List<OnBoardingItem> loadOnboardItem() {
    const fi = <OnBoardingItem>[
      OnBoardingItem(
        title: 'Encuentra fácilmente sitio para estacionar',
        subTitle: 'En todos los estacionamientos de la ciudad ',
        image: 'assets/images/onboard/1.png',
      ),
      OnBoardingItem(
        title: '¿Te sientes desubicado?',
        subTitle:
            'No te preocupes Parkiate-ki marca el camino exacto que debes seguir para llegar al parqueo',
        image: 'assets/images/onboard/2.png',
      ),
      OnBoardingItem(
        title: 'Te ofrecemos una  gran cantidad de sitios disponibles',
        subTitle:
            '¿Estas preparado para ahorrar valioso tiempo buscando parqueos?',
        image: 'assets/images/onboard/3.png',
      ),
    ];
    return fi;
  }
}
