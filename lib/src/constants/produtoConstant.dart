const String DATABASE_NAME = 'produtos.db';
const String CREATE_PRODUTO_TABLE = '''
create table produto (
  id_produto TEXT,
  id_empresa TEXT,
  codigo_interno TEXT,
  descricao_pdv TEXT,
  preco_a_vista TEXT,
  preco_promocional TEXT,
)
''';
