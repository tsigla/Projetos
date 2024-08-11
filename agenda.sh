#!/usr/bin/env bash

##############################################################################
# Nome do Programa: agenda.sh
# Descrição: O programa realiza a criação, edição, visualização e remoção das notas.
# Versão: 1.1
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
#   ./agenda.sh 
#   porém podendo criar um "alias" para facilitar a chamada.
#
# Histórico de Versões:
#   1.0 - 09-08-2024 - Versão inicial
#   1.1 - 10-08-2024 - Correção das funções
#
# Contato:
#   - Email: [ts.sigla@gmail.com]
#   - GitHub: https://github.com/tsigla
#
##############################################################################

#### Debugador
set -euo pipefail # Habilita o modo de script seguro
IFS=$'\n\t'       # Defineo separador interno para nova linha e tabulação

#### Cores
preto='\033[0;30m'
verde_escuro='\033[1;30m'
vermelho='\033[0;31m'
vermelho_claro='\033[1;31m'
verde='\033[0;32m'
amarelo='\033[1;33m'
azul='\033[0;34m'
azul_claro='\033[1;34m'
rocho='\033[0;35m'
rocho_claro='\033[1;35m'
ciano='\033[0;36m'
ciano_claro='\033[1;36m'
cinza_claro='\033[0;37m'
branco='\033[1;37m'
rosa='\033[95m'
sc='\033[0m' # Sem cor

#### sumbliar o texto
ADDS=$(tput smul)
RMS=$(tput sgr0)

#### Criar o diretório Agenda no home e o -p valida sem erro caso já existir.
AGENDA="/home/$USER/Agenda"
mkdir -p "$AGENDA"

#### Função para adicionar uma nova nota
adicionar_nota(){
	clear
	echo -e "Digite o nome do título da nova nota"
	read -r nota
 	nota="$AGENDA/$nota.txt"
 
	if [ -f "$nota" ]; then
 		echo
		echo -e "${vermelho}Título já existente, tente outro título.${sc}"
  		sleep 2
  		adicionar_nota
	fi

	echo -e "${amarelo}Digite o conteúdo da nota. Tecla ${ADDS}CTRL+D${RMS} ${amarelo}quando terminar.${sc}"
	cat > "$nota"
	echo
	echo -e "${verde}Nota ${rosa}$nota${verde}criada com sucesso.${sc}"
}

#### Função para Editar a nota 
editar_nota(){
	clear
        find "$AGENDA" -maxdepth 1 -type f -name "*.txt" -exec basename {} .txt \; 
        echo 'Entre as opções, qual nota deseja editar.'
        read -r nota
        nota="$AGENDA/$nota.txt"
	
        if [ ! -f "$nota" ]; then #Validar se a nota não existe 
                echo -e "${vermelho}Nota digitada inexistente, tente novamente.${sc}"
                editar_nota
        fi
	echo
	nano "$nota"
		echo -e "${verde}Nota editada com sucesso.${sc} "
	
	while true; do
		read -p "Deseja editar mais alguma nota? [S/n]" resp
		resp=$(echo "$resp" | tr '[:lower:]' '[:upper:]') # Transformação da esposta em maiusculos
		if [ "$resp" == "S" ]; then
			editar_nota
		elif [ "$resp" == "N" ]; then
			echo "Certo. Retornando para o menu"
			inicio
		else
  			echo
			echo "Resposta incorreta, deve respoder ${ADDS}S${RMS} ou ${ADDS}N${RMS}"
   			echo
		fi
	done
}

visualizar_nota(){
	clear
 	lista=$(ls "$AGENDA" | cut -d "." -f 1)
  	for v in $lista; do
  		echo -e "${verde}➺ ${sc}$v"
	done
	echo
 	echo 'Qual nota deseja vusalizar?'
  	read -r nota
	nota="$AGENDA/$nota.txt"

   	if [ ! -f "$nota" ]; then
    		echo -e "${vermelho_claro}Nota não encotrada para visualização, digite novamente."
      		return
	fi
 
 	cat "$nota"
  	echo

}

remove_nota(){
	clear
 	lista=$(find "$AGENDA" -maxdepth 1 -type f -name "*.txt" -exec basename {} .txt \;)
  	for r in "$lista"; do
   		echo -e "${vermelho}-${sc} $r"
     	done
      	read -r nota
       	nota="$AGENDA/$nota.txt"
        if [ ! -f "$nota" ]; then
		echo
  		echo -e "${vermelho}Nota digitada inexistente, digite novamente."
    	fi

     rm $nota
}

#### Menu1
inicio(){
		echo '   ___  ___   ___  _ _  ___  ___ '
		echo '  | . |/  _> | __>| \ || . \| . |'
		echo '  |   || <_/\| _> |   || | ||   |'
		echo '  |_|_|`____/|___>|_\_||___/|_|_|'
                               
	while true; do
		echo '⬗--------------------------------⬗'
		echo -e "   Escolha uma opção           "
		echo '⬗--------------------------------⬗'
		echo "                                  "
		echo -e " 1. ${ciano}Adicionar anatoção${sc}"
		echo -e " 2. ${ciano}Editar anotação${sc}"
  		echo -e " 3. ${ciano}Visualizar anotação${sc}"
    		echo -e " 4. ${ciano}Remover anotação${sc}"
		echo -e " 5. ${ciano}Sair${sc}"
		echo
		echo '⬗--------------------------------⬗'
	
		read -r opcao
	
	case $opcao in
		1) adicionar_nota ;;
		2) editar_nota ;;
  		3) visualizar_nota ;;
		4) remove_nota ;;
  		5) exit 0 ;;
	esac
	done
}
inicio
 
