/* Node in a tiling
 * @(#) $Id$
 * Copyright (c) 2020 Dr. Georg Fischer
 * 2020-05-15, Georg Fischer: extracted from Tiler.java
 */
package org.teherba.tile;
import org.teherba.tile.Position;
import org.teherba.tile.SVGFile;
import org.teherba.tile.VertexType;
import java.io.Serializable;
import java.util.Arrays;

/**
 * This class represents a vertex in a tiling.
 * A vertex is a node where 3 to 6 (for uniform tilings) edges meet.
 * @author Georg Fischer
 */
public class Vertex implements Serializable {
  public final static String CVSID = "@(#) $Id: Vertex.java $";

  /** Debugging mode: 0=none, 1=some, 2=more */
  public static int sDebug;

  public int index;        // in mVertices
  public VertexType vtype; // general properties for the vertex
  public int orient;       // 1 for normal (clockwise), -1 for opposite (counter-clockwise) orientation
  public int distance;     // length of shortest path to origin, for coloring
  public int rotate;       // the vertex type was rotated clockwise by so many degrees
  public Position expos;   // exact Position of the Vertex
  public int fixedEdges;   // number of allocated neighbours = edges
  public Vertex[] proxies; // array of neighbouring vertices at the end of the edges

  /**
   * Empty constructor, not used
   */
  public Vertex() {
    index = -1;
  } // Vertex()

  /**
   * Constructor with a {@link VertexType}.
   * @param vtype type of vertex with general properties,
   * is even for clockwise, odd for clockwise orientation
   */
  public Vertex(final VertexType vtype) {
    this.vtype = vtype;
    orient     = 1; // assume normal orientation
    distance   = 0;
    rotate     = 0;
    expos      = new Position();
    proxies    = new Vertex[vtype.edgeNo];
   } // Vertex(VertexType)

  /**
   * Constructor with a {@link VertexType} and an orientation.
   * @param vtype type of vertex with general properties
   * @param orient 1 for normal (clockwise), -1 for opposite (counter-clockwise) orientation
   */
  public Vertex(final VertexType vtype, final int orient) {
    this(vtype);
    this.orient = orient;
  } // Vertex(VertexType,int)

  /**
   * Gets the type of <em>this</em> Vertex
   * @return a {@link VertexType}
   */
  public VertexType getType() {
    return vtype;
  } // getType

  /**
   * Gets the name (via the {@link #VertexType}) of <em>this</em> Vertex
   * @return uppercase letter (for non-flipped) or lowercase letter (for flipped)
   */
  public String getName() {
    return orient == 1
        ? vtype.name
        : vtype.name.toLowerCase();
  } // getName

  /**
   * Returns a representation of the proxies
   * @return JSON array with indices of the proxies
   */
  private String getProxyList() {
    StringBuffer result = new StringBuffer(128);
    for (int iedge = 0; iedge < vtype.edgeNo; iedge ++) {
      result.append(',');
      result.append(String.valueOf(proxies[iedge] == null ? -1 : proxies[iedge].index));
    } // for iedge
    return result.substring(1);
  } // getProxyList

  /**
   * Returns a JSON representation of the Vertex
   * @return JSON for all properties
   */
  public String toJSON() {
    final String result
        = "{ \"i\": "          + String.format("%4d", index)
        + ", \"type\": "       + String.format("%2d", vtype.index)
        + ", \"name\": "       + getName()
        + ", \"orient\": "     + String.format("%3d", orient)
        + ", \"rot\": "        + String.format("%3d", rotate)
        + ", \"fix\": "        + fixedEdges
        + ", \"proxies\": ["   + getProxyList() + "]"
        + ", \"pos\": \""      + expos.toString()  + "\""
        + ", \"dist\": \""     + distance + "\""
        + " }\n";
    return result;
  } // Vertex.toJSON

  /**
   * Returns a representation of the Vertex
   * @return JSON for edges
   */
  public String toString() {
    return index + getName() + " @" + rotate + expos + "->" + getProxyList();
  } // Vertex.toString

 /**
   * Normalizes an angle
   * @param angle in degrees, maybe negative or >= 360
   * @return non-negative degrees mod 360
   */
  protected static int normAngle(int angle) {
    while (angle < 0) {
      angle += 360;
    }
    return angle % 360;
  } // normAngle

  /**
   * Gets the absolute angle where an edge of <em>this</em> {@link Vertex}
   * (which is already rotated) is pointing to.
   * This is the only place where the orientation of the Vertex is relevant.
   * The orientation is implemented by a proper access to <em>sweeps</em>.
   * This method corresponds with {@link #getEdge}.
   * @param iedge number of the edge
   * @return degrees [0..360) where the edge points to,
   * relative to a right horizontal edge from (x,y)=(0,0) to (x,y)=(0,1),
   * turning clockwise := positive (downwards, because of SVG's y axis)
   */
  protected int getAngle(final int iedge) {
    final int result = normAngle(rotate + orient * vtype.pxSweeps[iedge]);
    if (sDebug >= 2) {
        System.out.println("#         getAngle(iedge "         + iedge + ")." + index + getName() + "@" + rotate + expos
            + ", focus.orient " + orient + ", => " + result);
    }
    return result;
  } // getAngle

  /**
   * Determines the {@link Position} of a proxy {@link Vertex} at the end of the specified edge
   * @param iedge=0..edgeNo -1; the successor is at the end of this edge
   * @return exact Position which is then checked whether it is occupied
   */
  public Position getProxyPosition(final int iedge) {
    final Position result = expos.moveUnit(getAngle(iedge));
    if (sDebug >= 2) {
        System.out.println("#         getProxyPosition(iedge " + iedge + ")." + index + getName() + "@" + rotate + expos
            + ", focus.orient " + orient + " => " + result.toString());
    }
    return result;
  } // getProxyPosition

  /**
   * Creates and returns a new successor {@link #Vertex} of <em>this</em> Vertex (which is already rotated).
   * @param iedge=0..edgeNo -1; the successor is at the end of this edge
   * @return successor Vertex which is properly rotated and linked back to <em>this</em>
   */
  public Vertex createProxy(final int iedge, final Position proxyPos) {
    final Vertex proxy = new Vertex(vtype.pxTypes[iedge], orient * vtype.pxOrients[iedge]); // create a new Vertex
    final int pxAngle  = this.getAngle(iedge); // points to the proxy
    proxy.expos  = expos.moveUnit(pxAngle);
    final int pxRota   = orient * vtype.pxRotats[iedge];
    proxy.rotate = normAngle(rotate + pxRota);
    if (sDebug >= 2) {
      System.out.println("#     createProxy(iedge " + iedge + "proxyPos " + proxyPos.toString()
          + ")." + index + getName() + "@" + rotate + expos
          + " -> pxType " + proxy.vtype.index + ", pxRota " + pxRota + ", pxAngle " + pxAngle
          + " => " + proxy.toString());
    }
    return proxy;
  } // createProxy

} // class Vertex
