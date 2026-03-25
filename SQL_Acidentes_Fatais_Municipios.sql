SELECT
    m.municipio,
    SUM(f.vitima_fatal) AS total_fatais
FROM dw_acidentes.fact_acidentes f
JOIN dw_acidentes.dim_municipio m
ON f.id_municipio = m.id_municipio
GROUP BY m.municipio
ORDER BY total_fatais DESC;