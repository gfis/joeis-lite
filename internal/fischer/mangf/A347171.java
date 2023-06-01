package irvine.oeis.a347;
// Generated by gen_seq4.pl robot/trigf at 2023-05-03 08:27

import irvine.oeis.triangle.GeneratingFunctionTriangle;
/**
 * A347171 Triangle read by rows where T(n,k) is the sum of Golay-Rudin-Shapiro terms GRS(j) (A020985) for j in the range 0 &lt;= j &lt; 2^n and having binary weight wt(j) = A000120(j) = k.
 * @author Georg Fischer
 */
public class A347171 extends GeneratingFunctionTriangle {

  /** Construct the sequence. */
  public A347171() {
    super(0, new long[] {1,0,2,0,0,0}, new long[] {1,-1,1,0,-2,0,0,0,0,0});
  }
}