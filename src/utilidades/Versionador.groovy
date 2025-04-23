package utilidades

class Versionador implements Serializable {
    static String generar(String branch, String commit) {
        return "${branch}-${commit.take(7)}"
    }
}