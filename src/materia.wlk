class Materia {

	var property correlativas
	var property creditosQueOtorga
	var property anioAlQuePertenece
	var property estudiantesInscriptos
	var property cupo
	var property estudiantesEnListaDeEspera
	var property carreraEnLaQueFigura

	method cumplePrerrequsitosPara(alumno)

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

}

class Objetos2 inherits Materia {

	override method cumplePrerrequsitosPara(alumno) = correlativas.all{ materia => alumno.aproboPreviamente(materia) }

}

class TrabajoFinal inherits Materia {

	override method cumplePrerrequsitosPara(alumno) = alumno.creditosAcumlados() >= 250

}

class Objetos3 inherits Materia {

	override method cumplePrerrequsitosPara(alumno) = alumno.aproboTodasLasDe(anioAlQuePertenece)

}

class EPYL inherits Materia {

	override method cumplePrerrequsitosPara(alumno) = true

}

