@contributor{bgf2src automated exporter - SLPS}

module Clafer

start syntax Module
       =
       Declaration*
 ;
syntax Declaration
       = "enum" Ident "=" ListEnumId
       | Clafer
       | Constraint
 ;
syntax Clafer
       =
       "abstract"? GCard Ident Super Card Elements
 ;
syntax Constraint
       =
       "[" LExp* "]"
 ;

syntax Elements
       = 
       | "{" Element* "}"
 ;
syntax Element
       = Clafer
       | "\'" Name Card Elements
       | Constraint
 ;
syntax Super
       = 
       | ":" Name
       | "extends" Name
       | "-\>" ListModId SExp
 ;
syntax GCard
       = 
       | "xor"
       | "or"
       | "mux"
       | "opt"
       | "\<" GNCard "\>"
 ;
syntax Card
       =
       | "?"
       | "+"
       | "*"
       | NCard
 ;
syntax GNCard
       =
       Integer "-" ExInteger
 ;
syntax NCard
       =
       Integer ".." ExInteger
 ;
syntax ExInteger
       = "*"
       | Integer
 ;
syntax Name
       =
       ListModId Ident
 ;
syntax LExp
       = LExp "\<=\>" LExp1
       | LExp1
 ;
syntax LExp1
       = LExp1 "=\>" LExp2
       | LExp1 "=\>" LExp2 "else" LExp2
       | LExp2
 ;
syntax LExp2
       = LExp2 "||" LExp3
       | LExp3
 ;
syntax LExp3
       = LExp3 "xor" LExp4
       | LExp4
 ;
syntax LExp4
       = LExp4 "&&" LExp5
       | LExp5
 ;
syntax LExp5
       = "~" LExp6
       | LExp6
 ;
syntax LExp6
       = Term
       | "(" LExp ")"
 ;
syntax Term
       = CmpExp
       | SExp
       | Quant SExp
       | ListDecl "|" LExp
 ;
syntax CmpExp
       = Exp "\<" Exp
       | Exp "\>" Exp
       | Exp "=" Exp
       | Exp "==" Exp
       | Exp "\<=" Exp
       | Exp "\>=" Exp
       | Exp "!=" Exp
       | Exp "/=" Exp
       | Exp "in" Exp
       | Exp "not" "in" Exp
 ;
syntax Exp
       = AExp
       | {Exp ","}+
       | StrExp
 ;
syntax Quant
       = "no"
       | "lone"
       | "one"
       | "some"
 ;
syntax ExQuant
       = "all"
       | Quant
 ;
syntax SExp
       = SExp "++" SExp1
       | SExp1
 ;
syntax SExp1
       = SExp1 "&" SExp2
       | SExp2
 ;
syntax SExp2
       = SExp2 "\<:" SExp3
       | SExp3
 ;
syntax SExp3
       = SExp3 ":\>" SExp4
       | SExp4
 ;
syntax SExp4
       = SExp4 "." SExp5
       | SExp5
 ;
syntax SExp5
       = Ident
       | "(" SExp ")"
 ;
syntax Decl
       =
       ExQuant "disj"? ListLocId ":" SExp
 ;
syntax AExp
       = AExp "+" AExp1
       | AExp "-" AExp1
       | AExp1
 ;
syntax AExp1
       = AExp1 "*" AExp2
       | AExp2
 ;
syntax AExp2
       = "#" SExp
       | SExp
       | Integer
       | "(" AExp ")"
 ;
syntax StrExp
       = StrExp "++" StrExp
       | String
 ;

syntax ModId
       =
       Ident
 ;
syntax LocId
       =
       Ident
 ;
syntax ListEnumId
       = {Ident "|"}* 
 ;

syntax ListDecl
       =
       {Decl ","}*
 ;
syntax ListLocId
       =
       {LocId ","}*
 ;
syntax ListModId
       =
       (ModId "/")*
 ;
 
 
lexical Ident
  = ([a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]) \ ClaferKwd
  ;
  

layout Default
  = WhitespaceOrComment* !>> [\ \t\n\f\r] !>> [{\-];
  
syntax WhitespaceOrComment 
  = whitespace: Whitespace
  | comment: Comment
  ; 

lexical Whitespace = [\ \t\n\f\r]; 

lexical Comment
  = [\-][\-] ![\n\r]* $
  | [{][\-] ( ![\-] | [\-] !>> [}])* [\-][}]
  ;
  
keyword ClaferKwd = "abstract" | "all" | "disj" | "else" | "enum" | "extends"
    | "in" | "lone" | "mux" | "no" | "not" | "one" | "opt" | "or" | "some" | "xor";
  
lexical Integer
  = [0]
  | [1-9][0-9]* !>> [0-9]
  ;
  
lexical String
  = [\"] (![\\\"] | ([\\][\\\"]))* [\"]
  ;