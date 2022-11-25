package irvine.oeis.a285;
// Generated by gen_seq4.pl hologf4/hologf at 2022-11-12 20:42

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A285195 G.f.: 2C(x)/(3-sqrt(1-4xC(x))) where C = g.f. for A000108.
 * @author Georg Fischer
 */
public class A285195 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A285195() {
    // o.g.f. (1-(1-4*x)^(1/2))/x/(3-(-1+2*(1-4*x)^(1/2))^(1/2))
    // recurrence -18*(n+1)*n*(n-1)*(11*(n-4)^2+292*n-838)*u(n)+3*n*(n-1)*(869*(n-4)^3+25565*(n-4)^2+85694*n-277046)*u(n-1)-2*(n-1)*(5588*(n-4)^4+174274*(n-4)^3+796225*(n-4)^2+1258763*n-4393592)*u(n-2)-(-14960*(n-4)^5-475088*(n-4)^4-2263912*(n-4)^3-4027468*(n-4)^2-2907252*n+10970568)*u(n-3)+8*(4*n-11)*(2*n-5)*(4*n-13)*(11*(n-4)^2+314*n-623)*u(n-4) = 0
    super(0, "[[0],[2556840,-4031936,2294680,-538800,33920,2816],[14882040,-23118444,12894572,-2943896,175888,14960],[-2754000,6401174,-5164404,1686962,-158556,-11176],[0,-229134,460476,-276753,42804,2607],[0,-11916,3672,12114,-3672,-198]]", "[1,0,0,-1,-6]", 0);
  }
}
