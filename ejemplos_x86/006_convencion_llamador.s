# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 006 - Convención del llamador
#
# Ejemplo básico con la convención del llamador utilizada en el curso.
#
#
.text
mifun:
  # Toda la idea de la "convención del llamador" es permitir que las subrutinas
  # puedan aceptar argumentos y retornar valores.

  add %eax, %ebx

  ret
  .global _start
_start:
  
  # Para invocar una subrutina basta con utilizar la instrucción "call"
  # más el nombre de la función.
  # En este caso, "mifun" altera el valor de %ebx, sumándole el valor
  # presente en %eax.
  call mifun # %ebx => 44

  # La subrutina puede invocarse múltiples veces
  call mifun # %ebx => 56

  movl  $1, %eax
  int   $0x80
