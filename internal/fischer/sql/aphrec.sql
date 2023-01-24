-- aphrec.sql patches for aphrec
-- @(#) $Id$
-- 2021-06-12, Georg Fischer

UPDATE seq4 SET parm2 = '[1,1,2,6,24,120        ]' WHERE aseqno IN ('A052399');
UPDATE seq4 SET parm2 = '[1,2,6,24,120          ]' WHERE aseqno IN ('A072132');
UPDATE seq4 SET parm2 = '[1,3,27                ]' WHERE aseqno IN ('A118714');
UPDATE seq4 SET parm2 = '[0,1,2,6,21            ]' WHERE aseqno IN ('A144904');
UPDATE seq4 SET parm2 = '[1,14,444              ]' WHERE aseqno IN ('A201546');
UPDATE seq4 SET parm2 = '[4,8,18,36,88,176,470,940]' WHERE aseqno IN ('A228231');
UPDATE seq4 SET parm2 = '[1,2,8,39              ]' WHERE aseqno IN ('A236339');
UPDATE seq4 SET parm2 = '[1,2                   ]' WHERE aseqno IN ('A285201');
UPDATE seq4 SET parm2 = '[1,2,3,4,5             ]' WHERE aseqno IN ('A337188');
COMMIT;