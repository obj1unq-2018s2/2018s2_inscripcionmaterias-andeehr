class Materia {
	// TODO El atributo correlativas corresponde a la subclase.
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
	// TODO Siendo que la materia pertenece a una carrera, el atributo carrera en este método y muchos otros podría reemplazarse por "carreraEnLaQueFigura"
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

// TODO De aquí hasta el final, mal usada la herencia => se espera poder combinar los criterios de inscripción con los criterios de ordenamiento de la lista de espera.
class MateriaPorOrdenDeLlegada inherits MateriaSinRequisitos {

	method inscribirSegunCriterio(alumno, carrera) {
		// TODO Esta validación está repetida varias veces, evitalo.
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
			// TODO Este manejo de la lista de espera no coincide con lo que pide el enunciado.
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

