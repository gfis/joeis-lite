-- egfu.sql
-- 2021-12-01, Georg Fischer

UPDATE seq4 SET callcode = 'egfue' WHERE aseqno IN ('A080527','A195105','A247082','A249939','A250914','A250915','A272158','A272158');
UPDATE seq4 SET callcode = 'egfue' WHERE aseqno IN ('A272462','A272467','A272468','A273031','A273032','A273033');
UPDATE seq4 SET callcode = 'egfuo' WHERE aseqno IN ('A295257','A295258');
-- RING.x(); doesn't work:
DELETE FROM seq4 WHERE aseqno IN ('A235038','A235359','A235706','A218091','A218094','A218095','A218096','A218097','A218098','A218099');
DELETE FROM seq4 WHERE aseqno IN ('A323721'); -- sqrt(5), care

UPDATE seq4 SET callcode = 'egfue' WHERE aseqno IN ('A088026','A126156','A185071','A208679','A208680','A208681','A210657','A217582','A217502','A227051','A249938','A249940','A263185','A281180');
UPDATE seq4 SET callcode = 'egfuo' WHERE aseqno IN ('A096619','A100872','A101927','A101928','A102060','A102072','A131638','A156138');