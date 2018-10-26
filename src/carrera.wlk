class Carrera {

	var property materias

	method contieneUna(materia) = materias.contains(materia)

	method totalMaterias() = materias.size()

	method totalMateriasDe(anio) = materias.count{ materia => materia.anioAlQuePertenece() == anio }

}

