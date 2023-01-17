-- etaprod.sql
-- @(#) $Id$
-- 2023-01-15, Georg Fischer
DELETE FROM seq4 WHERE aseqno IN 
('A000118'
);
UPDATE seq4 SET parm2 = '[2,8;1,-4]'          WHERE aseqno =  'A008438';

UPDATE seq4 SET parm2 = '-1/3'      WHERE aseqno IN ('A096727');
UPDATE seq4 SET parm2 = '-1/2'      WHERE aseqno IN
('A008438'
,'A123532'
,'A131943'
,'A131946'
,'A134077'
,'A185717'
,'A229615'
,'A229616'
);
UPDATE seq4 SET parm2 = '-1/1'      WHERE aseqno IN
('A100535'
,'A185653'
,'A208589'
,'A226862'
,'A246650'
,'A246752'
,'A255320'
,'A255365'
,'A256505'
,'A256574'
,'A257402'
,'A257873'
,'A260675'
,'A260676'
,'A263433'
,'A263571'
,'A286128'
,'A286129'
,'A286131'
,'A286132'
,'A286133'
,'A286134'
,'A286137'
,'A286813'
,'A298931'
,'A316662'
);
UPDATE seq4 SET parm3 = ', 0,0,0,0,0,0,0,0,0,1' WHERE aseqno IN ('A286134');
UPDATE seq4 SET parm3 = ', 0,0,0,0,0,1'         WHERE aseqno IN ('A286132');
UPDATE seq4 SET parm3 = ', 0,0,0,0,1'           WHERE aseqno IN ('A286131','A286133');
UPDATE seq4 SET parm3 = ', 0,0,0,1'             WHERE aseqno IN ('A286129','A321527','A328788');
UPDATE seq4 SET parm3 = ', 0,0,1'               WHERE aseqno IN ('A286128','A286137');
UPDATE seq4 SET parm3 = ', 0,1'                 WHERE aseqno IN ('A224226'
,'A229615'
,'A329651');
COMMIT;
