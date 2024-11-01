#!/bin/bash

##############################################################################
# Nome do Programa: Calculo_porcentagem.sh
# Descrição: O programa realiza a criação, edição, visualização e remoção das notas.
# Versão: 1.1
# Autor: Talys
# Data: 15-06-2024
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
#   ./Calculo_porcentagem.sh
#   porém podendo criar um "alias" para facilitar a chamada.
#
# Histórico de Versões:
#   1.0 - 16-06-2024 - Versão inicial
# 
# Contato:
#   - Email: [ts.sigla@gmail.com]
#   - GitHub: https://github.com/tsigla
#
##############################################################################

# Boas vindas!
echo -e "O programa foi criado para descobrir qual é a diferença da porcentagem entre os valores passados.
Exemplo visual; 
|=====================================================|
| (valor-inicial + valor-porcento) - y% = valor-final |
|=====================================================|
"

# Define os valores iniciais
echo "Informa o valor inicial."
read  valor_inicial
echo
echo "Informa o valor da % do valor inicial."
read percentual_acrescimo
echo
echo "Informa o valor final, assim descobrindo o valor da diferença de % ."
read valor_final

# Calcula o valor com o acréscimo percentual junto com a calculadora avançada bc.
# O -l aplica as casas decimais com precisão no resultado.
valor_acrescimo=$(echo "$valor_inicial * $percentual_acrescimo / 100" | bc -l)
valor_com_acrescimo=$(echo "$valor_inicial + $valor_acrescimo" | bc -l)

echo "Valor inicial: $valor_inicial"
echo "Percentual de acréscimo: $percentual_acrescimo%"
echo "Valor com acréscimo: $valor_com_acrescimo"

# Calcula o percentual de desconto aplicado para chegar ao valor final
percentual_desconto=$(echo "($valor_com_acrescimo - $valor_final) * 100 / $valor_com_acrescimo" | bc -l)

echo "Valor final desejado: $valor_final"
echo "Percentual de desconto aplicado: $percentual_desconto%"
