package irvine.oeis.a196;
// manually decsolv at 2021-08-10

import irvine.math.cr.CR;

/**
 * A196620 Decimal expansion of the slope (negative) of the tangent line at the point of tangency of the curves y=cos(x) and y=(1/x)-c, 
 * where c is given by A196619.
 * @author Georg Fischer
 */
public class A196620 extends A196617 {

  @Override
  public CR getCR() {
    return super.getCR().sin();
  }
}
