package irvine.oeis.a157;
// Generated by gen_seq4.pl rowsums at 2023-05-31 13:23

import irvine.oeis.a096.A096133;
import irvine.oeis.triangle.RowSumSequence;

/**
 * A157351 Row sums of triangle T(j,k) = (j^k) mod (j*k) for 1 &lt;= k &lt;= j (see A096133).
 * @author Georg Fischer
 */
public class A157351 extends RowSumSequence {

  /** Construct the sequence. */
  public A157351() {
    super(1, new A096133());
  }
}
