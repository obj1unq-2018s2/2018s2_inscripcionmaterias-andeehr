class Materia {

	const property correlativas = []
	var property creditosQueOtorga
	var property anioAlQuePertenece
	const property estudiantesInscriptos = []
	var property cupo
	const property estudiantesEnListaDeEspera = []
	var property carreraEnLaQueFigura

	method agregarCorrelativas(materia) {
		correlativas.add(materia)
	}

	method agregarAlumnoInscripto(alumno) {
		estudiantesInscriptos.add(alumno)
	}

	method agregarAlumnoAListaDeEspera(alumno) {
		estudiantesEnListaDeEspera.add(alumno)
	}

	method eliminarDeListaDeEspera(alumno) {
		estudiantesEnListaDeEspera.remove(alumno)
	}

	method perteneceA(carrera) = carreraEnLaQueFigura == carrera

	method hayCupo() = self.cupo() > self.estudiantesInscriptos().size()

	method darseDeBajaSegunCriterio(alumno, carrera) {
		estudiantesInscriptos.remove(alumno)
		estudiantesInscriptos.add(estudiantesEnListaDeEspera.first())
	}

}

class MateriaQueRequiereCorrelativas inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = correlativas.all{ materia => alumno.aprobo(materia) }

}

class MateriaQueRequiere250Creditos inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = alumno.creditosAcumlados() >= 250

}

class MateriaQueRequiereAprobarAnioAnterior inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = alumno.aproboTodasLasDe(anioAlQuePertenece -1, carrera)

}

class MateriaSinRequisitos inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = true

}

class MateriaPorOrdenDeLlegada inherits MateriaSinRequisitos {

	method inscribirSegunCriterio(alumno, carrera) {
		if (self.hayCupo() && alumno.puedeCursar(self, carrera)) {
			alumno.materiasInscripto().add(self)
			self.agregarAlumnoInscripto(alumno)
			self.eliminarDeListaDeEspera(alumno)
		}
	}

}

class MateriaElitista inherits MateriaSinRequisitos {

	method inscribirSegunCriterio(alumno, carrera) {
		if (self.hayCupo() && alumno.puedeCursar(self, carrera) && alumno.tieneElMejorPromedioEn(self)) {
			self.agregarAlumnoInscripto(alumno)
			self.eliminarDeListaDeEspera(alumno)
		} else {
			self.error("No cumple los requisitos para anotarse")
		}
	}

}

class MateriaPorGradoDeAvance inherits MateriaSinRequisitos {

	method inscribirSegunCriterio(alumno, carrera) {
		if (self.hayCupo() && alumno.puedeCursar(self, carrera) && alumno.tieneElMayorDeMateriasAprobadasEn(carrera)) {
			self.agregarAlumnoInscripto(alumno)
			self.eliminarDeListaDeEspera(alumno)
		} else {
			self.error("No cumple los requisitos para anotarse")
		}
	}

}

class MateriaAprobada {

	var property materia
	var property alumno
	var property nota

}

