import io/File
import Module
import ../frontend/[Token, AstBuilder]

/**
 * An ooc module importing another.
 *
 * There are two types of imports: tight and loose. Tight
 * imports are those who directly access data structures that
 * are defind in other modules.
 *
 * By default, an import is loose, until proven tight. As soon
 * as a module is proven guilty of accessing another module's field directly
 * (instead of passing via a getter), or subclassing another module's type,
 * it becomes a tight import.
 *
 * Note that all this is C detailery, and it shouldn't even appear in
 * a pure ooc ast, but such is the burden of maintaining rock.
 *
 * :author: Amos Wenger (nddrylliog)
 */
Import: class {

    path: String
    module : Module = null
    isTight: Bool { get set } // tight imports include '.h', loose imports include '-fwd.h'
    token: Token

    init: func ~imp (=path, =token) {
        this path = this path replaceAll('/', File separator)
        this isTight = false
    }

    setModule: func(=module) {
        if(module != null) {
            module timesImported += 1
        }
    }

    getModule: func -> Module {
        if(module == null && token module != null) {
            (path, impPath, impElement) :=  AstBuilder getRealImportPath(this, token module, token module params)
            if(impPath != null) {
                setModule(AstBuilder cache get(impPath path))
            }
        }
        module
    }

    getPath: func -> String { path }

}
