// import section
import java_cup.runtime.*;

%%
// declaration section
%class ProjectLexer

%cup

%line
%column

%eofval{
	return new Symbol( sym.EOF );
%eofval}


//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]
punktuacija  = [\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\]\\\^\_\`\{\}\~]
decimalni = 0 | [1-9][0-9]*
heksa = [0-9a-fA-F]+
ID = ({slovo}|[\_])({slovo}|{cifra}|[\_])*
broj = ({decimalni}+|\${heksa}+)
realni = {cifra}+\.({cifra}+)?(E[\+-]?{cifra}+)?
znak = '{slovo}' | '{cifra}' | '{punktuacija}'
bool = true | false
CONST = {broj} | {realni} | {znak} | {bool}

%%
// rules section
\(\*			{ yybegin( COMMENT ); }
<COMMENT>\*\)	{ yybegin( YYINITIAL ); }
<COMMENT>.		{ ; }

[\t\r\n ]		{ ; }

//operators
"+"				{ return new Symbol( sym.PLUS ); }
"*"			{ return new Symbol( sym.MUL );  }
"-"             { return new Symbol( sym.SUB );  }
"/"          { return new Symbol( sym.DIV );  }
"<"			{ return new Symbol( sym.LESS );  }
">"			{ return new Symbol( sym.GREATER );  }
"<="				{ return new Symbol( sym.LESSOREQUAL );  }
">="			{ return new Symbol( sym.GREATEROREQUAL );  }
"=="			{ return new Symbol( sym.EQUAL );  }
"!="			{ return new Symbol( sym.DIFFERENT );  }
"&&"			{ return new Symbol( sym.AND );  }
"||"		    { return new Symbol( sym.OR );  }

//separators
";"			{ return new Symbol( sym.SEMI );	}
","				{ return new Symbol( sym.COMMA );	}
":"			{ return new Symbol( sym.DOTDOT ); }
"="				{ return new Symbol( sym.ASSIGN ); }
"("			{ return new Symbol( sym.LEFTPAR ); }
")"			{ return new Symbol( sym.RIGHTPAR ); }
"{"		    { return new Symbol( sym.LEFTBRACE );  }
"}"            { return new Symbol( sym.RIGHTBRACE ); }

//keywords
"main"		    { return new Symbol( sym.MAIN );	}	
"real"			{ return new Symbol( sym.REAL );	}
"int"		    { return new Symbol( sym.INTEGER );	}
"char"			{ return new Symbol( sym.CHAR );	}
"bool"			{ return new Symbol( sym.BOOL );	}
"read"			{ return new Symbol( sym.READ );	}
"write"			{ return new Symbol( sym.WRITE );	}
"repeat"	    { return new Symbol( sym.REPEAT );	}
"until"			{ return new Symbol( sym.UNTIL );	}

//id-s
{ID}            { return new Symbol( sym.ID ); }

//constants
{CONST}         { return new Symbol( sym.CONST ); }


//error symbol
.		{ System.out.println( "ERROR: " + yytext() ); }

