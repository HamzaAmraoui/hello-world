package utilidades

class Versionador implements Serializable {
    static String generar(String branch, String commit) {
        if (!branch || !commit) {
            return "unknown-unknown"
        }
        return "${branch}-${commit.take(7)}"
    }
}
