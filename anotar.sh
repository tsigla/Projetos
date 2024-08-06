#!/bin/bash

#### Diretório onde as anotações serão armazenadas
NOTAS_DIR="./notas"

#### Cria o diretório de anotações se não existir
mkdir -p "$NOTAS_DIR"

# Função para adicionar uma anotação
adicionar_anotacao() {
    echo "Digite o título da anotação:"
    read -r titulo
    arquivo="$NOTAS_DIR/$titulo.txt"
    
    if [ -f "$arquivo" ]; then
        echo "Anotação com este título já existe!"
        return
    fi

    echo "Digite o conteúdo da anotação. Pressione Ctrl+D quando terminar:"
    cat > "$arquivo"
    echo "Anotação adicionada com sucesso!"
}

# Função para editar uma anotação
editar_anotacao() {
    echo "Digite o título da anotação para editar:"
    read -r titulo
    arquivo="$NOTAS_DIR/$titulo.txt"

    if [ ! -f "$arquivo" ]; then
        echo "Anotação não encontrada!"
        return
    fi

    echo "Digite o novo conteúdo da anotação. Pressione Ctrl+D quando terminar:"
    cat > "$arquivo"
    echo "Anotação editada com sucesso!"
}

# Função para excluir uma anotação
excluir_anotacao() {
    echo "Digite o título da anotação para excluir:"
    read -r titulo
    arquivo="$NOTAS_DIR/$titulo.txt"

    if [ ! -f "$arquivo" ]; then
        echo "Anotação não encontrada!"
        return
    fi

    rm "$arquivo"
    echo "Anotação excluída com sucesso!"
}

# Função para buscar e ler uma anotação
buscar_anotacao() {
    echo "Digite o título da anotação para buscar:"
    read -r titulo
    arquivo="$NOTAS_DIR/$titulo.txt"

    if [ ! -f "$arquivo" ]; then
        echo "Anotação não encontrada!"
        return
    fi

    cat "$arquivo"
}

# Função principal
menu() {
    while true; do
      echo "Escolha uma opção:"
    echo "1. Adicionar anotação"
    echo "2. Editar anotação"
    echo "3. Excluir anotação"
    echo "4. Buscar anotação"
    echo "5. Sair"
      
        read -r opcao

        case $opcao in
            1) adicionar_anotacao ;;
            2) editar_anotacao ;;
            3) excluir_anotacao ;;
            4) buscar_anotacao ;;
            5) exit 0 ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}

menu
