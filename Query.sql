
SELECT
    request_id,
    CASE
        WHEN (
            (SELECT COUNT(DISTINCT market_id) FROM request_market_info WHERE request_id = rmi.request_id) = 1
            AND (SELECT COUNT(*) FROM request_market_info WHERE request_id = rmi.request_id AND market_id IN ('kuwait', 'qatar')) = 1
        ) THEN 'A'
        WHEN (
            (SELECT COUNT(DISTINCT market_id) FROM request_market_info WHERE request_id = rmi.request_id) = 1
            AND (SELECT COUNT(*) FROM request_market_info WHERE request_id = rmi.request_id AND market_id IN ('dubai', 'abudhabi', 'oman')) = 1
        ) THEN 'B'
        WHEN (
            (SELECT COUNT(DISTINCT market_id) FROM request_market_info WHERE request_id = rmi.request_id) = 2
            AND (SELECT COUNT(*) FROM request_market_info WHERE request_id = rmi.request_id AND market_id IN ('kuwait', 'qatar')) = 1
            AND (SELECT COUNT(*) FROM request_market_info WHERE request_id = rmi.request_id AND market_id IN ('dubai', 'abudhabi', 'oman')) = 1
        ) THEN 'C'
        ELSE NULL -- Optional: handle other cases if needed
    END AS group_indicator
FROM
    request_market_info rmi
