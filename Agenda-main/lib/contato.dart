class Contato {
  //Propriedades que armaznan os dados
  String nome;
  String telefone;
  String email;

  Contato(
      {required this.nome,
      required this.telefone,
      required this.email}); // Usei o required para dizer que sao parametros obrigatorios
}
