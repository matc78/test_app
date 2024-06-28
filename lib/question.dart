class Question {
  final String text;
  final String sex; // 'male' or 'female'
  final String difficulty; // 'easy' or 'extreme'

  Question({required this.text, required this.sex, required this.difficulty});
}

List<Question> questions = [
  Question(text: "Qui trouves-tu le plus beau ? (si que des filles imagine les en homme)", sex: 'female', difficulty: 'easy'),
  Question(text: "Qui trouves-tu le plus beau ? (si que des filles imagine les en homme)", sex: 'female', difficulty: 'extreme'),

  Question(text: "Qui trouves-tu le/la plus moche ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Qui trouves-tu le/la plus moche ?", sex: 'neutral', difficulty: 'easy'),
  
  Question(text: "Qui tu penses est le plus éclaté au lit ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui trouves-tu la plus belle ? (si que des ecs imagine les en fille)", sex: 'male', difficulty: 'easy'),
  Question(text: "Qui trouves-tu la plus belle ? (si que des ecs imagine les en fille)", sex: 'male', difficulty: 'extreme'),

  Question(text: "Qui trouves-tu a la pire tête ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Qui trouves-tu a le pire corps ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Qui trouves-tu a la plus belle tête ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Qui trouves-tu a le plus beau corps ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Qui trouves-tu a la pire tête ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui trouves-tu a le pire corps ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui trouves-tu a la plus belle tête ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui trouves-tu a le plus beau corps ?", sex: 'neutral', difficulty: 'easy'),

  Question(text: "Qui a la plus grosse (toi-même tu sais) ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Qui a la plus petite (toi-même tu sais) ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui est le/la plus poilu ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui est le/la plus poilu de l'entre-jambe?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui est le/la plus baisable ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui a le + une tête de poisson ?", sex: 'neutral', difficulty: 'easy'),

  Question(text: "Qui s'habille le moins bien ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui s'habille comme un clochard ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui est le plus gros rat (niveau argent, pas la tête)?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui est le plus gros rat ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Pour un coup d'un soir tu prends qui ?", sex: 'neutral', difficulty: 'extreme'),
  Question(text: "Pour un coup d'un soir tu prends qui avec un sac sur la tête ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui finira sa vie le + misérablement ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui finira sa vie tout seul ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui finira sa vie le + riche ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui finira sa vie le + mieux ?", sex: 'neutral', difficulty: 'easy'),

  Question(text: "Qui mange le plus ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui mange le plus de bite ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui bronze le moins bien ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui est le plus raciste ?", sex: 'neutral', difficulty: 'extreme'),

  Question(text: "Qui aime le plus draguer ?", sex: 'neutral', difficulty: 'easy'),
  Question(text: "Qui aime le plus pécho ?", sex: 'neutral', difficulty: 'extreme'),
  // Ajoutez d'autres questions ici
];
