# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 001 - Suma
#
# Ejemplo báisco con sumas
# En este ejemplo se realiza la primera operación aritmética.
# Se suman dos números y se "muestra" el resultado
# a través del código de retorno del sistema.
# Es una forma simple de "imprimir" un resultado.
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

  # Llamada: sys_exit
  # Dado que el valor está en %ebx, se podrá "ver" en la consola
  movl  $1, %eax
  int   $0x80
