package irvine.oeis.a362;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A362210 Expansion of 1/(1 - x/(1-9*x)^(2/3)).
 * Recurrence: -(n-1)*(n-2)*(2*n-11)*u(n)+6*(n-2)*(12*(n-5)^2+27*n-149)*u(n-1)-(972*(n-5)^3+3888*(n-5)^2+3222*n-17712)*u(n-2)-(-5834*(n-5)^3-16051*(n-5)^2-9899*n+52099)*u(n-3)-(13158*(n-5)^3+19827*(n-5)^2+9573*n-46443)*u(n-4)+9*(3*n-13)*(2*n-9)*(3*n-14)*u(n-5) = 0.
 * @author Georg Fischer
 */
public class A362210 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A362210() {
    super(0, "[[0],[-14742,9837,-2187,162],[1195518,-798153,177543,-13158],[-380074,286939,-71459,5834],[42012,-37242,10692,-972],[-1812,2022,-702,72],[22,-37,17,-2]]", 
        "[1,1,7,58,505,4498]", 0);
  }
}
