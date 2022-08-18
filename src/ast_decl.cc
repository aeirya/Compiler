/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_type.h"
#include "ast_stmt.h"

Decl::Decl(Identifier *n) : Node(*n->GetLocation()) {
    Assert(n != NULL);
    (id=n)->SetParent(this); 
}

Json::Value Decl::toJson() {
    Json::Value val = Node::toJson();
    val["node_type"] = "decl";
    val["id"] = id->getName();
    return val;
}

VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != NULL && t != NULL);
    (type=t)->SetParent(this);
}


ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != NULL && imp != NULL && m != NULL);     
    extends = ex;
    if (extends) extends->SetParent(this);
    (implements=imp)->SetParentAll(this);
    (members=m)->SetParentAll(this);
}

void ClassDecl::Check(SemanticAnalyzer* sem) {
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != NULL && m != NULL);
    (members=m)->SetParentAll(this);
}

void InterfaceDecl::Check(SemanticAnalyzer* sem) {
}


	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != NULL && r!= NULL && d != NULL);
    (returnType=r)->SetParent(this);
    (formals=d)->SetParentAll(this);
    body = NULL;
}

void FnDecl::Check(SemanticAnalyzer* sem) {
}


void FnDecl::SetFunctionBody(Stmt *b) { 
    (body=b)->SetParent(this);
}

/** Decl::toJson implementations */

Json::Value VarDecl::toJson() {
    Json::Value val = Decl::toJson();
    val["node_type"] = "var_decl";
    val["type"] = type->toJson();
    return val;
}

Json::Value FnDecl::toJson() {
    Json::Value val = Decl::toJson();
    val["node_type"] = "fn_decl";
    val["return_type"] = returnType->toJson();

    Json::Value formalsJson(Json::arrayValue);
    for (VarDecl* decl : *formals) {
        formalsJson.append(decl->toJson());
    }
    val["formals"] = formalsJson;
    val["body"] = body->toJson();
    return val;
}

/** Decl::Check implementations */

void VarDecl::Check(SemanticAnalyzer* sem) {
    // TODO: bug here: symbol not found declvar
    auto scope = sem->getScopeManager();
    scope->declVar(id, this);
}