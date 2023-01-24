--  Patches for CC=mckay
--  @(#) $Id$
--  2020-10-07: Georg Fischer
--
UPDATE seq4 SET callcode = 'mckay0', parm4 = '1' WHERE aseqno IN 
        ('A131125','A132976','A143840','A161970'
        ,'A185338','A187130','A187143','A187144','A187145','A187196','A187197'
        ,'A193261','A208603');
COMMIT;
