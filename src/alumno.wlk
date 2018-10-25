

class Alumno {

	var property materiasAprobadas = []
	const property materiasInscripto = []
	var property carrerasCursando
	var property creditosAcumulados = 0

	method puedeCursar(materia, carrera) {
		return self.correspondeAAlgunaCarrera(materia) && !self.aprobo(materia) &&
		!self.estaInscripto(materia) && materia.cumplePrerrequsitosPara(self, carrera) 
	}
	method correspondeAAlgunaCarrera(materia) = carrerasCursando.any{carrera => carrera.contieneUna(materia)}
	method aprobo(materia) = materiasAprobadas.contains(materia)
	method estaInscripto(materia) = materiasInscripto.contains(materia)


	method aproboTodasLasDe(anio, carrera) = self.materiasAprobadasDe(carrera).count() == carrera.totalMateriasDe(anio)
	
	method materiasAprobadasDe(carrera) = materiasAprobadas.filter{materia => materia.perteneceA(carrera)}
	
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
	
	method materiasEnListaDeEspera() = self.materiasTotales().filter{materia => self.estaEnListaDeEsperaEn(materia)}
	
	method estaEnListaDeEsperaEn(materia) = materia.estudiantesEnListaDeEspera().contains(self)

	method materiasTotalesLLS() = carrerasCursando.map{ carrera => carrera.materias()}
	
	method materiasTotales() = self.materiasTotalesLLS().flatten().asSet()
	
	method aproboTodasLasDe(anio) = self.materiasTotales()
	
//	method materiasAprobadasDe(anio) = materiasAprobadas.filter{materia => materia.anioAlQuePertenece() == anio}
}

