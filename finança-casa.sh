#!/usr/bin/env bash

##############################################################################
# Nome do Programa: finança.sh
# Descrição: O programa realiza a criação, edição, visualização e remoção de uma finança simples.
# Versão: 1.2
# Autor: Talys
# Data: 09-08-2024
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
#   ./finança.sh 
#   porém podendo criar um "alias" para facilitar a chamada.
#
# Histórico de Versões:
#   1.0 - 09-08-2024 - Versão inicial
#   1.1 - 08-12-2024 - ajustando a função "criar_mes"
#   1.2 - 15-12-2024 - Lógica funcional "criar_mes"
#
# Contato:
#   - Email: [ts.sigla@gmail.com]
#   - GitHub: https://github.com/tsigla
#
##############################################################################

#### Cores
preto='\033[0;30m'
verde_escuro='\033[1;30m'
vermelho='\033[0;31m'
vermelho_claro='\033[1;31m'
verde='\033[0;32m'='\033[1;32m'
amarelo='\033[1;33m'
azul='\033[0;34m'
azul_claro='\033[1;34m'
rocho='\033[0;35m'
rocho_claro='\033[1;35m'
ciano='\033[0;36m'
ciano_claro='\033[1;36m'
cinza_claro='\033[0;37m'
branco='\033[1;37m'
sc='\033[0m' # Sem cor

# Função para editar o mês
editar_mes() {
    echo "Qual é mês que deseja editar?"
    ls /home/sigla/Finanças
    read mes
    if [ -f "/home/sigla/Finanças/$mes" ]; then
        vim /home/sigla/Finanças/$mes
    else
        echo "Mês não encontrado!"
    fi
}

# Função para criar um mês
criar_mes(){

	local total1=0
    local total2=0
    if [ ! -d "Finanças" ]; then
    	mkdir -p "Finanças"
    fi
    
    echo -e "1.Janeiro 2.Fevereiro 3.Março 4.Abril 5.Maio 6.junho 7.julho 8.Agosto 9.Setembro 10.Outubro 11.Novembro 12.Dezembro"
    echo
    echo "Qual mês deseja criar (Digite o número correspondente)"
   	echo
   	read -p " > " opcao
    
    case $opcao in
    	1) novo_mes="Janeiro" ;;
    	2) novo_mes="Fevereiro" ;;
    	3) novo_mes="Março" ;;
    	4) novo_mes="Abril" ;;
    	5) novo_mes="Maio" ;;
    	6) novo_mes="junho" ;;
    	7) novo_mes="julho" ;;
    	8) novo_mes="Agosto" ;;
    	9) novo_mes="Setembro" ;;
    	10) novo_mes="Outubro" ;;
    	11) novo_mes="Novembro" ;;
    	12) novo_mes="Dezembro" ;;
    	*) echo "Opção inválida, tente novamente."; criar_mes; return
    esac
    
    # Inserir o ano no final de cada finança
    ano_atual=$(date +%Y)
    financa_atual="Finanças/${novo_mes}_$ano_atual"
    
    
    # Verifica se o mês já existe
    if [ -f "$financa_atual" ]; then
        read -p "O mês já existe! Deseja editar o mês $novo_mes? [s/n] " resp
        	if [ "$resp" == "s" ]; then
        	nvim "$financa_atual"
        	fi
        	
        read -p "Deseja criar um mês? " resp2
        	if [ "$resp2" == "s" ]; then
        		criar_mes
        	else
        		return
        	fi
    fi
    
    ### Adicionando valoes entre espaços e salvando em um array [-a]
  	read -p "Qual é o valor do ganho? " -a valores
  	
  	for ganhos in "${valores[@]}";do
  		total1=$((total1 + ganhos))
  	done
  	
		
		echo
    echo -e "${azul_claro}_+_+_+_Vamos informar as despesas_+_+_+_${sc}"
    
    while true; do
    		echo
        read -p "Digite a categoria (ou 'sair' para terminar):" categoria
        if [[ "$categoria" == "sair" ]]; then
            break
        fi

        read -p "Digite o valor da categoria: " valor

        # Validação para garantir que o valor é um número
        if ! [[ "$valor" =~ ^[0-9]+$ ]]; then
            echo -e "${vermelho_claro}Valor inválido, por favor insira um número.${sc}"
            continue
        fi
		
		echo "$categoria--->$valor" >> $financa_atual        
        total2=$((total2 + valor))
    done
    
#### Resultado gerado e enviado para o mês criado 
	echo
	echo -e " \n" >> $financa_atual
    echo -e "A soma total das despesas é: $total2" >> $financa_atual
    echo -e "${ciano_claro}A soma total das despesas é:${sc} ${vermelho_claro}$total2${sc}" 
    echo -e "Seu ganho é: $total1" >> $financa_atual
    echo -e "${ciano_claro}Seu ganho é: ${amarelo} $total1 ${sc}"
    echo -e "Seu saldo final é: $((total1 - total2))" >> $financa_atual
    echo -e "${ciano_claro}Seu saldo final é: ${verde}$((total1 - total2))${sc}"
}

# Menu do programa
menu1(){
clear
while true; do

	echo -e "  _                                            "
	echo -e " | |  o                                        "
	echo -e " | |       _  _     __,    _  _     __    __,  "
	echo -e " |/   |   / |/ |   /  |   / |/ |   /     /  |  "
	echo -e " |__/ |_/   |  |_/ \_/|_/   |  |_/ \___/ \_/|_/"
	echo -e " |\                                            "
	echo -e " |/                                            "
	echo

    echo "|=========================================|"
    echo "|                                         |"
    echo "|  1. Deseja editar um mês já existente.  |"
    echo "|  2. Criar um novo mês.                  |"
    echo "|  3. Sair do programa.                   |"
    echo "|                                         |"
    echo "|=========================================|"
    
    echo "Favor escolha a opção desejada"
read -p " > " opcao

    case $opcao in
        1)
            editar_mes
            ;;
        2)
        		clear
            criar_mes
            ;;
        3)
            echo
            echo "Saindo do programa..."
            sleep 1
            exit
            ;;
        *)
            echo "Opção inválida, tente novamente"
            echo
            ;;
    esac
    echo
done
}
menu1
