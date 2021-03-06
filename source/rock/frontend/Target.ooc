/**
 * Used to represent the target platform/architecture for which we're building.
 *
 * @author Amos Wenger
 */
Target: class {

    /* various GNU/Linux */
    LINUX = 1,
    /* Win 9x, NT, MinGW, etc.*/
    WIN = 2,
    /* Solaris, OpenSolaris */
    SOLARIS = 3,
    /* Haiku */
    HAIKU = 4,
    /* Mac OS X */
    OSX = 5,
    /* FreeBSD */
    FREEBSD = 6,
    /* OpenBSD */
    OPENBSD = 7,
    /* NetBSD */
    NETBSD = 8,
    /* DragonFly BSD */
    DRAGONFLY = 9,
    /* Android */
    ANDROID = 10 : static const Int

    /**
     * @return a guess of the platform/architecture we're building on
     */
    guessHost: static func -> Int {

        version(linux)     return This LINUX
        version(windows)   return This WIN
        version(solaris)   return This SOLARIS
        version(haiku)     return This HAIKU
        version(apple)     return This OSX
        version(freebsd)   return This FREEBSD
        version(openbsd)   return This OPENBSD
        version(netbsd)    return This NETBSD
        version(dragonfly) return This DRAGONFLY
        version(android)   return This ANDROID

        fprintf(stderr, "Unknown operating system, assuming Linux...\n")
        return This LINUX

    }

    /**
     * @return true if we're on a 64bit arch
     */
    is64: static func -> Bool {
        version(64)  { return true }
        return false
    }

    /**
     * @return '32' or '64' depending on the architecture
     */
    getArch: static func -> String {
        return is64() ? "64" : "32"
    }

    toString: static func ~defaults -> String {
        return toString(getArch())
    }

    toString: static func ~defaultsWithArch (arch: String) -> String {
        return toString(guessHost(), arch)
    }

    toString: static func(target: Int, arch: String) -> String {

        return match(target) {
            case This WIN       => "win" + arch
            case This LINUX     => "linux" + arch
            case This SOLARIS   => "solaris" + arch
            case This HAIKU     => "haiku" + arch
            case This OSX       => "osx"
            case This FREEBSD   => "freebsd" + arch
            case This OPENBSD   => "openbsd" + arch
            case This NETBSD    => "netbsd" + arch
            case This DRAGONFLY => "dragonfly" + arch
            case                => Exception new("Invalid arch: " + target toString()) throw(); ""
        }

    }

}
