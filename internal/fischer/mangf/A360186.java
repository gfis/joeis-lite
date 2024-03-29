package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360186 a(n) = Sum_{k=0..floor(n/3)} (-1)^k * binomial(2*n-6*k,n-3*k).
 * @author Georg Fischer
 */
public class A360186 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360186() {
    // o.g.f. 1/(1-4*x)^(1/2)/(x^3+1)
    // recurrence (4*n-2)*u(n-1)+(4*n-2)*u(n-4)-n*u(n-3)-n*u(n) = 0
    super(0, "[[0],[-2,4],[0,-1],[0],[-2,4],[0,-1]]", "[1,2,6,19,68]", 0);
  }
}
