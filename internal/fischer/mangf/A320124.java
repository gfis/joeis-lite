package irvine.oeis.a320;

import irvine.oeis.GramMatrixThetaSeries;

/**
 * A320124 Number of integer solutions to a^2 + b^2 + 2*c^2 + 3*d^2 = n.
 * @author Georg Fischer
 */
public class A320124 extends GramMatrixThetaSeries {

  /** Construct the sequence */
  public A320124() {
    this(new int[] { 1,1,2,3 });
  }
  
  /** 
   * Constructor with exponents, used by subclasses A320* of the same type
   * @param exponents exponents of q
   */
  public A320124(final int[] exponents) {
    super(getMatrix(exponents));
  } 
  
  /**
   * Initialize the Gram matrix with the exponents in the main diagonal.
   * @param exponents the main diagonal
   */
  protected static long[][] getMatrix(final int[] exponents) {
    int dim = exponents.length;
    long[][] matrix = new long[dim][dim];
    for (int i = 0; i < dim; ++i) {
      for (int j = 0; j < dim; ++j) {
        matrix[i][j] = i == j ? exponents[i] : 0;
      }
    }
    return matrix;
  }
}

