-- morfps.sql
-- @(#) $Id$
-- 2021-05-27, Georg Fischer

-- DELETE FROM seq4 WHERE aseqno IN ('A007001','A103682','A105258','A106437','A119647','A120716','A176892','A191648','A229830','A289025','A305495','A305496','A317198','A318134','A320926','A320927');
COMMIT;
UPDATE seq4 set parm3 = '0->011MM00,1->011MM01,M->011MM0M', parm2 = '011M'  WHERE aseqno = 'A176416';
UPDATE seq4 set parm3 = '0->10,1->22,2->0'                 WHERE aseqno = 'A287200';
UPDATE seq4 set parm3 = '0->10,1->22,2->0'                 WHERE aseqno = 'A287331';
UPDATE seq4 set parm3 = '1->10,0->1M,M->1'                 WHERE aseqno = 'A317198';
UPDATE seq4 set parm1 = '1'                                WHERE aseqno = 'A287234';
UPDATE seq4 set parm1 = '1'                                WHERE aseqno = 'A287240';
UPDATE seq4 set parm3 = '00->0101,10->1000'                WHERE aseqno = 'A288596';
UPDATE seq4 set parm3 = '00->0101,10->1001'                WHERE aseqno = 'A288600';
UPDATE seq4 set parm3 = '00->1000,10->10011'               WHERE aseqno = 'A288929';
UPDATE seq4 set parm1 = '1', parm2 = '1101'                WHERE aseqno = 'A305490';
UPDATE seq4 set parm1 = '31'                               WHERE aseqno = 'A317203';
UPDATE seq4 set parm1 = '3'                                WHERE aseqno = 'A319956';
UPDATE seq4 SET parm2 = ''                                 WHERE aseqno IN ('A179542'); -- unanchored = triangle
COMMIT;

-- java -Doeis.big-factor-limit=1000000000 -Ddebug=2 -Xmx4g -cp "../../../joeis-lite/dist/joeis-lite.jar;../../../joeis/build.tmp/joeis.jar" irvine.oeis.MorphismFixedPointSequence -i 1 -a "" -m "1->12,2->123,3->113" -n 16 -d 2
-- s = {1}; w[0] = StringJoin[Map[ToString, s]];
-- w[n_] := StringReplace[w[n - 1], {"1"-> "12", "2"->"123", "3"->"113"}]
-- Table[w[n], {n, 0, 6}]  
