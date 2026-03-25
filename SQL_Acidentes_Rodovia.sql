SELECT
    l.rodovia,
    COUNT(*) AS total_acidentes
FROM dw_acidentes.fact_acidentes f
JOIN dw_acidentes.dim_localizacao l
ON f.id_localizacao = l.id_localizacao
GROUP BY l.rodovia
ORDER BY total_acidentes DESC;