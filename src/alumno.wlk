class Alumno {

	var property materiasAprobadas
	var property materiasInscripto
	var property carrerasCursando
	var property creditosAcumlados

	method puedeCursar(materia) {
		return self.correspondeAAlgunaCarrera(materia) && !self.aproboPreviamente(materia) &&
		!self.estaInscripto(materia) && materia.cumplePrerrequsitosPara(self)
	}
	method correspondeAAlgunaCarrera(materia) = carrerasCursando.any{carrera => carrera.contieneUna(materia)}
	method aproboPreviamente(materia) = materiasAprobadas.contains(materia)
	method estaInscripto(materia) = materiasInscripto.contains(materia)
	method aproboTodasLasDe(anio) = {true}
	method aprobar(materia) {
		materiasAprobadas.add(materia)
	}
	
	method inscribirse(materia) {
		materiasInscripto.add(materia)
	}
	method desinscribirse(materia) {
		materiasInscripto.remove(materia)
	}
	method estaInscriptoEnCarrera(carrera) = carrerasCursando.contains(carrera)
}

