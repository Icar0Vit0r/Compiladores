%{
	#include <stdio.h>
	int yylex();
	void yyerror(const char *s);
%}

%token BOOLEAN BREAK CHAR CLASS CONTINUE ELSE FLOAT 
       IF PUBLIC RETURN STATIC STRING SWITCH VOID
       WHILE INT ID PONTOEVIRGULA PONTO ABRECHAVE 
       FECHACHAVE ABREPAR FECHAPAR VIRGULA DOISPONTOS
       NUM CONST_CARACTER CONST_BOOLEANA OP_ATR
       OPERADOR_ARG OPERADOR_ADITIVO_LOGIC MENOR
       OP_REL MAIOR MAIORIGUAL MENORIGUAL IGUALIGUAL
       DIFERENTE OP_MULTIPLICATIVO MULT DIV MOD
       OP_ARIT SOMA MENOS MAIN AND

%%

  classDeclaration: PUBLIC CLASS ID classBody {printf("Analise sintatica correta!");}; 

  classBody: ABRECHAVE classBodyDeclaration FECHACHAVE;

  classBodyDeclaration: declarationList methodDeclaration;

  declarationList: declarationList declaration PONTOEVIRGULA
	             | declaration PONTOEVIRGULA 
	             | ;

  declaration: type identifierList;
	
  type: BOOLEAN | CHAR | FLOAT | INT | STRING | VOID;
	
  identifierList: identifierList VIRGULA ID | ID;

  methodDeclaration: methodDeclaration methodName | methodName;

  methodName: PUBLIC type ID ABREPAR formalParameteres FECHAPAR ABRECHAVE methodbody FECHACHAVE 
            | PUBLIC STATIC type ID ABREPAR formalParameteres FECHAPAR ABRECHAVE methodbody FECHACHAVE
            | PUBLIC STATIC VOID MAIN ABREPAR STRING OPERADOR_ARG FECHAPAR ABRECHAVE methodbody FECHACHAVE;

  methodbody: declarationList statementList;

  formalParameteres: formalParameteres VIRGULA formalParameter | formalParameter | ;

  formalParameter: type ID;

  statementList: statementList statement | statement | ;

  statement: ifStatement 
    	   | whileStatement 
    	   | RETURN expression PONTOEVIRGULA
    	   | BREAK PONTOEVIRGULA
    	   | ID OP_ATR expression PONTOEVIRGULA
    	   | ID ABREPAR expressionList FECHAPAR PONTOEVIRGULA;

  literal: ID | NUM | CONST_CARACTER | CONST_BOOLEANA;

  expression: expression OP_ARIT expression 
            | expression OP_MULTIPLICATIVO expression
            | expression OPERADOR_ADITIVO_LOGIC expression
            | expression OP_REL expression
            | literal
            | ABREPAR expression FECHAPAR
            | OP_ARIT expression;
      

  expressionList: expressionList VIRGULA expression
                | expression
                | ;

  ifStatement: IF ABREPAR expression FECHAPAR statementBlock elseAlternative ;

  elseAlternative: ELSE statementBlock | ;

  whileStatement: WHILE ABREPAR expression FECHAPAR statementBlock;

  statementBlock: statement | ABRECHAVE statementList FECHACHAVE;

%%

#include "lex.yy.c"

int main(int argc, char *argv[]){
            ++argv, --argc;

  if (argc > 0)
    yyin = fopen(argv[0],"r");
  else
    yyin = stdin;

  FILE *TabelaDeSimbolos;

  TabelaDeSimbolos = fopen("TabelaDeSimbolos.txt","r");
  yyparse();
 
  return(0);

}

void yyerror(const char *s){ 
	printf("\nERROR\n"); 
}

int yywrap(){ 
	return 1; 
}