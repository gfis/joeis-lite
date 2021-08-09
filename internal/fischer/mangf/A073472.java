package irvine.oeis.a073;
// manually at 2021-07-04

import irvine.math.z.Z;
import irvine.oeis.a007.A007294;

/**
 * A073472 Trisection of A007294.
 * @author Georg Fischer
 */
public class A073472 extends A007294 {

  /** Construct the sequence. */
  public A073472() {
    super.next();
    super.next();
  }
  
  public Z next() {
    final Z result = super.next();
    super.next();
    super.next();
    return result;
  }
}
