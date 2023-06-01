package irvine.oeis.a360;
// Generated by gen_seq4.pl hologfm/hologf at 2023-05-08 16:07

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360149 a(n) = Sum_{k=0..floor(n/2)} binomial(2*n+k,n-2*k).
 * @author Georg Fischer
 */
public class A360149 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360149() {
    // o.g.f. 1/(1-4*x)^(1/2)/(1-1/32/x^3*(1-(1-4*x)^(1/2))^5)
    // recurrence -n*((n-4)^3-7*(n-4)^2-12*n+42)*u(n)-(-9*(n-4)^4+29*(n-4)^3+300*(n-4)^2+412*n-1480)*u(n-1)-(24*(n-4)^4-82*(n-4)^3-660*(n-4)^2-926*n+3368)*u(n-2)-(-17*(n-4)^4+59*(n-4)^3+440*(n-4)^2+622*n-2272)*u(n-3)-2*(2*n-7)*((n-4)^3-4*(n-4)^2-23*n+68)*u(n-4) = 0
    super(0, "[[0],[-840,1038,-452,78,-4],[3360,-4286,1900,-331,17],[-4200,5726,-2628,466,-24],[840,-1708,912,-173,9],[0,134,-92,19,-1]]", "[1,2,7,27,107]", 0);
  }
}