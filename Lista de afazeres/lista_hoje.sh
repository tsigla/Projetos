# Aqui é informando a onde vai ser o nosso "Banco" de dados
export hoje="${HOME}/caminho/do/arquivo.txt"

# Função para inserir tarefa na lista
alh() { [ $# -eq 0 ] && cat $hoje || echo "$(echo $* | md5sum | cut -c 1-3) ➔ $*" >>$hoje ;}

# Função para remover tarefa da lista
rlh() { sed -i "/^$*/d" $hoje ;}
