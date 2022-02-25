-- insect.sql
-- @(#) $Id$
-- 2022-02-24, Georg Fischer
UPDATE seq4 SET callcode='insect2s' WHERE aseqno IN
('A061890'
,'A067611'
,'A084997'
,'A085534'
,'A085536'
,'A088412'
,'A088948'
,'A108454'
,'A117774'
,'A124134'
,'A125292'
,'A129523'
,'A168060'
,'A176556'
,'A193460'
,'A231960'
,'A244551'
,'A244962'
,'A247104'
,'A256455'
,'A272827'
,'A276349'
,'A296205'
,'A297644'
,'A297645'
,'A297646'
,'A297647'
,'A337140'
);
UPDATE seq4 SET callcode='insect2p', parm4='0' WHERE aseqno IN ('A109799','A129508');
UPDATE seq4 SET callcode='insect2p', parm4='5' WHERE aseqno IN ('A215850');
UPDATE seq4 SET callcode='insect2p', parm4='2' WHERE aseqno IN ('A234999','A261460');
UPDATE seq4 SET callcode='insect2p', parm4='1' WHERE aseqno IN ('A273045');
UPDATE seq4 SET callcode='insect2p', parm4=15  WHERE aseqno IN ('A176556');
