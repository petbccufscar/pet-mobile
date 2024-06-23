import 'package:flutter/material.dart';

class Event {
  final int id;
  final String titulo;
  final String descricao;
  final String link;
  final int pot;
  final List<int> participantes;
  final DateTime dataHora;
  final DateTime createdAt;
  final bool isAllDay;
  final Color backgroundColor;

  const Event({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.link,
    required this.pot,
    required this.participantes,
    required this.dataHora,
    required this.createdAt,
    required this.isAllDay,
    required this.backgroundColor,
  });

  Event copyWith({
    int? id,
    String? titulo,
    String? descricao,
    String? link,
    int? pot,
    List<int>? participantes,
    DateTime? dataHora,
    DateTime? createdAt,
    bool? isAllDay,
    Color? backgroundColor,
  }) {
    return Event(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      link: link ?? this.link,
      pot: pot ?? this.pot,
      participantes: participantes ?? this.participantes,
      dataHora: dataHora ?? this.dataHora,
      createdAt: createdAt ?? this.createdAt,
      isAllDay: isAllDay ?? this.isAllDay,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  factory Event.fromMap(Map<String, dynamic> map) {
  return Event(
    id: map['id'] as int? ?? 0, // Exemplo: atribui 0 se 'id' for nulo
    titulo: map['titulo'] as String? ?? '',
    descricao: map['descricao'] as String? ?? '',
    link: map['link'] as String? ?? '',
    pot: map['POT'] as int? ?? 0,
    participantes: map['participantes'] != null
        ? List<int>.from(map['participantes'])
        : [], // Lista vazia se 'participantes' for nulo
    dataHora: map['dataHora'] != null ? DateTime.parse(map['dataHora'] as String) : DateTime.now(),
    createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : DateTime.now(),
    isAllDay: map['isAllDay'] as bool? ?? false,
    backgroundColor: map['backgroundColor'] != null ? Color(map['backgroundColor'] as int) : Colors.transparent,
  );
}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'link': link,
      'POT': pot,
      'participantes': participantes,
      'dataHora': dataHora.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'isAllDay': isAllDay,
      'backgroundColor': backgroundColor.value,
    };
  }
}

/*
Ao obter os dados do banco de dados, certifique-se de converter o mapa para o objeto Event utilizando o método fromMap:

final dynamic eventData = // dados do banco de dados;
final Event event = Event.fromMap(eventData);

*/