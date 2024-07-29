#!/bin/bash

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
