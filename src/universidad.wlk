class Universidad {
	// TODO Esta clase es completamente innecesaria
	var property carreras

	method estudiantesInscriptosEn(materia) = materia.estudiantesInscriptos()

	method estudiantesEnListaDeEspera(materia) = materia.estudiantesEnListaDeEspera()

	method materiasALasQueSePuedeInscribir(alumno, carrera) {
		carrera.materias().filter{ materia => alumno.puedeCursar(materia) && alumno.estaInscripto(carrera)}
	}

	method materiasALasQueEstaInscripto(alumno) = alumno.materiasInscripto()

	method materiasEnLasQueQuedoEnEspera(alumno) = alumno.materiasEnListaDeEspera()

}

