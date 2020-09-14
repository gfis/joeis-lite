package irvine.math;

import java.util.HashMap;

/**
 * Definition of a five argument function that remembers previously computed results.
 * @author Georg Fische
 * @param <R> result type
 */
public abstract class MemoryFunctionIntArray<R> extends HashMap<String, R> {

  private final StringBuffer mKeyBuf = new StringBuffer(64);
  /**
   * Compute the function at specified parameters.
   * @param a first int parameter
   * @param b second int parameter
   * @param c array of additional int parameters
   * @return value of function
   */
  protected abstract R compute(final int a, final int b, final int[] c);

  /**
   * Return the value of the function at specified parameters.
   * @param a first int parameter
   * @param b second int parameter
   * @param c array of additional int parameters
   * @return value of function
   */
  public R get(final int a, final int b, final int[] c) {
  	mKeyBuf.setLength(0);
	mKeyBuf.append(a);
	mKeyBuf.append(',');
	mKeyBuf.append(b);
  	for (int i = 0; i < c.length; ++i) {
 	    mKeyBuf.append(',');
  		mKeyBuf.append(c[i]);
    } 
    final String key = mKeyBuf.toString();
    final R res = get(key);
    if (res != null) {
      return res;
    }
    final R r = compute(a, b, c);
    put(key, r);
    return r;
  }
}
