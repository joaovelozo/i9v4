class ClienteModel {
  String? idCliente;
  String? idEmpresa;
  String? dtCadastro;
  String? dtAlteracao;
  String? tipoPessoa;
  String? nome;
  String? situacaoReceita;
  String? nomeFantasia;
  String? inscricaoEstadual;
  String? cpfCnpj;
  String? inscricaoMunicipal;
  String? telefone;
  String? celular;
  String? email;
  String? cidade;
  String? uf;
  String? observacao;

  ClienteModel();

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['id_cliente']?.toString();
    idEmpresa = json['id_empresa']?.toString();
    dtCadastro = json['dt_cadastro']?.toString();
    dtAlteracao = json['dt_alteracao']?.toString();
    tipoPessoa = json['tipo_pessoa']?.toString();
    nome = json['nome']?.toString();
    situacaoReceita = json['situacao_receita']?.toString();
    nomeFantasia = json['nome_fantasia']?.toString();
    inscricaoEstadual = json['inscricao_estadual']?.toString();
    cpfCnpj = json['cpf_cnpj']?.toString();
    inscricaoMunicipal = json['inscricao_municipal']?.toString();
    telefone = json['telefone']?.toString();
    celular = json['celular']?.toString();
    email = json['email']?.toString();
    cidade = json['cidade']?.toString();
    uf = json['uf']?.toString();
    observacao = json['observacao']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_cliente'] = idCliente;
    data['id_empresa'] = idEmpresa;
    data['dt_cadastro'] = dtCadastro;
    data['dt_alteracao'] = dtAlteracao;
    data['tipo_pessoa'] = tipoPessoa;
    data['nome'] = nome;
    data['situacao_receita'] = situacaoReceita;
    data['nome_fantasia'] = nomeFantasia;
    data['inscricao_estadual'] = inscricaoEstadual;
    data['cpf_cnpj'] = cpfCnpj;
    data['inscricao_municipal'] = inscricaoMunicipal;
    data['telefone'] = telefone;
    data['celular'] = celular;
    data['email'] = email;
    data['cidade'] = cidade;
    data['uf'] = uf;
    data['observacao'] = observacao;
    return data;
  }
}
