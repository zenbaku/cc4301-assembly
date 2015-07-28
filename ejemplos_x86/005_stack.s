# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 005 - Stack
#
# Ejemplo básico con el uso del stack
#
#
.text
  .global _start
_start:
  
  # El stack es una estructura en memoria RAM que permite almacenar valores.
  # Existe un registro, llamado BASE POINTER (%ebp), que apunta a la dirección
  # de memoria donde está actualmente la base del stack (fondo).
  # También está el registro STACK POINTER (%esp), que apunta a la dirección
  # de memoria donde está actualmente la cabeza del stack (top).
  leal (%esp), %ebx # => 48 en mi máquina
  leal (%ebp), %ebx # => 0 en mi máquina

  # Para meter un valor al stack, se utiliza "push" (con el sufijo adecuado)
  pushl $123
  pushl $32
  pushl $5
  pushl $95

  # También se puede meter directamente el valor almacenado en un registro
  movl $10, %eax
  push %eax

  # Para sacar un valor, se debe especificar el registro en el cual se
  # guardará dicho valor
  pop %ebx # => 10


  movl  $1, %eax
  int   $0x80
