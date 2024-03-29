package irvine.oeis.a290;
// Generated by gen_seq4.pl rectoproc/holos5 at 2023-06-02 21:44

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A290575 Ap√©ry-like numbers Sum_{k=0..n} (C(n,k) * C(2*k,n))^2.
 * 16*(n-1)^3*a(n-2)-4*(2*n-1)*(3*n^2-3*n+1)*a(n-1)+a(n)*n^3
 * @author Georg Fischer
 */
public class A290575 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A290575() {
    super(0, "[[0],[-16,48,-48,16],[4,-20,36,-24],[0,0,0,1]]", "1,4,40,544", 0);
  }
}
