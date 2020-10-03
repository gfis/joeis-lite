package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.McKayThompsonTables;
import irvine.math.PowerSeries;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/**
 * McKay-Thompson series for the monster group.
 * Derived from <code>moonshine.py</code> of
 * David A. Madore <david.madore@ens.fr> - 2007-07-31 - Public Domain
 * Cf. https://web.archive.org/web/20130925003421/http://mathforum.org/kb/thread.jspa?forumID=253&threadID=1602206&messageID=5836094 
 * @author Georg Fischer
 */
public class McKayThompsonSequence implements Sequence {

  private static int sDebug = 0; // debugging mode: 0 = none, 1 = some, 2 = more

  /** Number of different class codes in the ATLAS */
  public static final int MAX_CLASS = 194; 

  /**
   * Get a list of class codes for powers
   * @param classCode get the powers for this class
   * @return a list of class codes
   */
  protected String[] getPower(final String classCode) {
    return McKayThompsonTables.sPowerMap.get(classCode);
  }
  
  /**
   * Get a list of boot coefficients
   * @param classCode get the boot coefficients for this class
   * @return a list of boot coefficients
   */
  protected Z[] getBoots(final String classCode) {
    final Long[] bootL = McKayThompsonTables.sBootsMap.get(classCode);
    final Z[] bootZ = new Z[bootL.length];
    for (int i = 0; i < bootL.length; ++i) {
        bootZ[i] = Z.valueOf(bootL[i]);
    }
    return bootZ;
  }
  
  /** Empty constructor */
  public McKayThompsonSequence() {
    this("18A");
  }
  
  /** 
   * Constructor with class code.
   * @param classCode class code in the ATLAS, 
   * for example "1A", "119B", or combined like "39CD"
   **/
  public McKayThompsonSequence(final String classCode) {
    final String cl = classCode; // desired class
  }

  protected long mN = -2; 
  
  @Override
  public Z next() {
    return Z.valueOf(mN);
  }
  
  /* Main storage of coefficients */
  private final HashMap<String, ArrayList<Z>> coefs = new HashMap<String, ArrayList<Z>>(MAX_CLASS); 
    
  /* Position of first unknown coefficient for each class */
  private final HashMap<String, Integer> posun1 = new HashMap<String, Integer>(MAX_CLASS);// coefs is the main storage of coefficients

  /** 
   * Get the position of first unknown coefficient for a class
   * @param classCode get the position for this class
   * @return int
   */
  private int lencomplete(String classCode) {
    return posun1.get(classCode).intValue();
  }

