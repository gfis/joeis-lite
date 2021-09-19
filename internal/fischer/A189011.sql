-- A189011.sql 
-- @(#) $Id$
-- 2021-09-18, Georg Fischer
--
UPDATE seq4 SET parm2='0'       WHERE aseqno IN ('A188970','A189028','A189031');
UPDATE seq4 SET parm5='1'       WHERE aseqno IN ('A189091','A189094','A189097','A189126','A189129','A189138','A189163');
UPDATE seq4 SET parm5='1, 1'    WHERE aseqno IN ('A189166','A189206','A189222');
UPDATE seq4 SET parm5='1, 0'    WHERE aseqno IN ('A189169','A189209','A189215');
UPDATE seq4 SET parm5='1, 1, 1' WHERE aseqno IN ('A189141','A189289');
UPDATE seq4 SET parm5='1, 1, 0' WHERE aseqno IN ('A189292');
UPDATE seq4 SET parm5='1, 0, 1' WHERE aseqno IN ('A189295');
UPDATE seq4 SET parm5='1, 0, 0' WHERE aseqno IN ('A189298');
UPDATE seq4 SET parm5='0, 1, 0' WHERE aseqno IN ('A189301');
COMMIT;