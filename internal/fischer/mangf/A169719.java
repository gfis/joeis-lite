package irvine.oeis.a169;
// manually copied from A320124

import irvine.oeis.GramMatrixThetaSeries;

/**
 * A169719 Theta series of extremal lattice of dimension 14, level 7 and minimal norm 6.
 * @author Georg Fischer
 */
public class A169719 extends GramMatrixThetaSeries {

  /** Construct the sequence. */
  public A169719() {
    super(new long[][] 
      { {6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0}
      , {-2, 6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0}
      , {2,  -3, 6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0}
      , {-3, 0,  1,  6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0}
      , {-3, 1,  -2, 3,  6,  0,  0,  0,  0,  0,  0,  0,  0,  0}
      , {-1, 3,  0,  2,  0,  6,  0,  0,  0,  0,  0,  0,  0,  0}
      , {-1, 2,  -3, 1,  3,  2,  6,  0,  0,  0,  0,  0,  0,  0}
      , {2,  -2, 0,  -3, -3, -3, -3, 6,  0,  0,  0,  0,  0,  0}
      , {-3, 3,  -1, 1,  1,  3,  0,  -1, 6,  0,  0,  0,  0,  0}
      , {2,  1,  0,  0,  -2, 1,  1,  1,  -2, 6,  0,  0,  0,  0}
      , {-2, 3,  0,  1,  2,  2,  2,  -3, 1,  -1, 6,  0,  0,  0}
      , {-3, 3,  0,  2,  1,  2,  -1, -1, 2,  0,  2,  6,  0,  0}
      , {-3, 3,  -3, 1,  3,  2,  3,  -2, 3,  0,  1,  2,  6,  0}
      , {2,  1,  2,  -2, -1, 1,  0,  -1, 1,  -1, 1,  0,  -1, 6}
      } );
  }
}
