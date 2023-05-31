package irvine.oeis.a321;
// Generated by gen_seq4.pl A257673/treonk

import irvine.math.z.Z;
import irvine.oeis.a257.A257673;

/**
 * A321947 Column k=2 of triangle A257673.
 * @author Georg Fischer
 */
public class A321947 extends A257673 {

  private int mN = 1;

  @Override
  public int getOffset() {
    return 2;
  }

  @Override
  public Z next() {
    ++mN;
    return super.triangleElement(mN, 2);
  }
}

