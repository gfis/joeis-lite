package irvine.oeis.a321;
// Generated by gen_seq4.pl A257673/treonk

import irvine.math.z.Z;
import irvine.oeis.a257.A257673;

/**
 * A321951 Column k=6 of triangle A257673.
 * @author Georg Fischer
 */
public class A321951 extends A257673 {

  private int mN = 5;

  @Override
  public int getOffset() {
    return 6;
  }

  @Override
  public Z next() {
    ++mN;
    return super.triangleElement(mN, 6);
  }
}

