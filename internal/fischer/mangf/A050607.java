package irvine.oeis.a050;
// Generated by gen_seq4.pl parm3 at 2021-06-28 06:58

import irvine.oeis.a098.A098941;

/**
 * A050607 Numbers k such that base 5 expansion matches (0|1|2)*((0|1)(3|4))?(0|1|2)*
 * @author Georg Fischer
 */
public class A050607 extends A098941 {

  /** Construct the sequence. */
  public A050607() {
    super(5, "([012]*([01][34])?|[34])[012]*");
  }
}
