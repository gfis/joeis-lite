package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import java.util.ArrayList;
/**
 * A (siple) continued fraction for the square root of a number,
 * the numerators, denominators, period elements and so on.
 * @author Georg Fischer
 */
public class SqrtContinuedFraction implements Sequence {

  protected int mIndex; // index of current term to be returned
  protected final Z mN; // compute the sqrt of this number
  protected Z mRoot; // the integer root, floor(sqrt(n))          
  protected Z mB0; // numerator   of old partial fraction       
  protected Z mB1; // denominator of new partial fraction       
  protected Z mC0; // old convergent numerator   
  protected Z mC1; // new convergent numerator
  protected Z mD0; // old convergent denominator 
  protected Z mD1; // new convergent denominator 
  protected Z mP0; // numerator   of old partial fraction       
  protected Z mP1; // denominator of new partial fraction       
  protected Z mQ0; // numominator of old partial fraction       
  protected Z mQ1; // denominator of new partial fraction       
  protected int mPerInd; // index  in period
  protected int mPerLen; // length of period
  protected ArrayList<Z> mPeriod;

  /**
   * Construct the specified continued fraction.
   * @param offset first valid term has this index
   * @param n compute the sqrt of this non-negative number 
   */
  protected SqrtContinuedFraction(final int offset, final Z n) {
    mIndex  = offset;
    mN      = n;
    mRoot   = n.sqrt();
    mP0     = Z.ZERO;
    mQ0     = Z.ONE ;
    mB0     = mRoot;
    mP1     = Z.ZERO;
    mQ1     = Z.ZERO;
    mB1     = Z.ONE;
    mPerInd = 0; // index in mPeriod
    mPerLen = -1; // undefined so far
    mPeriod = new ArrayList<Z>(16);
    mC0     = Z.ONE;
    mD0     = Z.ZERO;
    mC1     = mRoot;
    mD1     = Z.ONE;
  }

  /**
   * Construct the specified continued fraction.
   * @param offset first valid term has this index
   * @param n compute the sqrt of this non-negative number 
   */
  protected SqrtContinuedFraction(final int offset, final long n) {
    this(offset, Z.valueOf(n));
  }

  /**
   * Construct the specified continued fraction.
   * The offset defaults to 0.
   * @param n compute the sqrt of this non-negative number 
   */
  protected SqrtContinuedFraction(final long n) {
    this(0, Z.valueOf(n));
  }

  /** 
   * Compute the elements for the next partial fraction
   */
  public void iterate() {
    mIndex ++;
    if (mRoot.multiply(mRoot).compareTo(mN) != 0) { // no square number
      mP1 = mB0.multiply(mQ0).subtract(mP0);
      mQ1 = mN.subtract(mP1.multiply(mP1)).divide(mQ0);
      mB1 = mRoot.add(mP1).divide(mQ1);
      if (mPerLen < 0) {
        if (mQ0.compareTo(mQ1) == 0) {
          mPerLen = (mPerInd) * 2 + 1;
        }
        else
        if (mP0.compareTo(mP1) == 0) {
          mPerLen = (mPerInd) * 2 + 0;
        }
        mPerInd ++;
      }
      mP0 = mP1;
      mQ0 = mQ1;
      mB0 = mB1;
      if (mPerLen < 0 || mIndex <= mPerLen) {
        mPeriod.add(mB1);
      }
      Z mC2 = mB1.multiply(mC1).add(mC0);
      Z mD2 = mB1.multiply(mD1).add(mD0);
      mC0 = mC1;
      mC1 = mC2;
      mD0 = mD1;
      mD1 = mD2;
      
    } else {
      mB0 = Z.ZERO;
    } // no square number
  } // next

  /** 
   * Get the next term of the sequence.
   * @return the partial denominator
   */
  @Override
  public Z next() {
    Z result  = mB0;
    iterate();
    return result;
  } // next

  /** Test method.
   *  @param args command line arguments:
   *  [n [noterms]]
   */
  public static void main(String[] args) {
    int n = 28;
    int iarg = 0;
    if (iarg < args.length) {
      try {
        n = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    int noterms = 16;
    if (iarg < args.length) {
      try {
        noterms = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    SqrtContinuedFraction cf = new SqrtContinuedFraction(n);
    int iterm = 0;
    while (iterm < noterms) {
      System.out.print(iterm
        + ":\tB0=" + cf.mB0
        +  ", B1=" + cf.mB1
        +  ", P0=" + cf.mP0
        +  ", P1=" + cf.mP1
        +  ", Q0=" + cf.mQ0
        +  ", Q1=" + cf.mQ1
        + ",\tPerLen=" + cf.mPerLen
        +  ", PerInd=" + cf.mPerInd
        + "\t"     + cf.mC1 + "/" + cf.mD1
        );
      System.out.println("\t-> "  
        + cf.next().toString()
        );
      iterm ++;
    } // while iterm
    System.out.println(cf.mPeriod + " length=" + cf.mPeriod.size());
  } // main
  
} // SqrtContinuedFraction
