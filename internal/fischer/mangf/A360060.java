package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360060 a(n) = Sum_{k=0..n} (-1)^k * binomial(n+4*k+4,n-k) * Catalan(k).
 * @author Georg Fischer
 */
public class A360060 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360060() {
    // o.g.f. 2/(1-x)^5/(1+(1+4*x/(1-x)^5)^(1/2))
    // recurrence -(n+1)*u(n)-(-2*n-2)*u(n-1)-(11*n-19)*u(n-2)-(-20*n+40)*u(n-3)-(15*n-45)*u(n-4)-(-6*n+24)*u(n-5)-(n-5)*u(n-6) = 0
    super(0, "[[0],[5,-1],[-24,6],[45,-15],[-40,20],[19,-11],[2,2],[-1,-1]]", "[1,4,7,5,4,29,50]", 0);
  }
}