  /**
   * Computes the sequences for a subset of class codes
   * @param classes the subset of class codes
   */ 
  public void compute(final String[] classes) {
    int lenprinted = 1;
    for (String cl: classes) {
      final Z[] blist = getBoots(cl); 
      final int len = blist.length;
      posun1.put(cl, new Integer(len));
      final ArrayList<Z> alist = new ArrayList<Z>(len);
      for (int i = 0; i < len; ++i) {
        alist.add(blist[i]);
      }
      coefs.put(cl, alist);
    }
    
    while (true) {
      for (String cl: classes) { 
        // Start by forming a series with whatever contiguous
        // coefficients we have (i.e. j is the best approximation we
        // have so far on the Moonshine function for class cl).
        final int lenk = lencomplete(cl);
        ArrayList<Z> jcoefs = new ArrayList<Z>(lenk);
        for (int k = 0; k < lenk; ++k) {
          jcoefs.add(coefs.get(cl).get(k));
        }
        final PowerSeries j = new PowerSeries(0, jcoefs);
        // Now compute the first Faber polynomials of j:
        final PowerSeries[] jFaber = new PowerSeries[6];
        int ijf = 0;
        jFaber[ijf++] = new PowerSeries();
        jFaber[ijf++] = j;
        final int min7 = Math.min(lencomplete(cl), jFaber.length + 1); // 7
        for (int n = 2; n < min7; ++n) {
          // (Here 7 is a heuristic, meaning we compute the first 6 Faber
          // polynomials: any value at least equal to 5 should work, but
          // higher values are interesting only if you wish to earlyprint
          // high coefficients.
          // Besides, if you make this higher than 10
          // you need to extend the class power maps.)
          final PowerSeries jn = jFaber[n - 1].multiply(j);
          for (int k = n - 2; k > 0; --k) {
              jn.addMonomialTimes(jn.getCoeff(- k).negate(), 0 ,jFaber[k]);
          }
          jn.addMonomial(jn.getCoeff(0).negate(), 0);
          jFaber[ijf++] = jn;
          // At this point, jn is the n-th Faber polynomial of j.
          for (int k = 1; k < jn.precis(); ++k) {
            if (coefs.get(cl).size() > k * n) {
              // Compute a coefficient from the action of the n-th
              // Hecke operator (with just n*coefs[k*n], the one we
              // will deduce, missing from the sum):
              // try:
              Z v = Z.ZERO;
              for (int d = 1; d < n; ++d) { // d = all in strictDivisors
                if (n % d == 0) { // d divides n
                  final int a = n / d;
                  final String cla = getPower(cl)[a];
                  if ((k % a) == 0) {
                    final int kk = (k / a) * d;
                    if (coefs.get(cl).size() > kk) {
                      v = v.add(Z.valueOf(n / a).multiply(coefs.get(cla).get(kk)));
                    } else { 
                      throw new RuntimeException("missing coefficient #1: " + String.valueOf(kk));
                    }
                  }
                  Z w = jn.getCoeff(k).subtract(v);
                  if (w.remainder(Z.valueOf(n)).compareTo(Z.ZERO) != 0) {
                    throw new RuntimeException("divisibility check failed");
                  }
                  w = w.divide(Z.valueOf(n));
                  coefs.get(cl).set(k * n, w);
                } // if d divides n
              } // foreach divisor
            } // if
          } // foreach k
        } // for n
      } // for classes
      
      // Now try the other way around: deduce some lower coefficients
      // from the higher ones (known through the Hecke operators).  We
      // only use T_2 here, so we only deal with F_2(j), which is
      // essentially j^2 (up to a constant -2*c1 we don't care about
      // since we're interested only in one, higher, coefficient).
      for (String cl: classes) { 
        final String cl2 = getPower(cl)[2];
        boolean busy = true;
        while (busy) {
          // See if lencomplete can be increased.
          while (coefs.get(cl).size() > lencomplete(cl)) {
            posun1.put(cl, new Integer(lencomplete(cl) + 1));
          }
          // Try to compute the first unknown coefficient
          // (lencomplete) by computing the previous coefficient in
          // 2 T_2(j) and equating.
          final int k = lencomplete(cl) - 1;
          if (coefs.get(cl).size() <= k * 2 ) {
            System.out.println("missing coefficient #2: " + String.valueOf(k * 2));
            busy = false;
          }
          Z v = Z.TWO.multiply(coefs.get(cl).get(k * 2));
          if ((k % 2) == 0) {
            if (coefs.get(cl2).size() <= k / 2) {
              System.out.println("missing coefficient #3: " + String.valueOf(k / 2));
              busy = false;
            }
            v = v.add(coefs.get(cl2).get(k / 2));
          }
          // At this point, v is coefficient k of j^2, computed from
          // the Hecke operators.  Now we can deduce coefficient k+1
          // of j from this:
          for (int i = 1; i < k; ++i) {
            v = v.subtract(coefs.get(cl).get(i).multiply(coefs.get(cl).get(k - i)));
          }
          if (! v.isEven()) {
            System.out.println("Evenness check failed!");
          }
          v = v.divide2();
          coefs.get(cl).set(k + 1, v);
        } // while busy
      } // foreach cl
    } // while 1
  }
}
/*


    
    while (true) {
      for (String cl: classes) { 
        // Start by forming a series with whatever contiguous
        // coefficients we have (i.e. j is the best approximation we
        // have so far on the Moonshine function for class cl).
        ArrayList<Z> jcoefs = new ArrayList<Z>();
        for (int k = 0; k < lencomplete[cl]; ++k) {
          jcoefs.add(Z.valueOf(coefs[cl][k]));
        }
        final PowerSeries j = new PowerSeries(0, jcoefs);
        // Now compute the first Faber polynomials of j:
        final PowerSeries[] jFaber = new PowerSeries[6];
        int ijf = 0; // index in jFaber
        jFaber[ijf ++] = new PowerSeries();
        jFaber[ijf ++] = j;
        final int min7 = Math.min(lencomplete[cl], 7);
        for (int n = 2; n < min7; ++n) {
          // (Here 7 is a heuristic, meaning we compute the first 6 Faber
          // polynomials: any value at least equal to 5 should work, but
          // higher values are interesting only if you wish to earlyprint
          // high coefficients.
          // Besides, if you make this higher than 10
          // you need to extend the class power maps.)
          final PowerSeries jn = jFaber[n-1].multiply(j);
          for (int k = n - 2; k > 0; --k) {
              jn.addMonomialTimes(- jn.getCoeff(- k), 0 ,jFaber[k]);
          }
          jn.addMonomial(- jn.getCoeff(0), 0);
          jFaber[ijf ++] = jn;
          // At this point, jn is the n-th Faber polynomial of j.
          ArrayList<Z> ld = strictDivisors(n);
          for (int k = 1; k < jn.precis(); ++k) {
            if (! coefs.has_key((cl,k*n))) {
              // Compute a coefficient from the action of the n-th
              // Hecke operator (with just n*coefs[k*n], the one we
              // will deduce, missing from the sum):
              //                    try:
              long v = 0;
              for (int d = 1; d < n; ++d) { // d = all in strictDivisors
                if (n % d == 0) { // d divides n
                  final int a = n / d;
                  final int cla = clpowers[cl][a];
                  if ((k % a) == 0) {
                    final int  kk = (k / a) * d;
                    if (coefs.has_key((cla,kk))) {
                      v += (n / a) * coefs[cla][kk];
                    } else { 
                      throw new RuntimeException("missing coefficient #1: " + String.valueOf(kk));
                    }
                  }
                  long w = jn.getCoeff(k) - v;
                  if ((w % n) != 0) {
                    throw new RuntimeException("divisibility check failed")
                  }
                  w /= n;
                  coefs[cl][k * n] = w;
                } // if d divides n
              } // foreach divisor
            } // if
          } // foreach k
        } // foreach n 
      } // foreach cl
        
      // Now try the other way around: deduce some lower coefficients
      // from the higher ones (known through the Hecke operators).  We
      // only use T_2 here, so we only deal with F_2(j), which is
      // essentially j^2 (up to a constant -2*c1 we don't care about
      // since we're interested only in one, higher, coefficient).
      foreach cl (classes) { 
        final int cl2 = clpowers[cl][2];
        while (1) {
          // See if lencomplete can be increased.
          while (defined(coefs[lencomplete])) {
            lencomplete += 1;
            // Try to compute the first unknown coefficient
            // (lencomplete) by computing the previous coefficient in
            // 2 T_2(j) and equating.
            short k = lencomplete - 1;
            if (! defined(coefs[k * 2])) {
              throw new RuntimeException("missing coefficient #2: " + String.valueOf(k * 2));
            }
            v = 2 * coefs{cl}[k * 2];
            if ((k % 2) == 0) {
              if (! defined(coefsey((cl2,k / 2))) {
                throw new RuntimeException("missing coefficient #3: " + String.valueOf(k / 2));
              }
              v += coefs{cl2}[k / 2];
            }
            // At this point, v is coefficient k of j^2, computed from
            // the Hecke operators.  Now we can deduce coefficient k+1
            // of j from this:
            for (int i = 1; i < k; ++i) {
              v -= coefs{cl}[i] * coefs{cl}[k - i];
            }
            if ((v % 2) != 0) {
              throw new RuntimeException("Evenness check failed!")
            }
            v /= 2;
            coefs[cl][k + 1] = v;
          }
        }    
      } // foreach cl
      
      // Print what we've computed so far, in orderly fashion:
      short lastcomplete = lencomplete;
      foreach short k (lenprinted..lastcomplete - 1) {
          print sprintf("%d %d\n", k + 1, v);
      }
      lenprinted = lastcomplete;
    } // while true
  } // Compute
  
}
*/
