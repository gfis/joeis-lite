package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360048 a(n) = Sum_{k=0..floor(n/2)} (-1)^k * binomial(n+1,2*k+1) * Catalan(k).
 * @author Georg Fischer
 */
public class A360048 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360048() {
    // o.g.f. 2/(1-x)/(1-x+((1-x)^2+4*x^2)^(1/2))
    // recurrence 3*(n+1)*n*u(n-1)+5*(n-1)*n*u(n-3)-n*(7*n-4)*u(n-2)-(n+2)*n*u(n) = 0
    super(0, "[[0],[0,-5,5],[0,4,-7],[0,3,3],[0,-2,-1]]", "[1,2,2,0]", 0);
  }
}
