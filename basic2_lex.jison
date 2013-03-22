/* description: Basic grammar that contains a nullable A nonterminal. */

%lex

%%

\s+							{ /* skip whitespace */ }
[a-zA-Z_]\w*				{ return "ID"; }
[0-9]+("."[0-9]+)?\b		{ yytext = Number(yytext); return "NUM"; }
[;=]						{ return yytext; }
.							{ return 'INVALID'; }

/lex /* */

%{

var tabla = {};
	
hashToUl = function(hash) {
	var result = "<ul>";

	for (key in hash) {
		result += "<li>" + key + " -> " + hash[key] + "</li>";
	}
	result += "</ul>";
	
	return result;
}	

%}

%%

P   : 	S	{
				return hashToUl(tabla);
		 	}
	;

S   : e 
    | S ';' e
	;

e   : { /* empty */ }
    | 'ID' '=' 'NUM' { tabla[$1] = $$ = $3; }
    | 'ID' '=' 'INVALID'	{
								throw new Error('Se esperaba un número en la línea ' + (yy.lexer.yylineno + 1) + ":\n" + yy.lexer.showPosition() + '\n');
							}
    ;
