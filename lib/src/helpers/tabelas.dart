class table {
  var sqlProduto = '''
                   create table PRODUTO (
                                          descricao_pdv				      TEXT,
                                          ean						            TEXT,
                                          cod_int_nao_usar		      TEXT,	
                                          cfop						          TEXT,
                                          eantrib					          TEXT,
                                          csosn						          TEXT,
                                          calcular_icms_st		      TEXT,	
                                          reducao_icms				      TEXT,
                                          cofinsnt_cst				      TEXT,
                                          pis_nt_cst					      TEXT,
                                          icms_origem				        TEXT,
                                          codigo_enquadramento      TEXT,		
                                          ipint_cst					        TEXT,
                                          ncm						            TEXT,
                                          unidade					          TEXT,
                                          cest						          TEXT,
                                          referencia					      TEXT,
                                          peso_liquido				      TEXT,
                                          peso_bruto					      TEXT,
                                          preco_padrao				      TEXT,
                                          preco_a_vista_nao_usar	  TEXT,	
                                          preco_a_prazo				      TEXT,
                                          preco_a_vista				      TEXT,
                                          preco_promocional		      TEXT,	
                                          id_produto					      TEXT,
                                          id_empresa					      TEXT,
                                          balanca					          TEXT,
                                          balanca_tipo				      TEXT,
                                          fcp						            TEXT,
                                          padrao_importacao		      TEXT,	
                                          icms						          TEXT,
                                          produto_inativo			      TEXT,
                                          preco_editavel			      TEXT,	
                                          enviar_app					      TEXT,
                                          atacado					          TEXT,
                                          codigo_interno			      TEXT,	
                                          foto						          TEXT
                   )
                   ''';

  var sqlCliente = '''
                   create table CLIENTES (
                                          id_cliente			    TEXT,
                                          id_empresa			    TEXT,
                                          dt_cadastro		      TEXT,
                                          dt_alteracao		    TEXT,
                                          tipo_pessoa		      TEXT,
                                          nome				        TEXT,
                                          situacao_receita	  TEXT,
                                          nome_fantasia		    TEXT,
                                          inscricao_estadual	TEXT,
                                          cpf_cnpj			      TEXT,
                                          inscricao_municipal TEXT,
                                          telefone			      TEXT,
                                          celular			        TEXT,
                                          email				        TEXT,
                                          cidade				      TEXT,
                                          uf					        TEXT,
                                          observacao			    TEXT
                   )
                   ''';

  var sqlFormasPagamento = '''
                           create table FORMAS_PAGAMENTO (
                                          id_forma_pagamento  TEXT,
                                          id_empresa          TEXT,
                                          descricao           TEXT,        
                                          inativo             TEXT
                                          )   
                            ''';

  var sqlPedidosProdutos = '''
                           create table PEDIDOS_PRODUTOS (
                                          id_pedido_app_det TEXT,
                                          id_pedido_app     TEXT,
                                          id_produto        TEXT,        
                                          qtde              TEXT,        
                                          preco_unitario    TEXT,        
                                          desconto          TEXT,        
                                          total             TEXT
                                          )   
                            ''';

  var sqlPedidos = '''
                           create table PEDIDOS (
                                            id_pedido_app      TEXT,
                                            id_cliente         TEXT,
                                            id_empresa         TEXT,
                                            token              TEXT,
                                            nome               TEXT,
                                            cpf_cnpj           TEXT,
                                            celular            TEXT,  
                                            email              TEXT,
                                            total_itens        TEXT,
                                            status             TEXT,
                                            desconto           TEXT,
                                            sub_total          TEXT,
                                            total              TEXT,
                                            data_lancamento    TEXT,
                                            id_forma_pagamento TEXT
                              )   
                            ''';
}
