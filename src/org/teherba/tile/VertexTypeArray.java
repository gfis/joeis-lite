/* Store for vertex types
 * @(#) $Id$
 * Copyright (c) 2020 Dr. Georg Fischer
 * 2020-05-16, Georg Fischer: extracted from Tiling.java
 */
package org.teherba.tile;
import org.teherba.tile.VertexType;

/**
 * This class provides an array of fixed size
 * containing all {@link VertexType}s which is accessible by the index.
 * @author Georg Fischer
 */
public class VertexTypeArray {
  public final static String CVSID = "@(#) $Id: VertexTypeArray.java $";
  
  /** Allocated vertices */
  private VertexType[] mVertexTypes; // [0], [1] are reserved

  /** First free index */
  private int mTAFree;
  
  /** 
   * Empty Constructor - not used
   */
  public VertexTypeArray() {
    mVertexTypes = new VertexType[2];
    mTAFree = 0;
  } // Constructor()
  
  /** 
   * Constructor with number of {@link VertexType}s.
   * The VertexTypes should subsequently be filled with {@link #setAngleNotation}.
   * @param noTypes number of types to be stored
   */
  public VertexTypeArray(final int noTypes) {
    mVertexTypes = new VertexType[noTypes];
    for (int index = 0; index < noTypes; index ++) {
      mVertexTypes[index] = new VertexType(); // preset because of pxTinds
    } // for mTAFree
    mTAFree = 0; // incremented by setAngleNotation 
  } // Constructor(int)
  
  /**
   * Completes and adds an existing {@link VertexType} to the array
   * @param vtype the VertexType to be added
   * @return index of the resulting VertexType
   */
  public int add(final VertexType vtype) {
    vtype.index = mTAFree; // complete index and name
    vtype.name  = "ABCDEFGHIJKLMNOPQ".substring(vtype.index, vtype.index + 1);
    mVertexTypes[mTAFree ++] = vtype;
    return vtype.index; 
  } // add

  /**
   * Modify an existing {@link VertexType} and set the parameters of the angle notation
   * @param aSeqNo OEIS A-number of the sequence
   * @param galId Galebach's id "Gal.u.t.v"
   * @param vertexId clockwise dot-separated list of the polygones followed by the list of types and angles
   * @param taRotList clockwise comma-separated list of vertex type names and angles (and apostrophe if flipped)
   * @param sequence list of initial terms of the coordination sequence
   */
  public void setAngleNotation(final String aSeqNo, final String galId, final String vertexId
      , final String taRotList, final String sequence) {
    mVertexTypes[mTAFree].setAngleNotation(aSeqNo, galId, vertexId, taRotList, sequence);
    mVertexTypes[mTAFree].name = Character.toString((char) ('A' + mTAFree));
    mTAFree ++;
  } // setAngleNotation(String^5)

  /**
   * Modify an existing {@link VertexType} and set the parameters of the angle notation
   * @param param a pair of Strings "vertexId;taRotList",
   * where vertexId is a clockwise dot-separated list of the polygones followed by the list of types and angles,
   * and  taRotList is a clockwise comma-separated list of vertex type names and angles (and apostrophe if flipped)
   * aSeqno, galId and sequence are set to dummy values.
   */
  public void setAngleNotation(final String param) {
    final String[] pair = param.split(";");
    setAngleNotation("A000000", "Gal.u.t.v.", pair[0], pair[1], "1");
  } // setAngleNotation(String^2)

  /**
   * Completes all {@link VertexType}s, that is fills the pxTypes from pxTinds
   */
  public void complete() {
    for (int index = 0; index < mTAFree; index ++) {
      final VertexType vtype = get(index);
      vtype.pxTypes = new VertexType[vtype.edgeNo];
      for (int iedge = 0; iedge < vtype.edgeNo; iedge ++) {
        vtype.pxTypes[iedge] = get(vtype.pxTinds[iedge]);
        // fill ptEdges ???
      } // for iedge
    } // for index
  } // complete

  /**
   * Gets a {@link VertexType} specified by its index.
   * @param index sequential number 
   * @return the VertexType with that index
   */
  public VertexType get(final int index) {
    return mVertexTypes[index];
  } // get

  /**
   * Number of stored {@link VertexType}s
   * @return length of the array
   */
  public int size() {
    return mTAFree;
  } // size

  /**
   * Returns a JSON representation of <em>this</em> VertexTypeArray
   * @return JSON for all vertices in linear order
   */
  public String toJSON() {
    String result  = "{ \"mTAFree\": " + mTAFree + "\n" + ", \"mVertexTypes\":\n";
    for (int ind = 0; ind < size(); ind ++) { 
      result += (ind == 0 ? "  [ " : "  , ") + get(ind).toJSON();
    } // for types
    result += "  ]\n}\n";
    return result;
  } // toJSON

} // class VertexTypeArray
