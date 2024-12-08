#!/bin/bash

##############################################################################
# Nome do Programa: +Saúde
# Descrição: O programa contém uma grande variedade de ferramentas que podem ajudar o usuário a verificar informações relacionadas à sua própria saúde com base nos dados fornecidos. 
# Além disso, também permite consultar bulas, hospitais e farmácias nas proximidades.
# Versão: 1.0
# Autor: Talys
# Data: 08-12-2024
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
#   ./+saude.sh
#   porém podendo criar um "alias" para facilitar a chamada.
#
# Histórico de Versões:
#   1.0 - 08-12-2024 - Versão inicial
#
# Contato:
#   - Email: [ts.sigla@gmail.com]
#   - GitHub: https://github.com/tsigla
#
##############################################################################

# Função para calcular a TMB
calcula_tmb() {
  local sexo="$1"
  local peso="$2"
  local altura="$3"
  local idade="$4"

  if [[ "$sexo" == "m" ]]; then
    echo "$(echo "88.36 + (13.4 * $peso) + (4.8 * $altura) - (5.7 * $idade)" | bc)"
  else
    echo "$(echo "447.6 + (9.2 * $peso) + (3.1 * $altura) - (4.3 * $idade)" | bc)"
  fi
}

# Função para calcular o GET
calcula_get() {
  local tmb="$1"
  local atividade="$2"

  case "$atividade" in
    1) fator=1.2 ;;
    2) fator=1.375 ;;
    3) fator=1.55 ;;
    4) fator=1.725 ;;
    5) fator=1.9 ;;
    *) fator=1.2 ;;
  esac

  echo "$(echo "$tmb * $fator" | bc)"
}

    __     _______                      __         
  _|  |_  |   _   | .---.-. .--.--. .--|  | .-----.
 |_    _| |   1___| |  _  | |  |  | |  _  | |  -__|
   |__|   |____   | |___._| |_____| |_____| |_____|
          |:  1   |                                
          |::.. . |                                
          `-------' 

# Solicitar informações ao usuário
echo "=== Calculadora de Calorias ==="
read -p "Digite seu sexo (m para masculino, f para feminino): " sexo
read -p "Digite seu peso em kg: " peso
read -p "Digite sua altura em cm: " altura
read -p "Digite sua idade em anos: " idade

echo "Escolha seu nível de atividade física:"
echo "1 - Sedentário"
echo "2 - Levemente ativo"
echo "3 - Moderadamente ativo"
echo "4 - Muito ativo"
echo "5 - Extremamente ativo"
read -p "Opção (1-5): " atividade

# Calcular TMB e GET
tmb=$(calcula_tmb "$sexo" "$peso" "$altura" "$idade")
get=$(calcula_get "$tmb" "$atividade")

# Exibir resultados
echo
echo "=== Resultado ==="
echo "Sua Taxa Metabólica Basal (TMB): $tmb kcal"
echo "Seu Gasto Energético Total (GET): $get kcal"
echo
echo "Para:"
echo " - Manter o peso: Consuma aproximadamente $get kcal/dia."
echo " - Perder peso: Consuma aproximadamente $(echo "$get - 500" | bc) kcal/dia."
echo " - Ganhar peso: Consuma aproximadamente $(echo "$get + 500" | bc) kcal/dia."

exit 0
