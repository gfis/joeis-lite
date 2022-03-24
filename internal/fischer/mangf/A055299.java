package irvine.oeis.a055;

import irvine.oeis.HolonomicRecurrence;

/**
 * A055299 Number of trees with n nodes and 12 leaves.
 * @author Georg Fischer
 */
public class A055299 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A055299() {
    super(13, A055278.computeRecurrence(12), "1,6,36,199,984,4433,18257,69390,245105,810418,2522646,7432876,20825678,55717629,142862730,352212459,837368658,1924861589,4288250970,9278750495,19537503288,40103712085,80377128541,157524824528,302284376907,568677350990,1050000255389,1904745358359,3398005254260,5966706572212,10321052970692,17600348029577,29609565898575,49174566419264,80669871375764,130795045421028,209705960300523,332648307188857,522296018479154,812071301762044,1250821274311423,1909356036307662,2889523232943186,4336716294595434,6457001393911546,9540419630206314,13992497233127822,20376604908940371,29470579834349045,42342000976753309,60447737939184849,85764935391161169,120962518971219703,169624701430413485,236540930237316543,328080374654535518,452673544665926776,621429142610984372,848920972673507117,1154187920355628845,1561999944585215706,2104455040713915693,2822986620278913219,3770878180783284488,5016403033714074006,6646731856062973018,8772780643083208087,11535207120903860703,15111805782583273806,19726601577254767014,25661001178949960959,33267430193054232104,42985966298061702094,55364574141662743202,71083660003631229370,90985795374729684452,116111611527210983561,147743045196101040463,187455322325251853869,237179306736988872419,299276118271368481547,376626245878750602582,472735751345493927204,591862585734289865270,739166530843741861701,920886840813505247052,1144552304022788791882,1419229183681608825918,1755813339036929518856,2167373791701042644919,2669556098282778326775,3281055138423141842431,4024168345165945506251,4925442013582372171172,6016425146784414842140,7334547362107110074259,8924139712705835475998,10837619913268822846255,13136866427784757516178,15894809221657456935292,19197268742401524200161,23145078920575708005803,27856534727163932184517,33470210143397508459878,40148198356593295622365,48079832661188828486678,57485953993307661216642,68623799344473899456783,81792594576354516215544,97339945495180932362653,115669132550689938211092,137247427321518303473238,162615563167121212116393,192398508210364082764812", 0);
  }
}
