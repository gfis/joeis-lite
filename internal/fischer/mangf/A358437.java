package irvine.oeis.a358;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A358437 a(n) = Sum_{j=0..n} binomial(n, j)*C(n)*C(n-j), where C(n) is the n-th Catalan number.
 * @author Georg Fischer
 */
public class A358437 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A358437() {
    super(0, "[[0],[60,-220,240,-80],[0,4,-20,24],[0,-1,-2,-1]]", "1,2,10,75,714,7896,96492,1265550", 0);
  }
}
