WITH primer_positivo AS (
    SELECT
        patient_id,
        MIN(test_date) AS primera_fecha_positivo
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
primer_negativo AS (
    SELECT
        pp.patient_id,
        pp.primera_fecha_positivo,
        MIN(ct.test_date) AS primera_fecha_negativo
    FROM primer_positivo pp
    JOIN covid_tests ct
        ON pp.patient_id = ct.patient_id
        AND ct.result = 'Negative'
        AND ct.test_date > pp.primera_fecha_positivo
    GROUP BY pp.patient_id, pp.primera_fecha_positivo
)

SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(
        pn.primera_fecha_negativo,
        pn.primera_fecha_positivo
    ) AS recovery_time
FROM primer_negativo pn
JOIN patients p
    ON pn.patient_id = p.patient_id
ORDER BY recovery_time ASC, patient_name ASC;