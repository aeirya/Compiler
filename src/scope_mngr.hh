#ifndef _H_scope_mngr
#define _H_scope_mngr

#include "list.h"
#include "hashtable.h"
#include "ast_decl.h"
#include "errors.h"

class ScopeManager {
  private:
    int scopeLevel;
    Hashtable<Decl*> global;
    List<List<const char*>*> localStack;
    List<const char*> *local;
    
    bool isInLocalScope(const char*);

  public:
    ScopeManager();
    ~ScopeManager();

    void beginScope();
    void endScope();

    void declVar(Identifier* name, Decl* decl);
    bool isDefined(Identifier* name);
};

// TODO: remove scope level field (not used)

#endif
