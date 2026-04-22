WITH dados AS (
    SELECT
        loja,
        cod_barras,
        descricao_item,

        /* total vendido do item */
        MAX(valor_venda) AS total_vendido,

        /* custo unitário */
        MAX(custo_medio) AS custo_unitario,

        /* valor unitário */
        MAX(valor_venda / NULLIF(qtde_total,0)) AS valor_unitario,

        /* líquido */
        (MAX(valor_venda) - (MAX(custo_medio) * MAX(qtde_total))) AS liquido
    FROM vendas
    WHERE 1=1
        [[AND {{data_venda}}]]
        [[AND {{filtro_loja}}]]
    GROUP BY
        loja,
        cod_barras,
        descricao_item
),

ranked AS (
    SELECT
        dados.*,
        ROW_NUMBER() OVER (
            PARTITION BY loja
            ORDER BY total_vendido DESC
        ) AS posicao
    FROM dados
)

SELECT *
FROM ranked
WHERE posicao <= 4
ORDER BY loja, total_vendido DESC;