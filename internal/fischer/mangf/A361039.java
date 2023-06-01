package irvine.oeis.a361;
// Generated by gen_seq4.pl binomin/holos at 2023-05-08 14:44

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361039 a(n) = 55440 * (3*n)!/((2*n)!*(n+4)!).
 * @author Georg Fischer
 */
public class A361039 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361039() {
    super(0, "[[0],[-6,27,-27],[-8,14,4]]", "[2310,1386]", 0);
  }
}