class Alumno {

	var property materiasAprobadas = []
	const property materiasInscripto = []
	var property carrerasCursando
	var property creditosAcumulados = 0

	method puedeCursar(materia, carrera) {
		return self.correspondeAAlgunaCarrera(materia) && !self.aprobo(materia) && !self.estaInscripto(materia) && materia.cumplePrerrequsitosPara(self, carrera)
	}

	method correspondeAAlgunaCarrera(materia) = carrerasCursando.any{ carrera => carrera.contieneUna(materia) }

	method aprobo(materia) = materiasAprobadas.contains(materia)

	method estaInscripto(materia) = materiasInscripto.contains(materia)

	method aproboTodasLasDe(anio, carrera) = self.materiasAprobadasDe(anio, carrera).size() == carrera.totalMateriasDe(anio)

	method materiasAprobadasDe(anio, carrera) = materiasAprobadas.filter{ materia => materia.perteneceA(carrera) && materia.anioAlQuePertenece() == anio }

	method registrarMateriaAprobada(materia, nota) {
		if (nota != materia.nota()) {
			materiasAprobadas.add(materia)
			creditosAcumulados += materia.creditosQueOtorga()
		}
	}

	method materiasEnListaDeEspera() = self.materiasTotales().filter{ materia => self.estaEnListaDeEsperaEn(materia) }

	method estaEnListaDeEsperaEn(materia) = materia.estudiantesEnListaDeEspera().contains(self)

	method materiasTotalesLLS() = carrerasCursando.map{ carrera => carrera.materias() }

	method materiasTotales() = self.materiasTotalesLLS().flatten()

	method inscribirseEn(materia, carrera) {
		materia.inscribirSegunCriterio(self, carrera)
	}

	method darseDeBajaDe(materia, carrera) {
		materia.darseDeBajaSegunCriterio(self, carrera)
	}

	method notas() = materiasAprobadas.map{ materia => materia.nota() }

	method promedio() = self.notas().sum() / materiasAprobadas.size()

	method tieneElMejorPromedioEn(materia) = self.promediosDeTodosLosAlumnosDe(materia).max() == self.promedio()

	method promediosDeTodosLosAlumnosDe(materia) = materia.estudiantesEnListaDeEspera().map{ alumno => alumno.promedio() }

	method tieneElMayorDeMateriasAprobadasEn(materia, carrera) = self.materiasAprobadasDeTodosLosAlumnosDe(materia, carrera).size().max() == materiasAprobadas.size()

	method materiasAprobadasDeTodosLosAlumnosDe(materia, carrera) = materia.estudiantesEnListaDeEspera().map{ alumno => alumno.materiasAprobadas() }

}

