package irvine.oeis.a192;
// manually deris2/essent at 2021-11-04

import irvine.oeis.PrependSequence;
import irvine.oeis.a034.A034887;

/**
 * A192543 Same as A034887 except for the offset and a(1). - _T. D. Noe_, Feb 11 2013
 * @author Georg Fischer
 */
public class A192543 extends PrependSequence {

  /** Construct the sequence. */
  public A192543() {
    super(1, new A034887(), 0);
  }
}
