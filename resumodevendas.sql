WITH base AS (
    SELECT
        loja,
        data_venda::date AS data_venda,
        orcamento,
        tipo_venda_padrao,
        tipo_operacao,
        MAX(valor_venda) AS valor_venda
    FROM public.vendas
    WHERE 1=1
      [[AND {{data_venda}}]]
    GROUP BY loja, data_venda::date, orcamento, tipo_venda_padrao, tipo_operacao
)
SELECT
    SUM(CASE WHEN tipo_operacao='VENDA' AND tipo_venda_padrao='VV' THEN valor_venda ELSE 0 END) AS venda_vista,
    SUM(CASE WHEN tipo_operacao='VENDA' AND tipo_venda_padrao='VP' THEN valor_venda ELSE 0 END) AS venda_prazo,
    SUM(CASE WHEN tipo_operacao='VENDA' AND tipo_venda_padrao='CP' THEN valor_venda ELSE 0 END) AS venda_crediario,
    SUM(CASE WHEN tipo_operacao='DEVOLUÇÃO' THEN valor_venda ELSE 0 END) AS devolucao_total,
    SUM(CASE WHEN tipo_operacao='VENDA' THEN valor_venda ELSE 0 END) +
    SUM(CASE WHEN tipo_operacao='DEVOLUÇÃO' THEN valor_venda ELSE 0 END) AS total_liquido
FROM base;