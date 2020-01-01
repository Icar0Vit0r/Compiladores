%{
	#include "ANASIN.tab.h"
	#include <stdlib.h>
	#include <String.h>
	extern int yylval;
	FILE *TabelaDeSimbolos;
	int posicao;
	int controle;
	char lexema[100];
%}

Digito			            [0-9]
Letra			            [a-zA-Z]
Excecao                     [^\\]
Menor                       \<
Maior                       \>
MenorIgual                  \<\=
MaiorIgual                  \>\= 
Diferente                   \!\= 
IgualIgual                  \=\= 
const_booleana              true|false
Id				            {Letra}({Letra}|{Digito})*
Num				            {Digito}+(\.{Digito}+)?
Const_Caracter 	            '{Excecao}'|'\\n'|'\\t'|'\\0'|'\\r'|''
pontoevirgula 	            \;
ponto 			            \.
abrechave 		            \{
fechachave 		            \}
abrepar 		            \(
fechapar 		            \)
virgula 		            \,
doispontos 		            \:
op_atr 			            \=
operador_arg 	            (arg\[\]|args\[\])
Soma 			            \+
Menos 			            \-             
And                         \&\&
Mult                        \*
Div                         \/
Mod                         \% 
operador_aditivo_logic		\|\|
operador_aditivo_arit       [{soma}{menos}] 
operador_multiplicativo     [{Mult}{Div}{Mod}{And}]
op_rel                      [{Menor}{Maior}{MenorIgual}{MaiorIgual}{Diferente}{IgualIgual}]

 
%%

boolean			                  {return BOOLEAN;}          	
break			                  {return BREAK;}
char        	                  {return CHAR;}
class       	                  {return CLASS;}
continue    	                  {return CONTINUE;}
else        	                  {return ELSE;}
float       	                  {return FLOAT;}
if          	                  {return IF;}
public      	                  {return PUBLIC;}
return      	                  {return RETURN;}
static      	                  {return STATIC;}
String      	                  {return STRING;}
switch			                  {return SWITCH;}
void        	                  {return VOID;}
main                              {return MAIN;}
while       	                  {return WHILE;}  
int                               {return INT;}   
{Const_Caracter}                  {return CONST_CARACTER;}
{const_booleana}                  {return CONST_BOOLEANA;}
{Id}        	                  {yylval = instalar_id(); return ID;}
{pontoevirgula}                   {return PONTOEVIRGULA;}
{ponto}             		      {return PONTO;} 
{abrechave}                       {return ABRECHAVE;} 
{fechachave}                      {return FECHACHAVE;} 
{abrepar}                         {return ABREPAR;}
{fechapar}                        {return FECHAPAR;}  
{virgula}                         {return VIRGULA;}  
{doispontos}                      {return DOISPONTOS;}
{Num}                             {yylval = atoi(yytext); return NUM;}		            
{op_atr}                          {return OP_ATR;}
{operador_arg}                    {return OPERADOR_ARG;}
{operador_aditivo_logic}          {return OPERADOR_ADITIVO_LOGIC;}
{Menor}                           {yylval = MENOR; return OP_REL;}
{Maior}                           {yylval = MAIOR; return OP_REL;}
{MaiorIgual}                      {yylval = MAIORIGUAL; return OP_REL;}
{MenorIgual}                      {yylval = MENORIGUAL; return OP_REL;}
{IgualIgual}                      {yylval = IGUALIGUAL; return OP_REL;}
{Diferente}                       {yylval = DIFERENTE; return OP_REL;}
{Mult}                            {yylval = MULT; return OP_MULTIPLICATIVO;}
{Div}                             {yylval = DIV; return OP_MULTIPLICATIVO;}
{Mod}                             {yylval = MOD; return OP_MULTIPLICATIVO;}
{And}                             {yylval = AND; return OP_MULTIPLICATIVO;}  
{Soma}                            {yylval = SOMA; return OP_ARIT;}
{Menos}                           {yylval = MENOS; return OP_ARIT;}   

%%

int instalar_id(){

    if(TabelaDeSimbolos == NULL){
    	TabelaDeSimbolos = fopen("TabelaDeSimbolos.txt","w");
    	fprintf(TabelaDeSimbolos,"%s\n",yytext);
        posicao = 1;
    	fclose(TabelaDeSimbolos);
    }else{
    	posicao = 0;
    	controle = 0;
        TabelaDeSimbolos = fopen("TabelaDeSimbolos.txt","r");

    	while(!(feof(TabelaDeSimbolos))){
    		posicao++;
      		fscanf(TabelaDeSimbolos,"%s\n",lexema);
      		if(strcmp(yytext,lexema) == 0){
      			controle = 1;	 
      		}
    	}
       
    	fclose(TabelaDeSimbolos);

    	if(controle == 0){
    		TabelaDeSimbolos = fopen("TabelaDeSimbolos.txt","a");
    		fprintf(TabelaDeSimbolos,"%s\n",yytext);
    	}

    	fclose(TabelaDeSimbolos);
    }
    
    return posicao;
}

  


