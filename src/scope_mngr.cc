#include "scope_mngr.hh"

ScopeManager::ScopeManager() : local() {
    scopeLevel = 0;
}

ScopeManager::~ScopeManager() {
}

void ScopeManager::beginScope() {
    scopeLevel += 1;
}

void ScopeManager::endScope() {
    scopeLevel -= 1;

    for (const char* id: local) {
        global.Remove(id);
    }
    local.clear();
}

bool ScopeManager::isInLocalScope(const char* id) {
    for (auto c: local) {
        if (strcmp(c, id) == 0) return true;
    }
    return false;
}

void ScopeManager::declVar(Identifier* id, Decl* decl) {
    // scope
    char* name = id->getName();
    // cout << "name is " << name << endl;

    if (isInLocalScope(name)) {
        // cout << "decl var" << endl;
        
        Decl* lookup = global.Lookup(name);
        if (lookup == NULL) 
            cout << "lookup NULL" << endl;

        // cout << "looked up" << endl;
        ReportError::DeclConflict(decl, lookup);
    } else {
        // cout << "appending" << endl;
        local.append(name);
        global.Enter(name, decl, false);
    }
}