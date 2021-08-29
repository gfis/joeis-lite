--  @(#) $Id$
--  2020-06-10: Georg Fischer
--
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno from poeis);
DELETE FROM seq4 WHERE aseqno IN ('A184909','A184910','A184911','A182640');
UPDATE seq4 SET offset = 0 WHERE aseqno IN ('A166447');
COMMIT;
