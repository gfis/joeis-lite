-- Patches for CC=prisub
-- 2021-01-12, Georg Fischer
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('A073598','A097697','A089358','A089362','A127577','A219042','A219046','A219618','A230433');
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('A287914','A287956','A288444','A288445','A288449','A291349');
UPDATE seq4 SET parm3 = offset    WHERE callcode = 'prisuba';
UPDATE seq4 SET parm3 = 0 WHERE aseqno IN ('A055201','A124128','A125707','A249951','A271048','A323353');
COMMIT;
