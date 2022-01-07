package irvine.oeis.a093;

import java.util.HashSet;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A093211 a(n) is the largest number such that all of a(n)'s length-n substrings are distinct and divisible by 11..
 * @author Georg Fischer
 */
public class A093211 extends HashSet<Integer/**/> implements Sequence {

  protected int/**/ mDivm;
  protected int/**/ mLast;
  protected int/**/ mN;

  /** Construct the sequence. */
  public A093211() {
    this(11);
  }

  /**
   * Generic constructor with parameters
   * @param div divisor
   */
  public A093211(final int div) {
    mDivm = div;
    mN = 0;
  }

  @Override
  public Z next() {
    return Z.valueOf(compute(++mN));
  }

  public int debug = 0;

  public int pow(int a, int b) { // from https://stackoverflow.com/questions/8071363/calculating-powers-of-integers
      if (b == 0)        return 1;
      if (b == 1)        return a;
      if ((b & 1) == 0)  return     pow (a * a, b/2); //even a=(a^2)^b/2
      else               return a * pow (a * a, b/2); //odd  a=a*(a^2)^b/2
  }
  
  private int[] setgoodlist(final int/**/ len, final int/**/ adiv) {
    final int[] btmp = new int[] {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}; // 0..9
    for (int i = 0; i < 10; ++i) {
      final int/**/ remain = (adiv - i * this.pow(10, len - 1)) % adiv;
      if ((adiv - 10 * remain) % adiv > 9) {
        btmp[i] = 0; // remove
      }
    }
    // if (debug >= 2) { System.out.println(join(", ", @btmp) . "\n"; }
    return btmp;
  }

  private int/**/ dropdigs(final int/**/ k, final int/**/ l) {
    int/**/ ktmp = (k / l) * l;
    ktmp --;
    while ((ktmp % mDivm) != 0) {
      ktmp --;
    }
    if (debug >= 2) { System.out.println("dropdigs(" + k + "," + l + ") -> " + ktmp); }
    return ktmp;
  } // dropdigs

  private int/**/ walking(final int/**/ k) {
    int/**/ aa = 0;
    int/**/ kt = k * 10;
    int/**/ ktl = kt % mLast;
    if (((ktl - 1) % mDivm) + 10 < mDivm) {
      return aa;
    }
    int/**/ a;
    if (ktl % mDivm == 0) {
      a = kt;
    } else {
      a = kt + (mDivm - (ktl % mDivm));
    }

    int/**/ al = a % mLast;
    if (! contains(al)) {
      add(al);
      if (a > aa) {
        aa = a;
      }
      int/**/ atmp = walking(a);
      if (atmp > aa) {
        aa = atmp;
      }
      remove(al);
    }
    if (debug >= 4) {
      System.out.println("walking(" + k + ") -> " + aa);
    }
    return aa;
  } // walking

  protected int/**/ compute(int/**/ n) {
    final int[] goodlist = setgoodlist(n, mDivm);
    mLast = this.pow(10, n);
    int/**/ beg = this.pow(10, n) - 1; // '9' x n
    int/**/ end = this.pow(10, n-1);
    if (debug >= 2) { System.out.println("n=" + n + ", beg=" + beg + ", end=" + end); }
    int/**/ i = beg;
    while (i % mDivm != 0L) {
      i -= 1;
    }
    int/**/ an = i;
    int/**/ oldan = an;
    int/**/ anlen = n;
    while (i > end) {
      add(i);
      if (i % 100000L == 0) {
        anlen = String.valueOf(an).length();
        if (anlen > 2*n) {
          anlen = 2*n - 1;
        }
      }
      int/**/ wi = walking(i);
      if (wi > an) {
        an = wi;
      }
      i -= mDivm;
      for (int/**/ j = 0; j < anlen - n + 1; j ++) {
        int/**/ jten = this.pow(10, n - j - 1);
        if (jten < 1) {
          break;
        }
        while (goodlist[(i / jten) % 10] == 0) {
          i = dropdigs(i, jten);
        }
      } // for j
    } // while i
    System.out.println(n + " " + an);
    return an;
  }

  /**
   * Main method for testing
   * @param args command line arguments: divisor
   */
  public static void main(String[] args) {
    int/**/ divisor = 11;
    try {
      divisor = Integer.parseInt(args[0]);
    } catch (Exception exc) {
    }
    
    A093211 seq = new A093211(divisor);
    for (int n = 1; n < 12; n ++) { // main loop
      System.out.println(n + " " + seq.next());
    }
  }

}

/* John Cerkan, Python2.7 in the OEIS:
divm = 11
n = 11
last = 10**n
ssts = []

def setgoodlist(len, adiv):
    atmp = [0,1,2,3,4,5,6,7,8,9]
    btmp = [0,1,2,3,4,5,6,7,8,9]
    for i in atmp:
        remain = (adiv - i*(10 **(len-1))) % adiv
        if (adiv - 10*remain) % adiv > 9:
            btmp.remove(i)
    return btmp

def dropdigs(k,l):
    ktmp = (k // l) * l
    ktmp -= 1
    while (ktmp % divm) != 0:
        ktmp -= 1
    return ktmp

def walking(k):
    aa = 0
    kt = k*10
    ktl = kt % last
    if ((ktl - 1) % divm) + 10 < divm:
        return aa
    if ktl % divm == 0:
        a = kt
    else:
        a = kt + (divm - (ktl % divm))

    al = a % last
    if al not in ssts:
        ssts.append(al)
        aa = max(aa,a)
        atmp = walking(a)
        aa = max(aa,atmp)
        ssts.remove(al)
    return aa


for n in range(2,12):
    goodlist = setgoodlist(n,divm)
    last = 10**n
    beg = int(n*'9')
    end = int((n-1)*"9")
    i = beg
    while i % divm != 0:
        i -= 1
    an = i
    oldan = an
    anlen = n
    while i > end:
        ssts = [i]
        if i % 100000 == 0:
            anlen = len(str(an))
            if anlen > 2*n:
                anlen = 2*n - 1
        an = max(an,walking(i))
        i -= divm
        for j in range(anlen - n+1):
            jten = 10 ** (n - j-1)
            if jten < 1:
                break
            while (i // jten) % 10 not in goodlist:
                i = dropdigs(i,jten)
    print str(n) + "   " + str(an)
*/