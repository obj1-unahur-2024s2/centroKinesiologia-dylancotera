object centroKinesiologia {
  const aparatos = []
  const pacientes = []

  method agregarAparato(unAparato){
    aparatos.add(unAparato)
  }

  method agregarPaciente(unPaciente){
    pacientes.add(unPaciente)
  }

  method coloresAparatos() = aparatos.map({a => a.color()}).asSet().asList()

  method pacientesMenoresA(unNumero) = pacientes.filter({p => p.edad() < unNumero})

  method pacientesSinCumplirSesion() = pacientes.count({p => not p.puedeHacerRutina()})

  method estaEnOptimasCondiciones() = aparatos.all({a => not a.necesitaMantenimiento()})

  method estaComplicado() = aparatos.count({a => a.necesitaMantenimiento()}) >= aparatos.size() / 2     

  method realizarMantenimiento() {
    const aparatosNecesitados = aparatos.filter({a => a.necesitaMantenimiento()})
    aparatosNecesitados.forEach({a => a.hacerMantenimiento()})
  }

}