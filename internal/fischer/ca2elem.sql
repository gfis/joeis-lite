--  Patches for CC=ca2elem
--  @(#) $Id$
--  2021-12-22: Georg Fischer
--
UPDATE seq4 s SET aseqno = 'A169703', parm1 = 174 WHERE aseqno = 'A269707';
UPDATE seq4 s SET parm1 = 65                      WHERE aseqno IN ('A278753','A278754','A278755','A278756');
UPDATE seq4 s SET parm1 = 33                      WHERE aseqno IN ('A276708','A276768','A276966','A277773');
UPDATE seq4 s SET callcode = 'ca2rightd'          WHERE aseqno IN ('A284405');
UPDATE seq4 s SET aseqno   = 'A283523'            WHERE aseqno IN ('A284406');
UPDATE seq4 s SET aseqno   = 'A282520'            WHERE aseqno IN ('A282510');
UPDATE seq4 s SET aseqno   = 'A282448'            WHERE aseqno IN ('A282428');
UPDATE seq4 s SET aseqno   = 'A282449'            WHERE aseqno IN ('A282429');
UPDATE seq4 s SET aseqno   = 'A280610'            WHERE aseqno IN ('A280609');
UPDATE seq4 s SET aseqno   = 'A280467'            WHERE aseqno IN ('A280466');
UPDATE seq4 s SET aseqno   = 'A279807'            WHERE aseqno IN ('A279802');
UPDATE seq4 s SET aseqno   = 'A279806'            WHERE aseqno IN ('A279801');
UPDATE seq4 s SET aseqno   = 'A279030'            WHERE aseqno IN ('A279031');
UPDATE seq4 s SET aseqno   = 'A278787'            WHERE aseqno IN ('A278778');
DELETE FROM seq4 s                                WHERE aseqno IN ('A283596','A283597');
COMMIT;
