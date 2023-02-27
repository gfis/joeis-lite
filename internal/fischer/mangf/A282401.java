package irvine.oeis.a282;

import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A282401 Eisenstein series E_28(q) (alternate convention E_14(q)), multiplied by 3392780147.
 * <code>a(n) = 489693897*A282402(n) + 2507636250*A282403(n) + 395450000*A282404(n).</code>
 * @author Georg Fischer
 */
public class A282401 extends Sequence0 {

  private final A282402 mSeq1 = new A282402();
  private final A282403 mSeq2 = new A282403();
  private final A282404 mSeq3 = new A282404();
  
  @Override
  public Z next() {
    return mSeq1.next().multiply(489693897L).add(mSeq2.next().multiply(2507636250L)).add(mSeq3.next().multiply(395450000L));
  }
}
