#include "scope_mngr.hh"

ScopeManager::ScopeManager() {
    scopeLevel = 0;
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

bool ScopeManager::isInLocalScope(char* id) {
    if (local.size() == 0) return false;
    
    for (char* c: local) {
        if (strcmp(id, c) == 0) return true;
    }
    return false;
}

void ScopeManager::declVar(Identifier* id, Decl* decl) {
    // scope
    char* name = id->getName();
    cout << "name is " << name << endl;

    if (isInLocalScope(name)) {
        cout << "decl var" << endl;
        Decl* lookup = global.Lookup(name);
        cout << "looked up" << endl;
        ReportError::DeclConflict(decl, lookup);
    } else {
        cout << "appending" << endl;
        local.append(name);
    }
}