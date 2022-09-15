'''
    Calculadora de Preço Teto para Empresas Pagadoras de Dividendos
'''

precos = []
totalDividendos = 0
mediaDividendos = 0
rentabilidadeBuscada = 0
cotacaoAtual = 0
margemSeguranca = 0
yieldProjetivo = 0

print('## Calculadora de Preço Teto para dividendos ##')
print()
ticket = input('Qual ação você quer calcular (ticker)?')
anoCorrente = int(input('Qual o ano atual?'))
cotacaoAtual = float(input('Qual a cotação atual? (em R$): '))
rentabilidadeBuscada = int(input('Qual a rentabilidade buscada? (em %): ').split('%')[0])

print('\nInsira os dividendo pagos pela empresa nos ultimos 5 anos (R$):\n')

for i in range(5):
    preco = float(input(f"({anoCorrente - (5 - i)}): R$ "))
    totalDividendos += preco
    precos.append(preco)


mediaDividendos = totalDividendos / 5
precoTeto = mediaDividendos / (rentabilidadeBuscada / 100)


margemSeguranca = (((precoTeto / cotacaoAtual) - 1) * 100)
yieldProjetivo = ((mediaDividendos / cotacaoAtual) * 100)

# Resultados

print(f"\n\n{'-'*20} {ticket} {'-'*20}")

print(f"\nDividendos projetivos médios: R${mediaDividendos:.2f}")
print(f"\nYield projetivo médio:{yieldProjetivo:.2f}%")
print(f"\nPreço teto médio projetivo: R${precoTeto:.2f}")

print(f"\nPreço atual: R${cotacaoAtual:.2f}")
print(f"\nMargem de Segurança:{margemSeguranca:.2f}%")

print(f"\nUltimos dividendos pagos:")
for i in range(5):
    print(f"{' '*5}({anoCorrente - (5 - i)}): R${precos[i]}")