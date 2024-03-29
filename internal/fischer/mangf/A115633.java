package irvine.oeis.a115;
// Generated by gen_seq4.pl robot/trigf at 2023-05-03 08:27

import irvine.oeis.triangle.GeneratingFunctionTriangle;
/**
 * A115633 A divide and conquer-related triangle: see formula for T(n,k), n &gt;= k &gt;= 0.
 * @author Georg Fischer
 */
public class A115633 extends GeneratingFunctionTriangle {

  /** Construct the sequence. */
  public A115633() {
    super(0, new long[] {1,1,-1,-4,-1,0,0,-1,1,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, new long[] {1,0,0,0,-1,-1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0});
  }
}
