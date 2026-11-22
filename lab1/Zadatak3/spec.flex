// import sekcija

%%

// sekcija opcija i deklaracija
%class MPLexer
%function next_token
%line
%column
%debug
%type Yytoken

%eofval{
if (yystate() == KOMENTAR)
	System.out.println( "ERROR: nezavrsen komentar" );
return new Yytoken( sym.EOF, null, yyline, yycolumn );
%eofval}

%{
//dodatni clanovi generisane klase
KWTable kwTable = new KWTable();
// Funkcija za prepoznavanje KW ili ID
Yytoken getKW()
{
	return new Yytoken( kwTable.find( yytext() ),
	yytext(), yyline, yycolumn );
}
%}

//stanja
%xstate KOMENTAR

//makroi
slovo = [a-zA-Z]
cifra = [0-9]
donjacrta = [_]

//ID ne krece cifrom
ID = ({slovo}|{donjacrta})({slovo}|{cifra}|{donjacrta})*

//konstante
INT10 = 0|[1-9]{cifra}*
INT8 = 0[0-7]+
INT16 = 0[xX][0-9a-fA-F]+
CHAR = ("'"|\u2018) [^\n\r'\u2018\u2019] ("'"|\u2019)
STRING = "''" ( [^'\n\r] | "'" [^'\n\r] )* "''"

%%

// pravila
// komentari (* ... *)
"(*" { yybegin( KOMENTAR ); }
<KOMENTAR>"*)" { yybegin( YYINITIAL ); }
<KOMENTAR>[^] { ; }

// whitespace
[\t\n\r\f ] { ; }

// konstante
{INT16}|{INT8}|{INT10}|{CHAR}|{STRING} { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }

// kljucne reci i identifikatori
{ID} { return getKW(); }

// operatori i separatori
\+ { return new Yytoken( sym.PLUS, yytext(), yyline, yycolumn ); }
\- | \u2013 { return new Yytoken( sym.MINUS, yytext(), yyline, yycolumn ); }
\( { return new Yytoken( sym.LPAREN, yytext(), yyline, yycolumn ); }
\) { return new Yytoken( sym.RPAREN, yytext(), yyline, yycolumn ); }
; { return new Yytoken( sym.SEMICOLON, yytext(), yyline, yycolumn ); }
: { return new Yytoken( sym.COLON, yytext(), yyline, yycolumn ); }
= { return new Yytoken( sym.ASSIGN, yytext(), yyline, yycolumn ); }

// obrada gresaka
. { System.out.println( "ERROR: " + yytext() + " line: " + (yyline+1) + " column: " + (yycolumn+1) ); }
