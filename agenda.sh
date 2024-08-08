#!/bin/bash

### Cores
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
rosa='\033[95m'
sc='\033[0m' # Sem cor

#### sumbliar o texto
ADDS=$(tput smul)
RMS=$(tput sgr0)

#### Caminho
AGENDA="/home/$USER/Agenda"

#### Criar o diretório Agenda no home e o -p valida sem erro caso já existir.
mkdir -p "$AGENDA_DIR"

#### Função para adicionar uma nova nota
adicionar_nota(){
	clear
	echo -e "Digite o nome do título da nova nota"
	read -r nota
	arquivo="$AGENDA/$nota.txt"

	if [ -f "$arquivo" ]; then
		echo "Título já existente, tente outro título. "
		return
	fi

	echo -e "${amarelo}Digite o conteúdo da nota. Tecla ${ADDS}CTRL+D${RMS} ${amarelo}quando terminar.${sc}"
	cat > "$arquivo"
	echo
	echo -e "${verde}Nota ${rosa}$titulo${verde}criado com sucesso.${sc}"
}

editar_nota(){
	clear
        ls -1 "$AGENDA" | cut -d "." -f 1 
        echo 'Entre as opções, qual nota deseja editar.'
        read -r nota
        nota="$AGENDA/$nota.txt"
        
        if [ ! -f "$nota" ]; then
                echo -e "${vermelho}Nota digitada inexistente, tente novamente.${sc}"
                return
        fi
	echo
	nano "$nota"
		echo -e "${verde}Nota editada com sucesso.${sc} "
	
	while true; do
		read -p "Deseja editar mais alguma nota? [S/n]" resp
		resp=$(echo "$resp" | tr '[:lower:]' '[:upper:]')
		if [ "$resp" == "S" ]; then
			editar_nota
			break
		elif [ "$resp" == "N" ]; then
			echo "Certo. Retornando para o menu"
			break
		else
			echo "Resposta incorreta, deve respoder ${ADDS}S${RMS} ou ${ADDS}N${RMS}"
		fi
	done
}

#### Menu1
main(){
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
		echo -e " 3. ${ciano}Sair${sc}"
		echo
		echo '⬗--------------------------------⬗'
	
		read -r opcao
	
	case $opcao in
		1) adicionar_nota ;;
		2) editar_nota ;;
		3) exit 0 ;;
	esac
	done
}
main
