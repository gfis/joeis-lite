/*
 * @(#) $Id$
 * 2025-01-04, Georg Fischer: copied form HolonomicRecurrence
 */
package irvine.oeis;

import java.util.ArrayList;
import java.util.Arrays;

import irvine.math.group.PolynomialRing;
import irvine.math.polynomial.Polynomial;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * Compute the coefficients of a generating function A(x) given by some equation that A(x) satifies.
 * The equation is written in the form of an <code>annihilator</code>:
 * <pre>
 * p[0]*1 + p[1]*a[n-k+1] + p[2]*a[n-k+2] + ...+ p[k-1]*a[n-k+k-1] + p[k]*a[n] = 0
 * </pre>
 * <code>k-1</code> is the order of the recurrence,
 * and <code>p[i], i= 0..k</code> are the polynomials (or constants) in <code>n</code>.
 * <code>a[n]</code> is the next term to be computed.
 * @author Georg Fischer
 */
public class PolynomialRingSequence extends AbstractSequence {
  static int sDebug = 0;
  private final int mOffset;
  private Z[] mInitTerms; // initial terms for a(n)
  private int mN; // index of the next sequence element to be computed
  private ArrayList<Z[]> mPolyList; // polynomials as coefficients of <code>n^i, i=0..m</code>
  private int mBufSize; // size of the ring buffer
  private final Polynomial<Z>[] mPolys; // Polynomials referenced in the postfix string as "p0" (the initial value), "p1", "p2" and so on.
  private final Polynomial<Z>[] mStack; // stack where the final expression is computed
  private final String[] mPostfix; // list of operands and operators
  private static final PolynomialRing<Z> RING = new PolynomialRing<>(Integers.SINGLETON);
  private Polynomial<Z> mA; // the generating function A(x)

  /**
   * Construct a holonomic recurrence sequence from String parameters, with a specified type of the generating function.
   * @param offset first valid term has this index
   * @param polys array of polynomials, the coefficients of <code>x^i, i=0..m</code> 
   * are given as comma-separated lists, enclosed in square brackets,
   * for example "[[0],[0,1,2],[17,0,18]]"
   * @param postfix the equation with operands and operators in postfix polish notation, separated by the first character in
   * the string, for example <code>A(x) = 1 + x*A(x*A(x))^2</code> -&gt; <code>;1;x;x;A;*;sub;2;^;*;+</code>.
   */
  public PolynomialRingSequence(final int offset, final String polys, final String postfix) {
    super(offset);
    mOffset = offset;
    mPostfix = postfix.substring(1).split(postfix.substring(0, 1));
    mStack = null;
    mPolys = null;
/*    
    
    int start = 0;
    while (polys.charAt(start) == '[') {
      ++start;
    }
    int behind = polys.length();
    while (polys.charAt(behind - 1) == ']') {
      --behind;
    }
    mPolyList = new ArrayList<>(16);
    if (start <= 1) { // linear case, simple vector of the form "[0,1,2,...]"
      final String[] polys = polys.substring(start, behind).split("\\s*,\\s*");
      for (int k = 0; k < polys.length; ++k) {
        if (sDebug >= 1) {
          System.out.println("polys[" + k + "]=" + polys[k]);
        }
        mPolyList.add(new Z[] {new Z(polys[k])});
      } // for k
    } else { // holonomic case, vector list "[[0,1,2],[0],[17,0,18]]"
      final String[] polys = polys.substring(start, behind).split("]\\s*,\\s*\\[");
      for (int k = 0; k < polys.length; ++k) {
        if (sDebug >= 1) {
          System.out.println("polys[" + k + "]=" + polys[k]);
        }
        mPolyList.add(ZUtils.toZ(polys[k]));
      } // for k
    }
    mInitTerms = (initTerms.isEmpty() || "[]".equals(initTerms)) ? new Z[] { Z.ONE } : ZUtils.toZ(initTerms);

    mN = mOffset - 1;
    mBufSize = k + 2; // at least 1
    mBuffer = new Z[mBufSize];
    Arrays.fill(mBuffer, Z.ZERO);
    
    mA = mPolys[0];
*/
  } // Constructor

  /** 
   * Set the debugging level.
   * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
   */
  public static void setDebug(final int level) {
    sDebug = level;
  }

  /**
   * Gets the next term of the sequence.
   */
  @Override
  public Z next() {
    int ibuf; // index in mBuffer
    final Z result = null;
    ++mN;
    return result;
  } // next

}
