package irvine.oeis.a257;

import irvine.math.z.Z;

/**
 * A257607 Triangle read by rows: T(n,k) = t(n-k, k); t(n,m) = f(m)*t(n-1,m) + f(n)*t(n,m-1), where f(x) = x + 5.
 * @author Georg Fischer
 */
public class A257607 extends A257606 {

  /** Construct the sequence. */
  public A257607() {
    super(new Function() {
      protected long value(final long x) {
        return x + 5;
      }
    }); 
  }
}
