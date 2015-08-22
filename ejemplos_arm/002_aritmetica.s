# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 001 - Aritmetica
#
# Ejemplos básicos de aritmetica
#
# En este ejemplo se verán las operaciones aritméticas
# básicas.
# Se deja en %ebx el código de salida. Aprovecharemos
# ese código para "ver" el resultado.
#
#
.text
  .global _start
_start:
  # Inicio del programa

  # Se declaran los valores a sumar, situándolos en registros
  mov %r0, $30
  mov %r1, $56

  # Sumar a %r0 el valor en %r1
  add %r0, %r0, %r1

  # Resta
  mov %r0, $60
  mov %r1, $72

  sub %r0, %r0, %r1
  # => 12

  mov %r0, $72
  mov %r1, $0

  sub %r0, %r0, %r1
  # => 182 "overflow"

  # Incrementar, decrementar.
  # EN ARM NO HAY INC NI DEC
  mov %r0, $123
  add %r0, %r0, $1
  # => 124
  sub %r0, %r0, $1
  # => 123
  neg %r0, %r0
  # => 133, ver "Representación"

  # Multiplicación
  mov %r0, $4
  mov %r1, $2
  mul %r0, %r1
  # => 8

  # Division
  # ARM no soporta división de modo nativo.
  # Debe implementarse a través de subrutinas.

  # Saliendo
  mov  %r7, $1
  mov  %r0, %r0
  svc $0

