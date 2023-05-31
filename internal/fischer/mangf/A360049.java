package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360049 a(n) = Sum_{k=0..floor(n/3)} (-1)^k * binomial(n+2,3*k+2) * Catalan(k).
 * @author Georg Fischer
 */
public class A360049 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360049() {
    // o.g.f. 2/(1-x)/((1-x)^2+((1-x)^4+4*x^3*(1-x))^(1/2))
    // recurrence 4*(n+2)*n*u(n-1)+3*(n-1)*n*u(n-4)+6*n*u(n-3)-6*(n+1)*n*u(n-2)-(n+3)*n*u(n) = 0
    super(0, "[[0],[0,-3,3],[0,6],[0,-6,-6],[0,8,4],[0,-3,-1]]", "[1,3,6,9,9]", 0);
  }
}
