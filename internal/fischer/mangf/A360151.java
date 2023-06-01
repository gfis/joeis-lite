package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360151 a(n) = Sum_{k=0..floor(n/3)} binomial(2*n-4*k,n-3*k).
 * @author Georg Fischer
 */
public class A360151 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360151() {
    // o.g.f. 1/(1-4*x)^(1/2)/(1-1/4*x*(1-(1-4*x)^(1/2))^2)
    // recurrence -n*(5*(n-5)^2+30*n-106)*u(n)-(-25*(n-5)^3-265*(n-5)^2-910*n+3540)*u(n-1)-(30*(n-5)^3+320*(n-5)^2+1104*n-4290)*u(n-2)+4*(2*n-5)*(5*(n-5)^2+40*n-121)*u(n-3)-n*(5*(n-5)^2+30*n-106)*u(n-4)+2*(2*n-5)*(5*(n-5)^2+40*n-121)*u(n-5) = 0
    super(0, "[[0],[-40,116,-90,20],[0,-19,20,-5],[-80,232,-180,40],[40,-154,130,-30],[-40,135,-110,25],[0,-19,20,-5]]", "[1,2,6,21,74,267]", 0);
  }
}