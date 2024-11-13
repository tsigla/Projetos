#!/usr/bin/env bash

################################################################################################################################################################
# Nome do Programa: PDV
# Descrição: O programa realiza cadastro de produto, edição, visualização, remoção, adição, recebimentos de valores e cadastro de notas.
# Versão: 1.3
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
#   1.3 - 12-11-2024 - Ajuste 2 da função "registrar_venda"
# 
# Contato:
#   - Email: [ts.sigla@gmail.com]
#   - GitHub: https://github.com/tsigla
#
#######################################################################################################################################################################

registrar_venda() {

    clear

    ### Limpa o arquivo de venda quando uma nova venda vai ser realizada.
    > venda.txt

    echo "      :::     ::: :::::::::: ::::    ::: :::::::::      :::     "
    echo "      :+:     :+: :+:        :+:+:   :+: :+:    :+:   :+: :+:   "
    echo "      +:+     +:+ +:+        :+:+:+  +:+ +:+    +:+  +:+   +:+  "
    echo "      +#+     +:+ +#++:++#   +#+ +:+ +#+ +#+    +:+ +#++:++#++: "
    echo "       +#+   +#+  +#+        +#+  +#+#+# +#+    +#+ +#+     +#+ "
    echo "        #+#+#+#   #+#        #+#   #+#+# #+#    #+# #+#     #+# "
    echo "          ###     ########## ###    #### #########  ###     ### "

    total=0

    while true; do
        echo "-------------------------------------------------------------------------"
        echo
        read -p "Digite o ID do produto: " id
        echo

        ### Encerra a venda ao receber um ID vazio e mostra o valor total.
        ### Condição para realizar uma nova venda ou voltar ao Menu1.
        if [[ -z "$id" ]]; then 
 	   
 	   ### Programa zenity exibe caixa com condição de escolha para uma nova venda ou não.
           if zenity --question --text="Deseja realizar realizar mais uma venda?                                                                    Valor total da venda: $total"; then
            	### Independete da escolha, vai salvar a venda no arquivo "vendas_diárias.txt"
            	echo "$(date '+%Y-%m-%d %H:%M') - Total: $total" >> Vendas_diárias.txt
            	clear
            	registrar_venda
           else
           	echo "$(date '+%Y-%m-%d %H:%M') - Total: $total" >> Vendas_diárias.txt
           	clear
           	menu1 
           fi        
        fi        
        
        ### Busca no banco de dados o produto com o ID informado e armazena o valor no arquivo "venda.txt". 
        info_produto=$(mysql -D "Estoque" -e "SELECT nome, valor FROM Produtos WHERE id='$id';" | sed -n '2p')
        mysql -D "Estoque" -e "SELECT nome, valor FROM Produtos WHERE id='$id';" | sed -n '2p' | awk '{print $NF}' >> venda.txt
        
        ### Converte vírgula para ponto e soma os valores do arquivo da venda atual.
        total=$(LC_NUMERIC="en_US.UTF-8" awk '{s+=$1} END {printf "%.2f", s}' venda.txt)

        echo "                    $info_produto"
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
				registrar_venda
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
