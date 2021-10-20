package irvine.oeis.a007;
// manually 2021-10-14

import irvine.oeis.triangle.Triangle;

/**
 * A007318 Pascal&apos;s triangle read by rows: C(n,k) = binomial(n,k) = n!/(k!*(n-k)!), 0 &lt;= k &lt;= n. 
 * @author Georg Fischer
 */
public class A007318 extends Triangle {

  /** Construct the sequence. */
  public A007318() {
    super("1");
  }
}
