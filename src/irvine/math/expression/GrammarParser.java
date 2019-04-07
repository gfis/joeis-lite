// Generated from src/irvine/math/expression/Grammar.g4 by ANTLR 4.5
package irvine.math.expression;

import irvine.math.z.Z;

/**
 * Parser.
 * @author Sean A. Irvine
 */

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class GrammarParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		INTEGER=25, WS=26, IDENTIFIER=27;
	public static final int
		RULE_expr = 0;
	public static final String[] ruleNames = {
		"expr"
	};

	private static final String[] _LITERAL_NAMES = {
		null, "'log'", "'('", "')'", "'diff'", "','", "'exp'", "'cosh'", "'sinh'", 
		"'tanh'", "'lucas'", "'fibonacci'", "'subs'", "'='", "'sum'", "'..'", 
		"'!'", "'##'", "'#'", "'^'", "'+'", "'-'", "'*'", "'/'", "'%'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, "INTEGER", "WS", "IDENTIFIER"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Grammar.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public GrammarParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class ExprContext extends ParserRuleContext {
		public Expression v;
		public ExprContext a;
		public ExprContext expr;
		public Token IDENTIFIER;
		public ExprContext b;
		public ExprContext c;
		public Token INTEGER;
		public Token op;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode IDENTIFIER() { return getToken(GrammarParser.IDENTIFIER, 0); }
		public TerminalNode INTEGER() { return getToken(GrammarParser.INTEGER, 0); }
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
	}

	public final ExprContext expr() throws RecognitionException {
		return expr(0);
	}

	private ExprContext expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExprContext _localctx = new ExprContext(_ctx, _parentState);
		ExprContext _prevctx = _localctx;
		int _startState = 0;
		enterRecursionRule(_localctx, 0, RULE_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(92);
			switch (_input.LA(1)) {
			case T__19:
				{
				setState(3);
				match(T__19);
				setState(4);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(7);

				      _localctx.v = ((ExprContext)_localctx).a.v;
				    
				}
				break;
			case T__20:
				{
				setState(7);
				match(T__20);
				setState(8);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(6);

				      _localctx.v = new Negate(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__0:
				{
				setState(11);
				match(T__0);
				setState(12);
				match(T__1);
				setState(13);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(14);
				match(T__2);

				      _localctx.v = new Logarithm(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__3:
				{
				setState(17);
				match(T__3);
				setState(18);
				match(T__1);
				setState(19);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(20);
				match(T__4);
				setState(21);
				((ExprContext)_localctx).IDENTIFIER = match(IDENTIFIER);
				setState(22);
				match(T__2);

				      _localctx.v = new Derivative(((ExprContext)_localctx).a.v, new Identifier((((ExprContext)_localctx).IDENTIFIER!=null?((ExprContext)_localctx).IDENTIFIER.getText():null)));
				    
				}
				break;
			case T__5:
				{
				setState(25);
				match(T__5);
				setState(26);
				match(T__1);
				setState(27);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(28);
				match(T__2);

				      _localctx.v = new Exponential(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__6:
				{
				setState(31);
				match(T__6);
				setState(32);
				match(T__1);
				setState(33);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(34);
				match(T__2);

				      _localctx.v = new HyperbolicCosine(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__7:
				{
				setState(37);
				match(T__7);
				setState(38);
				match(T__1);
				setState(39);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(40);
				match(T__2);

				      _localctx.v = new HyperbolicSine(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__8:
				{
				setState(43);
				match(T__8);
				setState(44);
				match(T__1);
				setState(45);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(46);
				match(T__2);

				      _localctx.v = new HyperbolicTangent(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__9:
				{
				setState(49);
				match(T__9);
				setState(50);
				match(T__1);
				setState(51);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(52);
				match(T__2);

				      _localctx.v = new Lucas(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__10:
				{
				setState(55);
				match(T__10);
				setState(56);
				match(T__1);
				setState(57);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(58);
				match(T__2);

				      _localctx.v = new Fibonacci(((ExprContext)_localctx).a.v);
				    
				}
				break;
			case T__11:
				{
				setState(61);
				match(T__11);
				setState(62);
				match(T__1);
				setState(63);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(64);
				match(T__4);
				setState(65);
				((ExprContext)_localctx).IDENTIFIER = match(IDENTIFIER);
				setState(66);
				match(T__12);
				setState(67);
				((ExprContext)_localctx).b = ((ExprContext)_localctx).expr = expr(0);
				setState(68);
				match(T__2);

				      _localctx.v = new Substitution(((ExprContext)_localctx).a.v, new Identifier((((ExprContext)_localctx).IDENTIFIER!=null?((ExprContext)_localctx).IDENTIFIER.getText():null)), ((ExprContext)_localctx).b.v);
				    
				}
				break;
			case T__13:
				{
				setState(71);
				match(T__13);
				setState(72);
				match(T__1);
				setState(73);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(74);
				match(T__4);
				setState(75);
				((ExprContext)_localctx).IDENTIFIER = match(IDENTIFIER);
				setState(76);
				match(T__12);
				setState(77);
				((ExprContext)_localctx).b = ((ExprContext)_localctx).expr = expr(0);
				setState(78);
				match(T__14);
				setState(79);
				((ExprContext)_localctx).c = ((ExprContext)_localctx).expr = expr(0);
				setState(80);
				match(T__2);

				      _localctx.v = new Sum(((ExprContext)_localctx).a.v, new Identifier((((ExprContext)_localctx).IDENTIFIER!=null?((ExprContext)_localctx).IDENTIFIER.getText():null)), ((ExprContext)_localctx).b.v, ((ExprContext)_localctx).c.v);
				    
				}
				break;
			case T__1:
				{
				setState(83);
				match(T__1);
				setState(84);
				((ExprContext)_localctx).a = ((ExprContext)_localctx).expr = expr(0);
				setState(85);
				match(T__2);

				      _localctx.v = ((ExprContext)_localctx).a.v;
				    
				}
				break;
			case INTEGER:
				{
				setState(88);
				((ExprContext)_localctx).INTEGER = match(INTEGER);

				      _localctx.v = new LiteralZ(new Z((((ExprContext)_localctx).INTEGER!=null?((ExprContext)_localctx).INTEGER.getText():null)));
				    
				}
				break;
			case IDENTIFIER:
				{
				setState(90);
				((ExprContext)_localctx).IDENTIFIER = match(IDENTIFIER);

				      _localctx.v = new Identifier((((ExprContext)_localctx).IDENTIFIER!=null?((ExprContext)_localctx).IDENTIFIER.getText():null));
				    
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(125);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,2,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(123);
					switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
					case 1:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(94);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(95);
						match(T__18);
						setState(96);
						((ExprContext)_localctx).b = ((ExprContext)_localctx).expr = expr(8);

						               _localctx.v = new Power(((ExprContext)_localctx).a.v, ((ExprContext)_localctx).b.v);
						              
						}
						break;
					case 2:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(99);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(100);
						((ExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__21) | (1L << T__22) | (1L << T__23))) != 0)) ) {
							((ExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						} else {
							consume();
						}
						setState(101);
						((ExprContext)_localctx).b = ((ExprContext)_localctx).expr = expr(6);

						                if ("*".equals((((ExprContext)_localctx).op!=null?((ExprContext)_localctx).op.getText():null))) {
						                  _localctx.v = Multiply.create(((ExprContext)_localctx).a.v, ((ExprContext)_localctx).b.v);
						                } else if ("/".equals((((ExprContext)_localctx).op!=null?((ExprContext)_localctx).op.getText():null))) {
						                  _localctx.v = Divide.create(((ExprContext)_localctx).a.v, ((ExprContext)_localctx).b.v);
						                } else {
						                _localctx.v = new Modulo(((ExprContext)_localctx).a.v, ((ExprContext)_localctx).b.v);
						                }
						              
						}
						break;
					case 3:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(104);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(105);
						match(T__20);
						setState(106);
						((ExprContext)_localctx).b = ((ExprContext)_localctx).expr = expr(5);

						                _localctx.v = Subtract.create(((ExprContext)_localctx).a.v, ((ExprContext)_localctx).b.v);
						              
						}
						break;
					case 4:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(109);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(110);
						match(T__19);
						setState(111);
						((ExprContext)_localctx).b = ((ExprContext)_localctx).expr = expr(4);

						                _localctx.v = Add.create(((ExprContext)_localctx).a.v, ((ExprContext)_localctx).b.v);
						              
						}
						break;
					case 5:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(114);
						if (!(precpred(_ctx, 11))) throw new FailedPredicateException(this, "precpred(_ctx, 11)");
						setState(115);
						match(T__15);

						                _localctx.v = new Factorial(((ExprContext)_localctx).a.v);
						              
						}
						break;
					case 6:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(117);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						setState(118);
						match(T__16);

						                _localctx.v = new Primorial(((ExprContext)_localctx).a.v, true);
						              
						}
						break;
					case 7:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(120);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(121);
						match(T__17);

						                _localctx.v = new Primorial(((ExprContext)_localctx).a.v);
						              
						}
						break;
					}
					} 
				}
				setState(127);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,2,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 0:
			return expr_sempred((ExprContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 8);
		case 1:
			return precpred(_ctx, 5);
		case 2:
			return precpred(_ctx, 4);
		case 3:
			return precpred(_ctx, 3);
		case 4:
			return precpred(_ctx, 11);
		case 5:
			return precpred(_ctx, 10);
		case 6:
			return precpred(_ctx, 9);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3\35\u0083\4\2\t\2"+
		"\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3"+
		"\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2"+
		"\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3"+
		"\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2"+
		"\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3"+
		"\2\3\2\3\2\5\2_\n\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3"+
		"\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\7\2"+
		"~\n\2\f\2\16\2\u0081\13\2\3\2\2\3\2\3\2\2\3\3\2\30\32\u0096\2^\3\2\2\2"+
		"\4\5\b\2\1\2\5\6\7\26\2\2\6\7\5\2\2\t\7\b\b\2\1\2\b_\3\2\2\2\t\n\7\27"+
		"\2\2\n\13\5\2\2\b\13\f\b\2\1\2\f_\3\2\2\2\r\16\7\3\2\2\16\17\7\4\2\2\17"+
		"\20\5\2\2\2\20\21\7\5\2\2\21\22\b\2\1\2\22_\3\2\2\2\23\24\7\6\2\2\24\25"+
		"\7\4\2\2\25\26\5\2\2\2\26\27\7\7\2\2\27\30\7\35\2\2\30\31\7\5\2\2\31\32"+
		"\b\2\1\2\32_\3\2\2\2\33\34\7\b\2\2\34\35\7\4\2\2\35\36\5\2\2\2\36\37\7"+
		"\5\2\2\37 \b\2\1\2 _\3\2\2\2!\"\7\t\2\2\"#\7\4\2\2#$\5\2\2\2$%\7\5\2\2"+
		"%&\b\2\1\2&_\3\2\2\2\'(\7\n\2\2()\7\4\2\2)*\5\2\2\2*+\7\5\2\2+,\b\2\1"+
		"\2,_\3\2\2\2-.\7\13\2\2./\7\4\2\2/\60\5\2\2\2\60\61\7\5\2\2\61\62\b\2"+
		"\1\2\62_\3\2\2\2\63\64\7\f\2\2\64\65\7\4\2\2\65\66\5\2\2\2\66\67\7\5\2"+
		"\2\678\b\2\1\28_\3\2\2\29:\7\r\2\2:;\7\4\2\2;<\5\2\2\2<=\7\5\2\2=>\b\2"+
		"\1\2>_\3\2\2\2?@\7\16\2\2@A\7\4\2\2AB\5\2\2\2BC\7\7\2\2CD\7\35\2\2DE\7"+
		"\17\2\2EF\5\2\2\2FG\7\5\2\2GH\b\2\1\2H_\3\2\2\2IJ\7\20\2\2JK\7\4\2\2K"+
		"L\5\2\2\2LM\7\7\2\2MN\7\35\2\2NO\7\17\2\2OP\5\2\2\2PQ\7\21\2\2QR\5\2\2"+
		"\2RS\7\5\2\2ST\b\2\1\2T_\3\2\2\2UV\7\4\2\2VW\5\2\2\2WX\7\5\2\2XY\b\2\1"+
		"\2Y_\3\2\2\2Z[\7\33\2\2[_\b\2\1\2\\]\7\35\2\2]_\b\2\1\2^\4\3\2\2\2^\t"+
		"\3\2\2\2^\r\3\2\2\2^\23\3\2\2\2^\33\3\2\2\2^!\3\2\2\2^\'\3\2\2\2^-\3\2"+
		"\2\2^\63\3\2\2\2^9\3\2\2\2^?\3\2\2\2^I\3\2\2\2^U\3\2\2\2^Z\3\2\2\2^\\"+
		"\3\2\2\2_\177\3\2\2\2`a\f\n\2\2ab\7\25\2\2bc\5\2\2\ncd\b\2\1\2d~\3\2\2"+
		"\2ef\f\7\2\2fg\t\2\2\2gh\5\2\2\bhi\b\2\1\2i~\3\2\2\2jk\f\6\2\2kl\7\27"+
		"\2\2lm\5\2\2\7mn\b\2\1\2n~\3\2\2\2op\f\5\2\2pq\7\26\2\2qr\5\2\2\6rs\b"+
		"\2\1\2s~\3\2\2\2tu\f\r\2\2uv\7\22\2\2v~\b\2\1\2wx\f\f\2\2xy\7\23\2\2y"+
		"~\b\2\1\2z{\f\13\2\2{|\7\24\2\2|~\b\2\1\2}`\3\2\2\2}e\3\2\2\2}j\3\2\2"+
		"\2}o\3\2\2\2}t\3\2\2\2}w\3\2\2\2}z\3\2\2\2~\u0081\3\2\2\2\177}\3\2\2\2"+
		"\177\u0080\3\2\2\2\u0080\3\3\2\2\2\u0081\177\3\2\2\2\5^}\177";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}