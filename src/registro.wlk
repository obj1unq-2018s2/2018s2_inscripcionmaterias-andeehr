class Registro {
	var property alumnos
//	var property materias
	var property carreras
//	var property nota
	var property registros

	method registrar(alumno, materia, nota) {
		if (!registros.contains([ alumno, materia, nota ])) {
			registros.add([ alumno, materia, nota ])
			alumno.aprobar(materia)
		}
	}
	method inscribir(alumno, materia) {
		if (materia.cupo() > materia.estudiantesInscriptos()){
			alumno.inscribirse(materia)
			materia.agregarAlumnoInscripto(alumno)
		} else {
			materia.agregearAlumnoAEspera(alumno)
		}		
	}
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
	
	method materiasEnLasQueQuedoEnEspera(alumno) {}
}

