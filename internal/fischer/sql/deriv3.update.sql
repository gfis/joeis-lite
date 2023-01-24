-- @(#) $Id$
-- Patch deriv3
-- 2020-06-17: Georg Fischer
--
UPDATE seq4 SET PARM1 = '~~A005493_0 - A000110_0__1' WHERE aseqno = 'A033452';
UPDATE seq4 SET PARM1 = '~~A101148_1 + 1'            WHERE aseqno = 'A103064';
DELETE FROM seq4                                     WHERE aseqno = 'A129902';
DELETE FROM seq4                                     WHERE aseqno = 'A091400';
UPDATE seq4 SET PARM1 = '~~2*5^A120375_1 - 1'        WHERE aseqno = 'A120376';
COMMIT;
