package irvine.oeis.a196;
// manually decsolv at 2021-08-10

import irvine.math.cr.CR;

/**
 * A196619 Decimal expansion of the number c for which the curve y=cos(x) is tangent to the curve y=(1/x)-c, and 0<x<2*Pi.
 * @author Georg Fischer
 */
public class A196619 extends A196617 {

  @Override
  public CR getCR() {
    final CR xt = super.getCR();
    return xt.inverse().subtract(xt.cos());
  }
}
