package irvine.oeis.a137;

import irvine.math.z.Z;
import irvine.oeis.a168.A168281;

/**
 * A137508 Successive structures of alkaline earth metals (periodic table elements from 2nd column).
 * @author Georg Fischer
 */
public class A137508 extends A168281 {

  /** Construct the sequence. */
  public A137508() {
    super.next(); // skip leading 2
  }
}
