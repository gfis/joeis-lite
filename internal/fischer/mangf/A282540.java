package irvine.oeis.a282;

import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A282540 Eisenstein series E_32(q) (alternate convention E_16(q)), multiplied by 7709321041217.
 * <code>a(n) = 764412173217*A282474(n) + 5323905468000 * A282541(n) + 1621003400000 * A282543(n)</code>
 * @author Georg Fischer
 */
public class A282540 extends Sequence0 {

  private final A282474 mSeq1 = new A282474();
  private final A282541 mSeq2 = new A282541();
  private final A282543 mSeq3 = new A282543();
  
  @Override
  public Z next() {
    return mSeq1.next().multiply(764412173217L).add(mSeq2.next().multiply(5323905468000L)).add(mSeq3.next().multiply(1621003400000L));
  }
}
