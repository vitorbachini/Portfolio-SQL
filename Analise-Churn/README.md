# Análise de Churn - SQL

Esta é uma análise de dados da Taxa de Churn, utilizando um dataset fictício.
O dataset contém informações de 10.000 clientes de uma instituição financeira, e através dele foram realizadas análises em SQL com o objetivo de compreender melhor a métrica de Churn.

## O que é a Taxa de Churn?

Churn é uma métrica que indica o quanto uma determinada empresa perdeu de clientes ou receita, por isso acompanhá-la é fundamental para entender a saúde do negócio e tomar melhores decisões estratégicas para melhorar a experiência do cliente.

## Conhecendo o Dataset

Para esta análise eu utilizei um dataset gratuito que pode ser encontrado [aqui](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn), contendo informações fictícias sobre clientes. As colunas presentes no dataset são:

- RowNumber - corresponde ao número da linha;
- CustomerId - contém o valores únicos aleatórios;
- Surname - nome do cliente;
- CreditScore - score de crédito do cliente;
- Geography - a localização do cliente;
- Gender - gênero do cliente;
- Age - idade do cliente;
- Tenure - corresponde ao número de anos que o cliente possui a conta;
- Balance - valor do saldo em conta;
- NumOfProducts - número de produtos utilizados pelo cliente;
- HasCrCard - informa se o cliente possui ou não cartão de crédito;
- IsActiveMember - informa se o cliente está ativo ou não;
- EstimatedSalary - salário estimado do cliente;
- Exited - informa se o cliente encerrou ou não a sua conta;
- Complain - informa se o cliente possui ou não uma reclamação;
- SatisfactionScore - score de satisfação do cliente;
- CardType - o tipo de cartão;
- Points Earned - os pontos possuídos por utilização do cartão.

## Metodologias Utilizadas

Para a realização das análises foram utilizadas funções de agregação e agrupamento, formatação de dados, JOINs, CTEs, manipulação de estruturas, além de cálculos de distribuição dos dados.

## Análise dos Dados

### Taxa de Churn Geral
- Script SQL utilizado: [01-categoria-churn.sql](./01-categoria-churn.sql)

Como Taxa de Churn Geral, obtivemos um valor de 20,38%, o que indica que aproximadamente 1 a cada 5 clientes deixaram o banco durante o período. Esse valor é considerado alto e sugere que a instituição está tendo problemas com a retenção de clientes.

### Taxa de Churn por Categoria
- Script SQL utilizado: [01-categoria-churn.sql](./01-categoria-churn.sql)

#### Gênero

Analisando a Taxa de Churn por Gênero podemos observar que tiveram diferenças significativas entre Mulheres (25.07%) e Homens (16.47%). Isso sugere que o banco enfrenta um desafio na retenção de clientes do gênero feminino.

#### Idade

Através da distribuição dos dados, podemos observar que os clientes que estão acima do 75 Percentil, ou seja, clientes mais velhos, possuem uma taxa de churn - 43.01% - muito maior do que o restante da distribuição.

#### Geografia

Aqui podemos observar que a Alemanha possui uma taxa de churn quase duas vezes maior do que França e Espanha.

### Taxa de Churn por Adesão aos Produtos
- Script SQL utilizado: [02-adesao-churn.sql](./02-adesao-churn.sql)

#### Número de Produtos

Ao analisar os dados observa-se que o banco está tendo dificuldades quanto ao gerenciamento de produtos. Tanto clientes com menor número de produtos quanto clientes com maior número de produtos estão com taxas de churn altas, apenas clientes na faixa de 2 produtos possuem uma baixa taxa de churn.

#### Possui Cartão de Crédito

Aqui podemos concluir que clientes que possuem cartão de crédito têm uma leve tendência a permanecer mais no banco.

#### Cliente Ativo

Este é um fator importante, pois os dados sugerem que manter clientes ativos reduz significativamente a taxa de churn - 14,27% para clientes ativos contra 26.87% para clientes inativos.

### Churn por Variáveis Financeiras
- Script SQL utilizado: [03-variaveis-financeiras-churn.sql](./03-variaveis-financeiras-churn.sql)

#### Score de Crédito

Esta também é uma métrica bem importante e através dela podemos observar que os clientes que possuem um melhor score de crédito têm uma tendência maior a permanecer no banco, comparado com clientes que estão nas faixas menores de score de crédito.

#### Faixa de Saldo

A análise desta métrica sugere que o banco possui dificuldades quanto à manutenção de contas de maior saldo, talvez pela falta de disponibilidade de produtos que sejam vantajosos para clientes que possuem saldos maiores.

#### Faixa de Salário Estimada

Novamente, podemos observar que clientes com maiores rendas estimadas têm uma tendência maior em deixarem o banco.

### Experiência e Satisfação do Cliente
- Script SQL utilizado: [04-satisfacao-cliente-churn.sql](./04-satisfacao-cliente-churn.sql)

#### Score de Satisfação

Aqui vemos que clientes que possuem um maior score de satisfação têm uma tendência levemente maior a permanecer no banco, enquanto scores de satisfação menores possuem uma leve tendência a influenciar negativamente a taxa de churn.

#### Reclamações

Esta métrica é bem direta, aproximadamente 99% dos clientes que deixaram o banco, possuem uma reclamação registrada. Isso significa que talvez o banco esteja com problemas na solução destas reclamações.

### Pontuação de Fidelidade e Tipo de Cartão
- Script SQL utilizado: [05-fidelidade-churn.sql](./05-fidelidade-churn.sql)

#### Pontuação de Fidelidade

Podemos observar que clientes que utilizam mais o cartão têm uma tendência a ter menores taxas de churn, em comparação com os clientes que utilizam menos o cartão.

#### Tipo de Cartão

De forma geral, os dados mostram que clientes que utilizam o cartão Diamond e Platinum têm uma tendência maior a deixar o banco, talvez pela falta de vantagens em utilizar este cartão.

### Tempo de Conta
- Script SQL utilizado: [06-tempo-conta-churn.sql](./06-tempo-conta-churn.sql)

Esta é outra métrica bem importante, pois mostra claramente que clientes que possuem a conta há mais tempo têm uma taxa de churn menor em comparação com contas mais novas, o banco poderia utilizar essa informação para melhorar a sua retenção para contas mais novas.

## Referências

- Dataset disponível em [Kaggle](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn)