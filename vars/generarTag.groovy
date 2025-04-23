import utilidades.Versionador

def call(String branch, String commit) {
    return Versionador.generar(branch, commit)
}