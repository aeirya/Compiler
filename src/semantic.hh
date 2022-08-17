#ifndef _H_semantic
#define _H_semantic

#include "scope_mngr.hh"

class ScopeManager;

class SemanticAnalyzer {
    private:
    ScopeManager* scopeManager;
    
    public:
    ~SemanticAnalyzer() {
        delete scopeManager;
    }

    ScopeManager* getScopeManager() {
        return scopeManager;
    }
};

#endif