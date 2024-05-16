import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Página para marcar atividade
class MarcarAtividadePage extends StatefulWidget {
  //Estado inicial
  @override
  State<MarcarAtividadePage> createState() {
    return MarcarAtividadeState();
  }
}

//Criando Estado Inicial
class MarcarAtividadeState extends State<MarcarAtividadePage> {
  //Controlador para áreas de texto editáveis
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  //Variáveis de data
  final DateTime dataPrimeira = DateTime(2000);
  final DateTime dataInicial = DateTime.now();
  final DateTime dataFinal = DateTime(3000);
  DateTime dataSelecionada = DateTime.now();
  final dataController = TextEditingController();

  //Variáveis de tempo
  Duration duration = const Duration(hours: 0);
  final tempoController = TextEditingController();

  //Variáveis de membros
  List membros = [];
  //Mostrar calendário
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? dataPega = await showDatePicker(
        initialDate: dataInicial,
        context: context,
        firstDate: dataPrimeira,
        lastDate: dataFinal);
    if (dataPega != null && dataPega != dataSelecionada) {
      setState(() {
        dataSelecionada = dataPega;
        dataController.text =
            "${dataSelecionada.toLocal()}".split(' ')[0].toString();
      });
    }
  }

  //Construindo a parte gráfica
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Marcar Atividade'),
          centerTitle: true,
        ),
        body: Container(
            color: const Color(0x00dfeceb),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Form(
                    //Coluna para a inserção de informações da atividade
                    child: Column(children: [
                      //Titulo da tarefa
                      TextFormField(
                        controller: titulo,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          hintText: 'Título',
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                        ),
                      ),
                      //Descrição
                      TextFormField(
                        controller: descricao,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Descrição',
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                        ),
                      ),
                      TextFormField(
                        onTap: () {
                          _selectDate(context);
                        },
                        controller: dataController,
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        //controller: descricao,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Data',
                            hintStyle: TextStyle(color: Color(0xFF989898)),
                            fillColor: Color(0xFFFFFFFF),
                            filled: true),
                      ),
                      TextFormField(
                        controller: tempoController,
                        onTap: () {
                          showDialog(
                              useRootNavigator: false,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 216,
                                  padding: const EdgeInsets.only(top: 6.0),
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      CupertinoTimerPicker(
                                          initialTimerDuration: duration,
                                          onTimerDurationChanged:
                                              (Duration newDuration) {
                                            setState(() {
                                              duration = newDuration;
                                              tempoController.text = duration
                                                  .toString()
                                                  .substring(0, 4);
                                            });
                                          }),
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Confirmar'))
                                    ],
                                  ),
                                );
                              });
                        },
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        //controller: descricao,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          hintText: 'Duração',
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: TextEditingController(text: 'Membros'),
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return TextFormField(
                                                  controller:
                                                      TextEditingController(
                                                          text: 'Aluno $index'),
                                                  readOnly: true,
                                                  keyboardType:
                                                      TextInputType.none,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          suffixIcon: Icon(
                                                            Icons.add_sharp,
                                                            color: Colors.blue,
                                                          )),
                                                );
                                              }),
                                        );
                                      });
                                },
                                child: const Icon(Icons.add_sharp,
                                    color: Colors.blue))),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return TextFormField(
                              controller:
                                  TextEditingController(text: 'Aluno $index'),
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            );
                          },
                        ),
                      )
                    ],
                  )),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Form(
                        child: TextFormField(
                      controller:
                          TextEditingController(text: 'Nome do Projeto'),
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 10,
                                            itemBuilder: (context, index) {
                                              return TextFormField(
                                                controller:
                                                    TextEditingController(
                                                        text: 'Projeto $index'),
                                                readOnly: true,
                                                keyboardType:
                                                    TextInputType.none,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        fillColor: Colors.white,
                                                        filled: true),
                                              );
                                            }),
                                      );
                                    });
                              },
                              child: const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.blue,
                              ))),
                    ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Form(
                      child: TextFormField(
                        controller: TextEditingController(text: 'Salvar'),
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.save, color: Colors.blue),
                        ),
                      ),
                    ))
              ],
            )));
  }
}

