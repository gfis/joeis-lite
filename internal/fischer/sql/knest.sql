-- knest.sql
-- @(#) $Id$ 
-- 2023-03-01, Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN     (SELECT aseqno FROM seq3); -- requires previous 'make knestpark'
COMMIT;
DELETE FROM seq4 WHERE parm1  NOT IN ((SELECT aseqno FROM joeis) UNION (SELECT aseqno FROM seq4));
COMMIT;
DELETE FROM seq4 WHERE aseqno IN
('A000001'
,'A067351'
,'A092386'
,'A210679'
);
COMMIT;

