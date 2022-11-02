package irvine.oeis.a167;
// Generated by gen_seq4.pl dersimpln at 2021-08-21 22:23

import irvine.math.z.Z;
import irvine.oeis.a094.A094639;

/**
 * A167892 a(n) = Sum_{k=1..n} Catalan(k)^2.
 * @author Georg Fischer
 */
public class A167892 extends A094639 {

  /** Construct the sequence. */
  public A167892() {
    super.next();
  }

  @Override
  public int getOffset() {
    return 1;
  }

  @Override
  public Z next() {
    return super.next().subtract(1);
  }
}