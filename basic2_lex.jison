/* description: Basic grammar that contains a nullable A nonterminal. */

%lex

%{

tabla = new Array();
	
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

\s+                   { /* skip whitespace */ }
[a-zA-Z_]\w*          { return "ID"; }
[0-9]+("."[0-9]+)?\b  { return "NUM"; }
[;=]		      { return yytext; }

/lex

/* operator associations a precedence */
%left ';'

%%

s   : e { return hashToUl(tabla); }
    ;

e   : /* empty */
    | e ';' e
    | 'ID' '=' 'NUM' { tabla[$1] = $3; }
    ;





