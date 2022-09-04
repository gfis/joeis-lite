package irvine.oeis.a037;

import irvine.math.z.Z;
import irvine.oeis.a000.A000796;

/**
 * A037244 Base 100 expansion of Pi.
 * @author Sean A. Irvine
 */
public class A037244 extends A000796 {

  private boolean mFirst = true;

  /** Construct the sequence. */
  public A037244() {
    super(0);
  }

  @Override
  public Z next() {
    if (mFirst) {
      mFirst = false;
      return super.next();
    }
    return super.next().multiply(10).add(super.next());
  }
}
