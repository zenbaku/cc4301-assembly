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
  movl $30, %eax
  movl $56, %ebx

  # Sumar a %ebx el valor en %eax
  add %eax, %ebx # %ebx = %ebx + %eax

  # Resta
  movl $60, %eax
  movl $72, %ebx

  sub %eax, %ebx # => 12

  movl $72, %eax
  movl $0, %ebx

  sub %eax, %ebx # => 182 "overflow"

  # Incrementar, decrementar
  movl $123, %ebx
  inc %ebx # => 124
  dec %ebx # => 123
  neg %ebx # => 133, ver "Representación"

  # Multiplicación
  movl $4, %eax
  movl $2, %ebx
  mul %ebx # %eax * %ebx, high -> %edx, low -> %eax => 8

  movl %eax, %ebx

  # Division
  movl $10, %eax
  movl $3, %ebx
  div %ebx # => quotient = %eax = 3, remain = %ebx = 1

  movl %edx, %ebx

  # Llamada: sys_exit
  # Dado que el valor está en %ebx, se podrá "ver" en la consola
  movl  $1, %eax
  int   $0x80
