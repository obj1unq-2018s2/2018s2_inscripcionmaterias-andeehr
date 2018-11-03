class Universidad {
//	var property alumnos
//	var property materias
	var property carreras
//	var property nota
	const property registros = []

	method registrar(alumno, materia, nota) {
		if (!registros.contains([ alumno, materia, nota ])) {
			registros.add([ alumno, materia, nota ])
			alumno.aprobar(materia)
		}
	}
	method inscribir(alumno, materia, carrera) {
		// TODO Código repetido, falta delegación.
		if (materia.cupo() > materia.estudiantesInscriptos().size() && alumno.puedeCursar(materia, carrera)){
			alumno.inscribirse(materia)
			materia.agregarAlumnoInscripto(alumno)
		} else if (alumno.puedeCursar(materia, carrera)){
			materia.agregearAlumnoAEspera(alumno)
		} else {
			self.error("No cumple los requisitos para anotarse")
		}
	}
	
	// TODO De aquí para abajo todo es innecesario.
	method desinscribir(alumno, materia) {
		alumno.desinscribirse(materia)
		materia.pasarDeListaDeEsperaAInscripto()
	}
	method estudiantesInscriptosEn(materia) = materia.estudiantesInscriptos()
	method estudiantesEnListaDeEspera(materia) = materia.estudiantesEnListaDeEspera()

	method materiasALasQueSePuedeInscribir(alumno, carrera) {
		carrera.materias().filter{materia => alumno.puedeCursar(materia) && alumno.estaInscriptoEnCarrera(carrera)}
	}
	
	method materiasALasQueEstaInscripto(alumno) = alumno.materiasInscripto()
	
	method materiasEnLasQueQuedoEnEspera(alumno) = alumno.materiasEnListaDeEspera()
}

