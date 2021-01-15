-- Patches for CC=primof
-- 2021-01-15, Georg Fischer
UPDATE seq4 SET parm5 = '~~    ~~next();' WHERE aseqno IN ('A088332','A089376','A267290','A267378','A288369','A288370'
    ,'A288371','A288376','A288405','A288407','A288411','A288609','A288610','A288612','A288613','A288614'
    ,'A288618','A288715','A288716','A288717','A288718','A288890','A288891','A288892','A288893','A289492'
    ,'A289560','A291687');
UPDATE seq4 SET parm1='[[41,64,64],[-1]]', parm2='[64]' WHERE aseqno = 'A087856'; -- by Vincenzo Librandi
UPDATE seq4 SET parm1='[[9],[10],[-1]]'  , parm2='[1]'  WHERE aseqno = 'A055558';
UPDATE seq4 SET parm1='[[9],[10],[-1]]'  , parm2='[29]' WHERE aseqno = 'A055559';
COMMIT;
