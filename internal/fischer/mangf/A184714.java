package irvine.oeis.a184;
// Generated by gen_seq4.pl A183953/arronk

import irvine.math.z.Z;

/**
 * A184714 Number of words of numbers x(1), ..., x(n), in 0..3 such that Sum_{i=1..n} i*x(i)^3 = 27*n.
 * @author Georg Fischer
 */
public class A184714 extends A184720 {

  private int mN = 0;

  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(mN, 3);
  }
}

