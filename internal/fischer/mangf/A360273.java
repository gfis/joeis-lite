package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360273 a(n) = Sum_{k=0..floor(n/2)} Catalan(n-2*k).
 * @author Georg Fischer
 */
public class A360273 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360273() {
    // o.g.f. 1/2*(1-(1-4*x)^(1/2))/x/(-x^2+1)
    // recurrence 2*n*(2*n-1)*u(n-1)-2*n*(2*n-1)*u(n-3)+(n+1)*n*u(n-2)-(n+1)*n*u(n) = 0
    super(0, "[[0],[0,2,-4],[0,1,1],[0,-2,4],[0,-1,-1]]", "[1,1,3,6]", 0);
  }
}
