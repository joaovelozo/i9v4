import 'dart:convert';

class Cliente {
  final String? id_cliente;
  final String? id_empresa;
  final String? cpf_cnpj;
  final String? nome;
  final String? nome_fantasia;
  final String? telefone;
  final String? celular;
  final String? email;
  final String? cidade;
  final String? uf;
  Cliente({
    this.id_cliente,
    this.id_empresa,
    this.cpf_cnpj,
    this.nome,
    this.nome_fantasia,
    this.telefone,
    this.celular,
    this.email,
    this.cidade,
    this.uf,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_cliente': id_cliente,
      'id_empresa': id_empresa,
      'cpf_cnpj': cpf_cnpj,
      'nome': nome,
      'nome_fantasia': nome_fantasia,
      'telefone': telefone,
      'celular': celular,
      'email': email,
      'cidade': cidade,
      'uf': uf,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id_cliente: map['id_cliente'] ?? '',
      id_empresa: map['id_empresa'] ?? '',
      cpf_cnpj: map['cpf_cnpj'] ?? '',
      nome: map['nome'] ?? '',
      nome_fantasia: map['nome_fantasia'] ?? '',
      telefone: map['telefone'] ?? '',
      celular: map['celular'] ?? '',
      email: map['email'] ?? '',
      cidade: map['cidade'] ?? '',
      uf: map['uf'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) =>
      Cliente.fromMap(json.decode(source));
}
