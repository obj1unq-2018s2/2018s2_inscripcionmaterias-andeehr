class Materia {

	const property correlativas = []
	var property creditosQueOtorga
	var property anioAlQuePertenece
	const property estudiantesInscriptos = []
	var property cupo
	const property estudiantesEnListaDeEspera = []
	var property carreraEnLaQueFigura

//	method cumplePrerrequsitosPara(alumno)

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
}

class Objetos2 inherits Materia {

	method cumplePrerrequsitosPara(alumno) = correlativas.all{ materia => alumno.aproboPreviamente(materia) }

}

class TrabajoFinal inherits Materia {

	method cumplePrerrequsitosPara(alumno) = alumno.creditosAcumlados() >= 250

}

class Objetos3 inherits Materia {

	method cumplePrerrequsitosPara(alumno) = alumno.aproboTodasLasDe(anioAlQuePertenece)

}

class EPYL inherits Materia {

	method cumplePrerrequsitosPara(alumno) = true

}

