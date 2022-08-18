#include "semantic.hh"

SemanticAnalyzer::SemanticAnalyzer() {
    scopeManager = new ScopeManager;
}

SemanticAnalyzer::~SemanticAnalyzer() {
    delete scopeManager;
}

