class Alumno {

	var property materiasAprobadas = []
	const property materiasInscripto = []
	var property carrerasCursando
	var property creditosAcumulados = 0

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
		creditosAcumulados += materia.creditosQueOtorga()
	}
	
	method inscribirse(materia) {
		materiasInscripto.add(materia)
	}
	method desinscribirse(materia) {
		materiasInscripto.remove(materia)
	}
	method estaInscriptoEnCarrera(carrera) = carrerasCursando.contains(carrera)
	
	method materiasEnListaDeEspera() = self.materiasTotales().filter{materia => self.estaEnListaDeEsperaEn(materia)}
	
	method estaEnListaDeEsperaEn(materia) = materia.estudiantesEnListaDeEspera().contains(self)
	
//	method materiasEnListaDeEsperaEn(carrera) = carrera.materias().filter{materia => self.estoyEnListaDeEsperaEn(materia)}
	
	method materiasTotalesLLS() = carrerasCursando.map{ carrera => carrera.materias()}
	
	method materiasTotales() = self.materiasTotalesLLS().flatten()
}

