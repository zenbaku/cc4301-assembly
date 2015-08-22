# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 004 - Subrutinas
#
# Ejemplo básico con la definición y uso de una subrutina
#
#
# Las definiciones de funciones deben ir dentro un bloque de "texto"
.text
# no es necesario usar .global con subrutinas que se usarán dentro de este mismo archivo
# se escribe un nombre (etiqueta) para la
mifun:
  # no hay nada de especial en una subrutina, es sólo una porción de código
  # al que se le ha dado un nombre y a la cual es posible "saltar"
  # cuando se quiera.
  add %r0, %r0, %r1

  # las subrutinas deben terminar con un "ret" (return),
  # que retorna el flujo de ejecución al lugar desde el
  # cual se llamó a la subrutina.
  # EN ARM SE UTILIZA bx y el registro de retorno.
  bx %lr
  # luego del ret puede venir cualquier cosa válida en una sección de texto
  # en este caso, la definición del "main"
.global _start
_start:

  mov %r0, $12
  mov %r1, $32

  # Para invocar una subrutina basta con utilizar la instrucción "call"
  # más el nombre de la función.
  # En este caso, "mifun" altera el valor de %r0, sumándole el valor
  # presente en %r1.
  bl mifun
  # %r0 => 44

  # La subrutina puede invocarse múltiples veces
  bl mifun
  # %r0 => 56

  # Saliendo
  mov  %r7, $1
  mov  %r0, %r0
  svc $0
