

class Paciente{
  const property edad
  var property fortalezaMuscular
  var property nivelDeDolor
  const rutina = []

  method puedeUsar(unAparato) = unAparato.condicion(self)

  method usarAparato(unAparato) {
    if ( self.puedeUsar(unAparato) )
      unAparato.hacerEfecto(self)
  }

  method puedeHacerRutina() = rutina.all({ a => self.puedeUsar(a) })

  method realizarRutina(){
    rutina.forEach({ a => self.usarAparato(a) })
  }

} 

class Resistente inherits Paciente{

  override method realizarRutina() {
    const cantidadUsados = rutina.count({a => self.puedeUsar(a)})
    super()
    fortalezaMuscular += cantidadUsados
  }
}

class Caprichoso inherits Paciente{

  override method puedeHacerRutina() = super() && rutina.any({a => a.color() == "rojo" })

  override method realizarRutina(){
    super()
    rutina.forEach({ a => self.usarAparato(a) })
  }

}

class RapidaRecuperacion inherits Paciente{
  var cantidad = 3

  override method realizarRutina(){
    super()
    nivelDeDolor = nivelDeDolor - cantidad
  }

  method cambiarValorDecremento(unValor) { cantidad = unValor }
}


class Aparato{
  const property color = "blanco"

  method condicion(unPaciente)

  method hacerEfecto(unPaciente)

  method necesitaMantenimiento() = false

  method hacerMantenimiento() {}

}

class Magneto inherits Aparato {
  var puntosImantacion = 800

  override method condicion(unPaciente) = true

  override method hacerEfecto(unPaciente){
    unPaciente.nivelDeDolor(  (unPaciente.nivelDeDolor() - unPaciente.nivelDeDolor() * 0.1).max(0) )
    puntosImantacion = (puntosImantacion - 1).max(0)
  }

  override method necesitaMantenimiento() = puntosImantacion < 100

  override method hacerMantenimiento() { puntosImantacion = (puntosImantacion + 500).min(800) }

}

class Bicicleta inherits Aparato{
  var desajusteTornillos = 0
  var perdidaAceite = 0

  override method condicion(unPaciente) = unPaciente.edad() > 8

  override method hacerEfecto(unPaciente){
    self.uso(unPaciente)
    unPaciente.nivelDeDolor( (unPaciente.nivelDeDolor() - 4).max(0) )
    unPaciente.fortalezaMuscular( unPaciente.fortalezaMuscular() + 3 )  
  }

  method uso(unPaciente) {
    if ( unPaciente.nivelDeDolor() > 30) { desajusteTornillos += 1 }
    if ( unPaciente.edad().between(30, 50) ) { perdidaAceite += 1 }
  }

  override method necesitaMantenimiento() = desajusteTornillos >= 10 || perdidaAceite >= 5

  override method hacerMantenimiento() { 
    desajusteTornillos = 0
    perdidaAceite = 0
   }

}

class Minitramp inherits Aparato {

  override method condicion(unPaciente) = unPaciente.nivelDeDolor() < 20

  override method hacerEfecto(unPaciente){
    unPaciente.fortalezaMuscular( unPaciente.fortalezaMuscular() + unPaciente.edad() * 0.1 ) 
  }
}