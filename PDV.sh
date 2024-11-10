#!/usr/bin/env bash

##############################################################################
# Nome do Programa: PDV
# Descrição: O programa realiza cadastro de produto, edição, visualização, remoção, adição, recebimentos de valores e cadastro de notas.
# Versão: 1.2
# Autor: Talys
# Data: 31-10-2024
# Licença: MIT
#   Copyright (c) 2024 Talys
#	
#	Por meio deste, é concedida permissão, gratuitamente, a qualquer pessoa 
#	que obtenha uma cópia deste software e dos arquivos de documentação associados (o "Software"), 
#	para lidar com o Software sem restrições, incluindo, sem limitação, 
#	os direitos de usar, copiar, modificar, mesclar, publicar, distribuir, sublicenciar e/ou vender cópias do Software, 
#	e permitir que as pessoas a quem o Software é fornecido o façam, sujeitas às seguintes condições:
#
#	O aviso de direitos autorais acima e este aviso de permissão deverão ser incluídos em todas as cópias ou partes substanciais do Software.
#
#	O SOFTWARE É FORNECIDO "NO ESTADO EM QUE SE ENCONTRA", SEM GARANTIA DE QUALQUER TIPO, EXPRESSA OU IMPLÍCITA, 
#	INCLUINDO, MAS NÃO SE LIMITANDO ÀS GARANTIAS DE COMERCIALIZAÇÃO, ADEQUAÇÃO A UM DETERMINADO FIM E NÃO VIOLAÇÃO. 
#	EM NENHUMA HIPÓTESE OS AUTORES OU TITULARES DOS DIREITOS AUTORAIS SERÃO RESPONSÁVEIS POR QUALQUER RECLAMAÇÃO, DANO OU OUTRA RESPONSABILIDADE, 
#	SEJA EM UMA AÇÃO DE CONTRATO, DELITO OU OUTRA FORMA, DECORRENTE DE, FORA DE OU EM CONEXÃO COM O SOFTWARE OU O USO OU OUTRAS NEGOCIAÇÕES NO SOFTWARE.
#
# Uso:
#   ./PDV
#   porém podendo criar um "alias" para facilitar a chamada.
#
# Histórico de Versões:
#   1.0 - 31-10-2024 - Versão inicial
#   1.1 - 10-11-2024 - Ajuste da função "menu1"
#   1.2 - 10-11-2024 - Ajuste 1 da função "registrar_venda"
# 
# Contato:
#   - Email: [ts.sigla@gmail.com]
#   - GitHub: https://github.com/tsigla
#
##############################################################################

registar_venda(){
	echo "      :::     ::: :::::::::: ::::    ::: :::::::::      :::     "
	echo "      :+:     :+: :+:        :+:+:   :+: :+:    :+:   :+: :+:   "
	echo "      +:+     +:+ +:+        :+:+:+  +:+ +:+    +:+  +:+   +:+  "
	echo "      +#+     +:+ +#++:++#   +#+ +:+ +#+ +#+    +:+ +#++:++#++: "
	echo "       +#+   +#+  +#+        +#+  +#+#+# +#+    +#+ +#+     +#+ "
	echo "        #+#+#+#   #+#        #+#   #+#+# #+#    #+# #+#     #+# "
	echo "          ###     ########## ###    #### #########  ###     ### "
	
	while true; do
		echo "-------------------------------------------------------------------------"
		echo
		read -p "Digita o ID do prduto: " id
		echo
		if [[ -z "$id" ]]; then 
			break
		fi
		 
		#produto_info=$(mysql -u "-?-" -p"-?-" -D "Estoque" -e "SELECT nome, valor FROM Produtos WHERE id='$id';")
    ### Conecta no banco de dados e retorna o o produto com o ID mencionado.
		produto_info=$(mysql -D "Estoque" -e "SELECT nome, valor FROM Produtos WHERE id='$id';")
		echo "$produto_info"

	done
}

### Menu 1
menu1(){
	clear
	while true; do
	echo -e "	::::    ::::  :::::::::: ::::    ::: :::    ::: "
	echo -e "	+:+:+: :+:+:+ :+:        :+:+:   :+: :+:    :+: "
	echo -e "	+:+ +:+:+ +:+ +:+        :+:+:+  +:+ +:+    +:+ "
	echo -e "	+#+  +:+  +#+ +#++:++#   +#+ +:+ +#+ +#+    +:+ "
	echo -e "	+#+       +#+ +#+        +#+  +#+#+# +#+    +#+ "
	echo -e "	#+#       #+# #+#        #+#   #+#+# #+#    #+# "
	echo -e "	###       ### ########## ###    ####  ########  "
	
				
		echo "---------------------------------------------------------"
		echo 
		echo "		1. Registrar Venda "
		echo
		echo "		2. Consultar Valor "
		echo 
		echo "		3. Consultar Estoque "
		echo 
		echo "		4. Relatórios "
		echo
		echo "---------------------------------------------------------"
		
		read -p "Escolha uma opção: " opcao
		
		case $opcao in
			1) 	
				clear
				registar_venda
				;;
			2)
				clear
				consultar_valor
				;;
			3)
				clear
				consultar_estoque
				;;
			4)
				clear
				relatorios
				;;
			*)
				echo 'Opção invalida, tente novamente.'
				sleep 1
				clear
				;;
	esac
done
}
### Tela inicial
menu1










































