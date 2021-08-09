package irvine.oeis.a050;
// manually 2021-08-07

import java.util.TreeSet;

import irvine.math.z.Z;
import irvine.oeis.a050.A050137;

/**
 * A050139 a(1)=2; a(n) = floor(a(n-1)/2) if this is not among 0,a(1),...,a(n-1); otherwise a(n) = 4*n.
 * @author Georg Fischer
 */
public class A050139 extends A050137 {

  /** Construct the sequence. */
  public A050139() {
    super(4, 2);
  }

}
