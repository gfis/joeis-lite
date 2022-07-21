package irvine.oeis.a111;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A111708 a(n) = n concatenated with 9&apos;s complement of n.
 * @author Georg Fischer
 */
public class A111708 implements Sequence {

  private int mN;

  /** Construct the sequence. */
  public A111708() {
    mN = -1;
  }

  @Override
  public Z next() {
    ++mN;
    String nstr = String.valueOf(mN);
    StringBuilder sb = new StringBuilder(nstr);
    for (int i = 0; i < nstr.length(); ++i) {
      sb.append(Character.forDigit(9 - Character.digit(nstr.charAt(i), 10), 10));
    }
    return new Z(sb.toString());
  }
}
