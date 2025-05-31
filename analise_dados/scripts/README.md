# Dicionário de Dados dos laboratórios

## LAB 1:

**Scripts**

- [06-lab-categoriazacao-codificacao-binarizacao.sql](./06-lab-categoriazacao-codificacao-binarizacao.sql);
- [06-lab-exercicio.sql](./06-lab-exercicio.sql).

**Metadados**

- classe[VARCHAR(255)]: Esta coluna representa a classe ou categoria à qual o paciente pertence. O tipo de dados VARCHAR permite armazenar texto com até 255 caracteres. Pode conter valores de 2 categorias.Esta variável deve ser representada numericamente;

- idade[VARCHAR(255)]: Esta coluna representa a faixa etária do pacienteeé armazenada como texto com até 255 caracteres. Osvalores podem ser faixas de idades, como "30-39" ou "40-49".Esta variável não deve fazer parte do resultadodoprocessamento dos dados;

- menopausa[VARCHAR(255)]:  Esta  coluna representao  estado  da  menopausa  do paciente. Esta variável  deve  ser  representada  numericamenteatravés  de  3 novas  variáveis dummy (campo novo criado para cada categoria do campo original);

- tamanho_tumor [VARCHAR(255)]: Esta coluna contém informações sobre o tamanho do tumor do paciente. Os valores podem ser faixas de tamanho do tumor, como "30-34" ou "20-24".Esta variável deve ser representada numericamente;

- inv_nodes[VARCHAR(255)]: Esta coluna representainformações sobre os nós invadidos pelo  tumor.  Os  valores  podem  ser  faixas  ou  categorias,  como  "0-2"  ou  outras  informações relacionadas à invasão de nós.Esta variável não deve fazer parte do resultadodoprocessamento dos dados;

- brnode_caps[VARCHAR(255)]: Esta coluna indicase o paciente possui ou não cápsula nos nódulos. Os valores possíveis podem ser "não"ou "sim".Esta variável deve ser representada numericamente;

- deg_malig[INT]: Esta coluna contém um valor numérico inteiro que descreve o grau de malignidade do tumor. É um valor numérico inteiro, o que significa que pode ser 1, 2 ou 3, por exemplo.Esta variável não precisa de processamento;

- seio[VARCHAR(255)]:  Esta  coluna representao  seio  afetado  pelo  tumor.  Os  valores podem incluir "esquerdo" ou "direito". Esta variável deve ser representada numericamente;

- quadrante[VARCHAR(255)]: Esta coluna contéminformações sobre o quadrante do seio afetado pelo tumor. Esta variável deve ser representada numericamente;

- irradiando[VARCHAR(255)]:  Esta  coluna indicase  o  paciente  está  ou  não  recebendo tratamento de radioterapia. Os valores podem incluir "não" ou "sim”. Esta variável deve ser representada numericamente.

---

## LAB 2:

**Scripts**

- [13-lab-ii-eda.sql](./13-lab-ii-eda.sql);
- [13-lab-ii-exercicio.sql](./13-lab-ii-exercicio.sql).

**Metadados**

- id: Identificador único para cada lançamento;
- data_lancamento: A data em que o lançamento contábil está sendo feito;
- conta_debito: Conta contábil a ser debitada;
- conta_credito: Conta contábil a ser creditada;
- valor: Valor monetário do lançamento;
- documento: Documentação comprobatória da operação;
- natureza_operacao: Descrição do evento contábil;
- centro_custo: Setor ou departamento responsável pela operação;
- impostos: Impostos e tributos envolvidos, se aplicável;
- moeda: Moeda utilizada na operação, se aplicável;
- taxa_conversao: Taxa de conversão para a moeda nacional, se aplicável.
