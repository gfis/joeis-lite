package irvine.oeis.a229;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A229043 Series reversion of (sqrt(1+4*x) - 1)/2 - x^3.
 * @author Georg Fischer
 */
public class A229043 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A229043() {
    super(1, "[[0],[-12506061497630400,7570334884014000,-1830912242720400,221142803767200,-13338743947200,321415516800],[1900407605393966400,-1359591719864146560,387571573680414804,-55034776365594498,3893185221701616,-109768409767242],[4812339783431061000,-3719876163234103440,1149638175442284228,-177562986092662977,13705043221356228,-422866927175607],[4230582546003035544,-3602911916582588610,1226704928091678045,-208631138349412125,17716743065160351,-600713118760725],[1853652087410052240,-2104237822961616948,997120053983000034,-244460686914263754,30645659598667074,-1553366638804446],[838931771698392600,-1447099783538231322,963530585028332721,-311197429886900463,48971045467899999,-3014623168964415],[332511237415279440,-673221996613927260,512178448912918506,-186900194382436602,33079325420034594,-2286302051385918],[40930151256471960,-92395858776152778,79944030308212749,-33306435452969721,6703207226831619,-522324591955173],[-391744169879328,1003732051816368,-962123507256870,436807685777715,-94488658981542,7816598523657],[0,1822233279736464,-3796319332784300,2657423532949010,-759263866556860,75926386655686]]","1,1,1,5,12,35,122,390,1320", 0);
  }
}
