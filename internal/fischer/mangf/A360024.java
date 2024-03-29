package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360024 a(n) = Sum_{k=0..floor(n/2)} (-1)^k * binomial(n-k,k) * Catalan(k).
 * @author Georg Fischer
 */
public class A360024 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360024() {
    // o.g.f. 2/(1-x+((1-x)^2+4*x^2*(1-x))^(1/2))
    // recurrence -(n+2)*u(n)-(-2*n-2)*u(n-1)-(5*n-4)*u(n-2)-(-4*n+6)*u(n-3) = 0
    super(0, "[[0],[-6,4],[4,-5],[2,2],[-2,-1]]", "[1,1,0,-1]", 0);
  }
}
