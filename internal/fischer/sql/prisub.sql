-- Patches for CC=prisub
-- 2022-01-19
-- 2021-01-12, Georg Fischer
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('A073598','A097697','A089358','A089362','A127577','A219042','A219046','A219618','A230433');
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('A287914','A287956','A288444','A288445','A288449','A291349');
-- for R_k:
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('A102933','A102938','A102943','A102945','A102954','A102955','A102988','A103005','A103047','A103055','A103060','A103088');
UPDATE seq4 SET parm3 = offset1    WHERE callcode = 'prisuba';
UPDATE seq4 SET parm3 = 0 WHERE aseqno IN ('A055201','A124128','A125707','A249951','A271048','A323353');
UPDATE seq4 SET parm3 = 1 WHERE aseqno IN ('A057202','A057220','A306588','A306588','A306588','A306588');
COMMIT;
