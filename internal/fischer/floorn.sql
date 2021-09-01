--  @(#) $Id$
--  2021-08-30: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN('A274990'); -- hyperoperations
DELETE FROM seq4 WHERE aseqno IN('A116953'); -- Bagula, bad MMA
DELETE FROM seq4 WHERE aseqno IN('A174576'); -- a(0), MMA?
DELETE FROM seq4 WHERE aseqno IN('A174576'); -- a(0), MMA?
-- DELETE FROM seq4 WHERE aseqno BETWEEN 'A094969' AND 'A094999';  -- > separate target A094969
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A062722','A121830','A121831','A121899','A121900','A121901','A121902','A121903');
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A121904','A121905','A121915','A121916','A121917','A121918','A121925','A121928','A121929');
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A144836','A152737');
UPDATE seq4 SET offset = 1 WHERE aseqno IN ('A096228','A114768');
COMMIT;
