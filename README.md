# Projeto Piloto de Metabase para Indicadores de Vendas

## Contexto
Este projeto foi desenvolvido em uma empresa de varejo, cujo sistema principal utiliza **Oracle** como banco de dados. O objetivo foi criar um piloto para utilização do **Metabase**, permitindo gerar dashboards de indicadores de vendas confiáveis.

O projeto envolveu a extração de dados de vendas, produtos e históricos de transações do Oracle, transformações para tratar problemas de encoding e registros nulos, e a carga desses dados em **PostgreSQL** para análise.

---

## Estratégia de Mapeamento (De/Para)
Para mapear os dados, foram utilizados **relatórios do ERP** e consultas SQL diretamente no Oracle. Cada campo do sistema legado foi comparado com a estrutura do novo modelo no PostgreSQL, garantindo que todas as métricas de vendas fossem corretamente correspondidas.

Durante o mapeamento, identificamos desafios como:

- **Encoding diferente** entre Oracle e PostgreSQL, que poderia gerar caracteres incorretos.
- **Registros nulos** que, se não tratados, poderiam inflar ou distorcer os indicadores.

Esses problemas foram cuidadosamente tratados antes da carga final.

---

## Solução de ETL
O fluxo de ETL adotado consistiu em três etapas principais:

1. **Extração:** coleta das tabelas de vendas do Oracle.  
2. **Transformação:** tratamento de encoding e filtragem de registros nulos para manter a qualidade dos dados.  
3. **Carga:** inserção dos dados no PostgreSQL, com validação contra os relatórios do ERP.

Todos os scripts utilizados foram documentados e padronizados, permitindo reexecuções automáticas sempre que necessário.

---

## Validação e Integridade
Para garantir que os dashboards refletissem dados precisos:

- Foram realizadas **validações de contagem e amostragem**, comparando totais de vendas entre Oracle, ERP e PostgreSQL.
- Inconsistências identificadas durante a validação (como campos nulos e encoding incorreto) foram corrigidas antes da finalização da carga.
- Esse processo garantiu que os dashboards do Metabase pudessem ser utilizados com confiança para análise de indicadores de vendas.

---

## Resultados
- Dashboard piloto de vendas completamente funcional no Metabase.  
- Estrutura pronta para expandir indicadores e incluir novas fontes de dados.  
- Processo de ETL documentado e automatizável para atualizações periódicas.

---

## Observações
- Nenhum dado confidencial foi incluído neste repositório.  
- Capturas de tela dos dashboards podem ser adicionadas na pasta `/images` para visualização.  
- Este projeto demonstra capacidade de **migração de dados**, **validação de integridade**, e implementação de **ETL** em ambientes heterogêneos (Oracle → PostgreSQL).
