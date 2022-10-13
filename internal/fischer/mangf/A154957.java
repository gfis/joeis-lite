package irvine.oeis.a154;

import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;
import irvine.oeis.a003.A003983;

/**
 * A154957 A symmetric (0,1)-triangle.
 * @author Georg Fischer
 */
public class A154957 extends A003983 implements SequenceWithOffset {

  @Override
  public int getOffset() {
    return 0;
  }

  @Override
  public Z next() {
    return super.next().mod(Z.TWO);
  }
}
