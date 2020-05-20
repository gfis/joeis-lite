/* Properties and methods for a uniform tiling and its coordination sequences
 * @(#) $Id$
 * Copyright (c) 2020 Dr. Georg Fischer
 * 2020-05-15, Georg Fischer: extracted from Tiler.java
 */
package org.teherba.tile;
import org.teherba.tile.Position;
import org.teherba.tile.PositionMap;
import org.teherba.tile.Vertex;
import org.teherba.tile.VertexList;
import org.teherba.tile.VertexType;
import org.teherba.tile.VertexTypeArray;
import irvine.oeis.Sequence;
import irvine.math.z.Z;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

/**
 * This class generates coordination sequences for k-uniform tilings
 * in the OEIS as specified by Brian Galebach.
 * A uniform tiling is built from a subset of the regular polygones
 * triangle, square, hexagon and dodecagon (other regular polygones like
 * the pentagon cannot be used). All edges are of unit length.
 * At the corners one of the 11 archimedian vertex types occur,
 * maybe in reverse (flipped) orientation. 
 * A coordination sequence enumerates the number of vertices
 * which have a certain minimal distance to the base vertex.
 *
 * @author Georg Fischer
 */
public class TilingSequence implements Serializable, Sequence
    {
  public final static String CVSID = "@(#) $Id: Vertex.java $";

  /** Debugging mode: 0=none, 1=some, 2=more */
  public static int sDebug;

  /** index of the first sequence element */
  protected int mOffset;

  /** Possible {@link VertexType}s in this tiling */
  public VertexTypeArray mTypeArray;
  
  /** Allocated vertices */
  public VertexList mVertexList;

  /** Positions to vertices */
  public PositionMap mPosMap; 

  /** Index of the base {@link Vertex} for the coordination sequence */
  public int mBaseIndex; 

  /** Queue for vertices which must be investigated for next shell */
  private LinkedList<Integer> mQueue;
  
  /** Distance of the current shell to the baseVertex */
  private int mDistance; 
  
  /** how many vertices were added for current shell */
  private int mShellCount;
  
  /**
   * Empty Constructor - not used.
   */
  public TilingSequence() {
  } // Constructor(int)

  /**
   * Constructor from {@link VertexTypeArray}.
   * Initializes the data structures of <em>this</em> TilingSequence.
   * @param offset index of first sequence element
   * @param typeArray array of {@link VertexTypes} for this TilingSequence
   */
  public TilingSequence(final int offset, final VertexTypeArray typeArray) {
    mOffset = offset;
    mDistance = 0;
    configure(typeArray);
    sDebug = 0;
  } // Constructor(int)

  /**
   * Constructor from pairs of Strings.
   * Initializes the data structures of <em>this</em> TilingSequence.
   * @param offset index of first sequence element
   * @param pairs String array of (vertexId, taRotList)
   */
  public TilingSequence(final int offset, String[] pairs) {
    mOffset = offset;
    final int vertexTypeNo = pairs.length;
    VertexTypeArray typeArray = new VertexTypeArray(vertexTypeNo);
    for (int ipair = 0; ipair < vertexTypeNo; ipair ++) {
      typeArray.setAngleNotation(pairs[ipair]);
    } // for ipair
    mDistance = 0;
    configure(typeArray);
  } // Constructor(int)

  /**
   * Configures the data structures of <em>this</em> TilingSequence.
   * @param typeArray array of {@link VertexTypes} for this TilingSequence
   */
  protected void configure(final VertexTypeArray typeArray) {
    mTypeArray = typeArray;
    mTypeArray.complete();
    initialize(0);
  } // initialize(VertexTypeArray)

  /**
   * Initializes the tiling's dynamic data structures only.
   * @param baseIndex {@link Vertex} for the start of the coordination sequence.
   * This index starts at 0! 
   */
  protected void initialize(final int baseIndex) {
    mBaseIndex  = baseIndex;
    mPosMap     = new PositionMap();
    mVertexList = new VertexList();
    mQueue      = new LinkedList<Integer>();
    mQueue.add(addVertex(new Vertex(mTypeArray.get(baseIndex))));
    mShellCount = 1;
    if (sDebug >= 1) {
        System.out.println(toJSON());
    }
  } // initialize(int)

  /**
   * Gets a {@link VertexType}
   * @param index of the VertexType, 0=A, 1=B and so on.
   * @return a number &gt;= 0, 
   */
  public VertexType getVertexType(final int index) {
    return mTypeArray.get(index);
  } // getVertexType

  /**
   * Adds an existing {@link Vertex} to the array of known vertices, and to the HashMap for {@link Position}s of vertices
   * @param vertex existing Vertex
   * @return index of added Vertex in {@link #mVertices}
   */
  public int addVertex(final Vertex vertex) {
    vertex.index = mVertexList.size();
    mVertexList.put(vertex);
    mPosMap    .put(vertex);
    return vertex.index;
  } // addVertex

  /**
   * Returns a JSON representation of the tiling
   * @return JSON for all major data structures
   */
  public String toJSON() {
    return mTypeArray .toJSON()
        +  mVertexList.toJSON()
        +  mPosMap    .toJSON()
        +  "\n, mBaseIndex: " + mBaseIndex;
  } // toJSON

  /**
   * Creates a successor {@link Vertex} of the focus and connects the successor back to the focus
   * @param focus the Vertex which gets the new successor
   * @param iedge attach the successor at this edge of the focus
   * @param distance from the origin Vertex
   * @return index of new successor vertex, or -1 if attached to an existing vertex
   */
  public int attach(final Vertex focus, final int iedge, final int distance) {
    int result = -1; // future result; assume that the successor already exists
    if (focus.proxies[iedge] == null) { // proxy for this edge not yet determined
      final Position proxyPos = focus.getProxyPosition(iedge);
      Vertex proxy = mPosMap.get(proxyPos);
      if (proxy != null) { // found, old 
        result = -1; // do not enqueue it
      } else { // not found - create new 
        proxy = focus.createProxy(iedge, proxyPos);
        result = addVertex(proxy); // enqueue new
      } // not found
      focus.proxies[iedge] = proxy; // attach it
      if (SVGFile.sEnabled) {
        SVGFile.writeEdge(focus, proxy, distance, 0); // normal
      }
      focus.fixedEdges ++;
    // else focus.proxies[iedge] != null - ignore
    }
    return result;
  } // attach

  /**
   * Gets the next term of the sequence.
   * Creates and connects all vertices of the next shell, and returns their count.
   */
  // @Override
  public Z next() {
    Z result = Z.valueOf(mShellCount); // return previous shell count
    mShellCount = 0; // start to count vertices in next shell
    int mustProcess = mQueue.size();
    while (mustProcess > 0 && mQueue.size() > 0) { // mQueue not empty
      final int ifocus = mQueue.poll(); // index of next vertex to be processed
      mustProcess --;
      final Vertex focus = mVertexList.get(ifocus);
      focus.distance = mDistance;
      for (int iedge = 0; iedge < focus.vtype.edgeNo; iedge ++) {
        int iproxy = attach(focus, iedge, mDistance);
        if (iproxy >= 0) { // did not yet exist
          mShellCount ++;
          mQueue.add(iproxy);
        // else successor existed - ignore
        }
      } // for iedge
    } // while portion not exhausted and mQueue not empty
    mDistance ++;
    return result;
  } // next()
  
  /**
   * Main method, filters a file, selects a {@link VertexTypeArray] for a tiling,
   * dumps the progress of the tilings' generation and
   * possibly writes an SVG drawing file.
   * @param args command line arguments
   */
  public static void main(String[] args) {
    final long startTime  = System.currentTimeMillis();
    int mMaxDistance = 16;
    try {
      int iarg = 0;
      while (iarg < args.length) { // consume all arguments
        String opt       = args[iarg ++];
        if (false) {
        } else if (opt.equals("-d")     ) {
          TilingSequence.sDebug = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals("-n")     ) {
          mMaxDistance   = Integer.parseInt(args[iarg ++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } // while args
      
    } catch (Exception exc) {
      // log.error(exc.getMessage(), exc);
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    }

    final TilingSequence mTiling = new TilingSequence(0, new String[] // Gal.2.1.1:
        { "12.6.4;A180-,A120-,B90+"
        , "6.4.3.4;A270+,A210-,B120+,B240+"
        });
    mTiling.initialize(0);
    for (int index = 0; index < mMaxDistance; index ++) {
      System.out.println(index + " " + mTiling.next());
    } // for index
    System.err.println("# elapsed: " + String.valueOf(System.currentTimeMillis() - startTime) + " ms");
  } // main

} // class TilingSequence

