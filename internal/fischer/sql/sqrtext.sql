-- Patches for sqrtext
-- @(#) $Id$
-- 2021-06-07, Georg Fischer

UPDATE seq4 SET offset1=1, parm3= 1 WHERE aseqno IN ('A079280','A104268','A137591','A230122');
UPDATE seq4 SET offset1=2, parm3= 2 WHERE aseqno IN ('A059348','A152173');
UPDATE seq4 SET           parm3=-1 WHERE aseqno IN ('A137398');
UPDATE seq4 SET offset1=0           WHERE aseqno IN ('A137591','A288954'); -- this is the wrong offset1!
DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM asinfo WHERE keyword LIKE '%tab%');
COMMIT;
