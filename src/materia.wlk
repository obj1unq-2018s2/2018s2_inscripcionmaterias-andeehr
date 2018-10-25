class Materia {

	const property correlativas = []
	var property creditosQueOtorga
	var property anioAlQuePertenece
	const property estudiantesInscriptos = []
	var property cupo
	const property estudiantesEnListaDeEspera = []
	var property carreraEnLaQueFigura

	method agregarAlumnoInscripto(alumno) {
		estudiantesInscriptos.add(alumno)
	}

	method agregearAlumnoAEspera(alumno) {
		estudiantesEnListaDeEspera.add(alumno)
	}

	method pasarDeListaDeEsperaAInscripto() {
		estudiantesInscriptos.add(estudiantesEnListaDeEspera.first())
		estudiantesEnListaDeEspera.remove(estudiantesEnListaDeEspera.first())
	}
	method agregarCorrelativas(materia) {
		correlativas.add(materia)
	}
	
	method perteneceA(carrera) = carreraEnLaQueFigura == carrera
}

class MateriaQueRequiereCorrelativas inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = correlativas.all{ materia => alumno.aprobo(materia) }

}

class MateriaQueRequiere250Creditos inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = alumno.creditosAcumlados() >= 250

}

class MateriaQueRequiereAprobarAnioAnterior inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = alumno.aproboTodasLasDe(anioAlQuePertenece)

}

class MateriaSinRequisitos inherits Materia {

	method cumplePrerrequsitosPara(alumno, carrera) = true

}

