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

bool ScopeManager::isInLocalScope(const char* id) {
    for (const char* c: local) {
        if (strcmp(id, c) == 0) return true;
    }
    return false;
}

void ScopeManager::declVar(Identifier* id, Decl* decl) {
    // scope
    char* name = id->getName();
    if (isInLocalScope(name)) {
        ReportError::DeclConflict(decl, global.Lookup(name));
    }
}