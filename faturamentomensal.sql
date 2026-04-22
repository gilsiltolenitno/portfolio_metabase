WITH base AS (
    SELECT DISTINCT
        data_venda::date AS data_venda,
        orcamento,
        tipo_venda_padrao,
        tipo_operacao,
        valor_venda
    FROM public.vendas
    WHERE tipo_operacao IN ('VENDA','DEVOLUÇÃO')
      AND EXTRACT(YEAR FROM data_venda) = EXTRACT(YEAR FROM CURRENT_DATE)
)
SELECT
    CASE EXTRACT(MONTH FROM data_venda)::int
        WHEN 1 THEN 'Jan'
        WHEN 2 THEN 'Fev'
        WHEN 3 THEN 'Mar'
        WHEN 4 THEN 'Abr'
        WHEN 5 THEN 'Mai'
        WHEN 6 THEN 'Jun'
        WHEN 7 THEN 'Jul'
        WHEN 8 THEN 'Ago'
        WHEN 9 THEN 'Set'
        WHEN 10 THEN 'Out'
        WHEN 11 THEN 'Nov'
        WHEN 12 THEN 'Dez'
    END AS mes_abreviado,
    SUM(CASE WHEN tipo_operacao = 'VENDA' THEN valor_venda ELSE 0 END)
      - SUM(CASE WHEN tipo_operacao = 'DEVOLUÇÃO' THEN ABS(valor_venda) ELSE 0 END) AS faturamento
FROM base
GROUP BY EXTRACT(MONTH FROM data_venda)
ORDER BY EXTRACT(MONTH FROM data_venda);
