package irvine.oeis.a346;
// Generated by gen_seq4.pl greprec3/holos at 2023-05-08 15:06

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A346949 Value of the permanent of the matrix [1-zeta^{j-k}]_{1&lt;=j,k&lt;=2n}, where zeta is any primitive 2n-th root of unity.
 * @author Georg Fischer
 */
public class A346949 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A346949() {
    super(1, "[[0],[0,2,-4],[1]]", "4,48,1440,80640,7257600,958003200,174356582400", 0);
  }
}
