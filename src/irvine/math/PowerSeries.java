/* PowerSeries from Madore's python moonshine program
 * @(#) $Id$
 * 2020-10-02, Georg Fischer
 */
package irvine.math;

import irvine.math.z.Z;
import java.util.ArrayList;

/**
 * An object class for doing simple operations on power
 * series (actually Laurent series: index is the valuation).
 * Derived from <code>moonshine.py</code> of
 * David A. Madore <david.madore@ens.fr> - 2007-07-31 - Public Domain
 * Cf. https://web.archive.org/web/20130925003421/http://mathforum.org/kb/thread.jspa?forumID=253&threadID=1602206&messageID=5836094 
 * @author Georg Fischer 
 */
public class PowerSeries extends ArrayList<Z> {
  private int mIndex; 
  private static int sDebug = 0;

  /** 
   * Empty constructor. 
   */
  public PowerSeries() {
  }

  /**
   * Construct with index and {@link Z} coefficients
   * @param index current index
   * @param coeffs coefficients of the power series
   */
  public PowerSeries(final int index, final ArrayList<Z> coeffs) {
  	mIndex = index;
  	final int len = coeffs.size();
  	for (int ic = 0; ic < len; ++ic) {
  	  super.add(coeffs.get(ic));
  	}
  }
  
  /**
   * Construct with index and String coefficient list
   * @param index current index
   * @param list coefficient list in the form "[1,2,99]"
   */
  public PowerSeries(final int index, final String list) {
  	mIndex = index;
  	final String[] elems = list.replaceAll("[^\\d\\-\\,]", "").split("\\,");
  	final int len = elems.length;
  	for (int ic = 0; ic < len; ++ic) {
  	  super.add(new Z(elems[ic]));
  	} // for ic
  }
  
  /**
   * Return the current index
   * @return index
   */
  public int getIndex() {
  	return mIndex;
  }
  
  /**
   * Return the (big-O) precision we have
   * @return precision
   */
  protected int precis() {
  	return mIndex + super.size();
  }
  
  /**
   * Return a new series by multiplying s1 and s2
   * @param s1 first series
   * @param s2 secondd series
   * @result product s1*s2
   */
  public PowerSeries multiply(final PowerSeries s2) {
  	final int index = this.mIndex + s2.mIndex;
  	final int len1 = this.size();
  	final int len2 = s2.size();
  	final int len = len1 < len2 ? len1 : len2;
  	ArrayList<Z> coeffs = new ArrayList<Z>(32);
  	for (int ic = 0; ic < len; ++ic) {
  	  Z sum = Z.ZERO;
  	  for (int jc = 0; jc <= ic; ++jc) {
  	  	sum = sum.add(this.get(jc).multiply(s2.get(ic - jc)));
  	  } // for jc
  	  coeffs.add(sum);
  	} // for ic
  	return new PowerSeries(index, coeffs);
  } // multiply
  
  /**
   * Change a series by adding a monomial
   * @param c coefficient of the monomial to be added
   * @param k exponent
   */
  public void addMonomial(final Z c, final int k) {
    final int len = k;
    if (len < mIndex) {
      for (int ic = mIndex - len; ic > 0; --ic) {
        super.add(0, Z.ZERO);
      }
      mIndex = len;
    }   
    super.set(k - mIndex, super.get(k - mIndex).add(c));
  } // addMonomial
    
  /**
   * Change a series by adding a monomial times a series
   * @param c coefficient of the monomial to be added
   * @param k exponent
   * @param f series to be multiplied with the monomial
   */
  public void addMonomialTimes(final Z c, final int k, final PowerSeries f) {
    if (k + f.precis() < mIndex) {
      System.err.println("defined nowhere, k=" + k);
    } else if (k + f.precis() < precis()) {
      super.removeRange(f.precis() - mIndex, super.size());
    }
    final int kfi = k + f.getIndex();
    if (kfi < mIndex) {
      for (int ic = mIndex - kfi; ic > 0; --ic) {
        super.add(0, Z.ZERO);
      }
      mIndex = kfi;
    }   
    final int len = super.size();
    for (int ic = 0; ic < len; ++ic) {
      if (mIndex + ic >= kfi) {
      	super.set(ic, super.get(ic).add(c.multiply(f.get(ic + mIndex - kfi))));
      }
    }
  } // addMonomialTimes
    
  /**
   * Return a given coefficient
   * @param k index (exponent) of the coefficient in the series
   * @return coefficient of exponent <code>k<</code>
   */
  public Z getCoeff(final int k) {
  	Z result = Z.ZERO;
    if (k < mIndex) {
      // result = Z.ZERO;
    } else if (k < precis()) {
      result = super.get(k - mIndex);
    } else {
      System.err.println("insufficient precision, k=" + k);
    }
    return result;
  } // getCoeff
  
  /**
   * Return a representation of <code>this</code> PowerSeries
   * @return for example "[0,0,0,2,11];3"
   */
  public String toString() {
  	StringBuffer result = new StringBuffer(64);
  	result.append('[');
    for (int ic = 0; ic < size(); ++ic) {
      if (ic > 0) {
      	result.append(',');
      }
      result.append(super.get(ic).toString());
    }
    result.append("];");
    result.append(String.valueOf(mIndex));
    return result.toString();
  } // toString
  
  /**
   * Test method
   * @param args command line arguments: 
   * <code>[-d debug] [-i initerms] [-m maxterms] [-p matrix]</code>
   */
  public static void main(String[] args) {
    int maxTerms     = 16;
    String matrix = "[[0],[1],[1],[-1]]"; // Fibonacci 
    String[] initTerms = new String[] { "[1,2]" };
    PowerSeries ps = null;
    if (args.length == 0) {
    } else {
      sDebug = 0;
      int iarg = 0;
      while (iarg < args.length) {
        String opt = args[iarg++];
        try {
          if (false) {
          } else if (opt.equals("-d")) {
            sDebug  = Integer.parseInt(args[iarg++]);
          } else if (opt.equals("-i")) {
          } else if (opt.equals("-m")) {
          } else if (opt.equals("-p")) {
          }
        } catch (Exception exc) {
        }
      } // while
    }
    
    PowerSeries s1 = new PowerSeries(0, "[0,0,1,3,0,0]");
    System.out.println(s1);
    PowerSeries s2 = new PowerSeries(0, "[0,2,5,0,0,0]");
    System.out.println(s2);
    PowerSeries s3 = s1.multiply(s2);
    System.out.println(s3);
    s3.addMonomial(Z.valueOf(17),2);
    System.out.println(s3);
    s3.addMonomialTimes(Z.valueOf(17),2,s1);
    System.out.println(s3);
  } // main

}
