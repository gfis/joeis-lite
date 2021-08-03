--  Patches for target decexp
--  @(#) $Id$
--  2021-07-10: Georg Fischer
--
UPDATE seq4 SET callcode='decexprb', parm3 =  2 WHERE aseqno IN ('A071004','A073070','A180433');
UPDATE seq4 SET callcode='decexprb', parm3 =  3 WHERE aseqno IN ('A333451');
UPDATE seq4 SET callcode='decexprb', parm3 =  4 WHERE aseqno IN ('A333452');
UPDATE seq4 SET callcode='decexprb', parm3 =  6 WHERE aseqno IN ('A333454');
UPDATE seq4 SET callcode='decexprb', parm3 = 16 WHERE aseqno IN ('A170874');
UPDATE seq4 SET callcode='decexprb', parm3 =  2 WHERE aseqno IN ('A180433');
DELETE FROM seq4 WHERE aseqno IN
   ( 'A060196' -- 
   , 'A085667' -- take too long
   , 'A088751' -- Sum prime
   , 'A089260' -- Fibonacci
   , 'A094689' -- 
   , 'A102575' -- Decimal expansion of 2^(3/2)^(4/3)^(5/4)^(6/5)^(7/6)^(8/7)^(9/8)^(10/9)^(11/10)....
   , 'A123852' -- 
-- , 'A181693' -- Decimal expansion of AGM(1-x,1+x), where x=1/(10^27+1).
   , 'A202955' -- 
   , 'A221208' -- 
   , 'A229020' -- 
   , 'A241005' -- 
   , 'A241292' -- 
   , 'A241294' -- 5^(5^(5^5)) = 5^^4.
   , 'A241291' -- 2^(2^(2^(2^(2^2)))) = 2^^6.
   , 'A241293' -- 4^(4^(4^4)) = 4^^4
   , 'A241295' -- Decimal expansion of 6^(6^(6^6)) = 6^^4.
   , 'A241296' -- Decimal expansion of 7^(7^(7^7)) = 7^^4.
   , 'A241297' -- 
   , 'A243913' -- 
   , 'A254689' -- 
   , 'A257407' -- Decimal expansion of E(1/sqrt(2)) = 1.35064..., where E is the complete elliptic integral.
   , 'A259235' -- 
   , 'A276627' -- Decimal expansion of K(3-2*sqrt(2)), where K is the complete elliptic integral of the first kind.
   , 'A277535' -- 
   , 'A296040' -- Decimal expansion of sqrt(1^1 + sqrt(2^2 + sqrt(3^3 + sqrt(4^4 + sqrt(5^5 + ...))))).
   , 'A296041' -- 
   , 'A296042' -- 
   , 'A296140' -- 
   , 'A296547' -- 
   , 'A301509' -- Decimal expansion of (1 + (1 + (1 + (1 + ...)^(1/5))^(1/4))^(1/3))^(1/2).
   , 'A306858' -- 
   , 'A309208' -- 
   , 'A323482' -- 
   , 'A324859' -- Decimal expansion of 0.1990753..., an inflection point of a Hurwitz zeta fixed-point function.
   , 'A324860' -- Decimal expansion of 0.5250984..., a real fixed point of the iteration s = zetahurwitz(s, A324859).	
   , 'A327996' -- Decimal expansion of (1/2)*Pi^(3/4)/Gamma(3/4).
   , 'A332678' -- 
   , 'A339099' -- Decimal expansion of (2/1)^(5/4)^...^((n^2+1)/n^2)^... .
   , 'A341324' -- Decimal expansion of (1/4)^(4/9)^...^(n^2/(n+1)^2)^... .
   , 'A341325' -- Decimal expansion of (1/2)^(2/3)^...^(n/(n+1))^... .
   , 'A341863' -- Decimal expansion of (4/1)^(9/4)^...^((n+1)^2/n^2)^... .
   , 'A021002' --
   );
SELECT *  FROM seq4 WHERE offset < -64 OR offset > 64;
DELETE    FROM seq4 WHERE offset < -64 OR offset > 64;

COMMIT;
