class Project {
  final String title;
  //final String description;
  final String imageUrl;
  // falta lista de membros
  // falta lista de atividades respectivas do projeto

  get getTitle => this.title;

  //get getDescription => this.description;

  get getImageUrl => this.imageUrl;

  Project(
      //{required this.title, required this.description, required this.imageUrl});
      {required this.title, required this.imageUrl});

  @override
  String toString() {
    return 'Projeto: $title - imageURL: $getImageUrl';
    //return 'Projeto: $title - Descrição: $description - imageURL: $imageUrl';
  }
}
