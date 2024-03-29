package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360051 a(n) = Sum_{k=0..floor(n/5)} (-1)^k * binomial(n+4,5*k+4) * Catalan(k).
 * @author Georg Fischer
 */
public class A360051 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360051() {
    // o.g.f. 2/(1-x)^2/((1-x)^3+((1-x)^6+4*x^5*(1-x))^(1/2))
    // recurrence 6*(n+4)*n*u(n-1)+3*(n-1)*n*u(n-6)+2*(n+5)*n*u(n-5)-15*(n+1)*n*u(n-4)+20*(n+2)*n*u(n-3)-15*(n+3)*n*u(n-2)-(n+5)*n*u(n) = 0
    super(0, "[[0],[0,-3,3],[0,10,2],[0,-15,-15],[0,40,20],[0,-45,-15],[0,24,6],[0,-5,-1]]", "[1,5,15,35,70,125,200]", 0);
  }
}
