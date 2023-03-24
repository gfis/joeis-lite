package irvine.oeis.a218;
// Generated by gen_seq4.pl build/arronk

import irvine.math.z.Z;
import irvine.oeis.a213.A213027;

/**
 * A218478 Number of 3n-length 8-ary words, either empty or beginning with the first letter of the alphabet, that can be built by repeatedly inserting triples of identical letters into the initially empty word.
 * @author Georg Fischer
 */
public class A218478 extends A213027 {

  private int mN = -1;
  
  @Override
  public int getOffset() {
    return 0;
  }

  @Override
  public Z next() {
    ++mN;
    return super.matrixElement(mN, 8);
  }
}

