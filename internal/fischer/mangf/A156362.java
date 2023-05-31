package irvine.oeis.a156;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A156362 a(2*n+2) = 8*a(2*n+1), a(2*n+1) = 8*a(2*n) - 7^n*A000108(n), a(0)=1.
 * @author Georg Fischer
 */
public class A156362 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A156362() {
    super(0, "[[0],[448,-224],[-56,28],[8,8],[-1,-1]]", "1,7,56,441,3528,28126,225008,1798349,14386792", 0);
  }
}
