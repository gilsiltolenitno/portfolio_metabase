SELECT
  "source"."cod_cliente" AS "cod_cliente",
  "source"."nome_cliente" AS "nome_cliente",
  "source"."max" AS "max",
  "source"."count" AS "count",
  "source"."LTV" AS "LTV"
FROM
  (
    SELECT
      "source"."cod_cliente" AS "cod_cliente",
      "source"."nome_cliente" AS "nome_cliente",
      "source"."max" AS "max",
      "source"."count" AS "count",
      CAST("source"."max" AS DOUBLE PRECISION) / NULLIF(CAST("source"."count" AS DOUBLE PRECISION), 0.0) AS "LTV"
    FROM
      (
        SELECT
          "public"."vendas"."cod_cliente" AS "cod_cliente",
          "public"."vendas"."nome_cliente" AS "nome_cliente",
          MAX("public"."vendas"."valor_venda") AS "max",
          count(distinct "public"."vendas"."doc_fiscal") AS "count"
        FROM
          "public"."vendas"
       
WHERE
          (
            "public"."vendas"."data_venda" >= DATE_TRUNC('year', NOW())
          )
         
   AND (
            "public"."vendas"."data_venda" < DATE_TRUNC('year', (NOW() + INTERVAL '1 year'))
          )
          AND ("public"."vendas"."cod_cliente" > 0)
       
GROUP BY
          "public"."vendas"."cod_cliente",
          "public"."vendas"."nome_cliente"
       
ORDER BY
          "public"."vendas"."cod_cliente" ASC,
          "public"."vendas"."nome_cliente" ASC
      ) AS "source"
  ) AS "source"
ORDER BY
  "source"."LTV" DESC,
  "source"."count" DESC,
  "source"."nome_cliente" ASC
LIMIT
  1048575