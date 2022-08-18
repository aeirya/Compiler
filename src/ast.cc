/* File: ast.cc
 * ------------
 */

#include "ast.h"
#include "ast_type.h"
#include "ast_decl.h"
#include <string.h> // strdup
#include <stdio.h>  // printf

#include "semantic.hh"

Node::Node(yyltype loc) {
    location = new yyltype(loc);
    parent = NULL;
}

Node::Node() {
    location = NULL;
    parent = NULL;
}
	 
Identifier::Identifier(yyltype loc, const char *n) : Node(loc) {
    name = strdup(n);
} 

Json::Value Node::toJson() {
    Json::Value val = Json::Value(Json::objectValue);
    val["node_type"] = "node";
    return val;
}

/// return true if error
bool Node::Check(SemanticAnalyzer *sem) {
    // nothing
    return false;
}

bool Identifier::Check(SemanticAnalyzer* sem) {
    return sem->getScopeManager()->isDefined(this);
}



