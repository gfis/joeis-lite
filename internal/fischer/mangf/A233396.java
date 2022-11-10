package irvine.oeis.a233;
// manually hologf4/hologf at 2022-11-09 23:22

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A233396 Number of affirmative formulas with two connectives (-&gt; and *) and no variables.
 * @author Georg Fischer
 */
public class A233396 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A233396() {
    // o.g.f. 1/8*(5-(1-8*x)^(1/2)-(10+56*x+6*(1-8*x)^(1/2))^(1/2))/x
    // recurrence -(n+1)*n*(n-1)*(17*n-45)*u(n)-(n-1)*n*(102*(n-4)^2+767*n-2203)*u(n-1)+(n-1)*(4063*(n-4)^3+26067*(n-4)^2+53780*n-180320)*u(n-2)-8*(2*n-5)*(663*(n-4)^3+2716*(n-4)^2+2811*n-10894)*u(n-3)-784*(17*n-28)*(2*n-5)*(2*n-7)*(n-3)*u(n-4) = 0
    super(0, "[[0],[-2304960,3748304,-2216368,567616,-53312],[-394800,674200,-416112,110360,-10608],[23280,-63548,62957,-26752,4063],[0,-571,522,151,-102],[0,-45,17,45,-17]]", "[0,2,6,34,186,1134]", 0);
  }
}
