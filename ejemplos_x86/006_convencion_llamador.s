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
  # La convención del llamador consiste en una serie de reglas
  # que permiten definir una interfaz uniforme para utilizar subrutinas,
  # incluso aquellas desarrolladas por terceros.
  # Se guarda la base del stack original
  pushl %ebp
  # La nueva base es el tope del stack original
  # En este momento, ambos registros apuntan a la misma dirección.
  # Y el stack se considera vacío.
  movl %esp, %ebp

  # Se resguardan los registros según convención.
  pushl %edi
  pushl %esi
  pushl %ebx

  # Se agranda el registro de activación para variables locales
  subl $4, %esp

  # Cuerpo de la subrutina. Se accede a los argumentos. Notar el orden.
  movl 8(%ebp), %eax # => 37
  movl 12(%ebp), %edi # => 23
  movl 16(%ebp), %esi # => 17

  # Sumar todo a %eax
  addl %edi, %eax
  addl %esi, %eax

  # Se descartan variables locales
  addl $4, %esp

  # Se restituyen registros guardados. Notar el orden inverso respecto
  # a como fueron apilados.
  popl %ebx
  popl %esi
  popl %edi

  # leave restituye los punteros al stack original
  leave
  # ret restituye el puntero de instrucciones, para retornar
  # el flujo al llamador
  ret
  .global _start
_start:

  # Se apilan los argumentos en orden inverso a su definicion
  # int mifun(a, b, c) {...}
  # se apila c
  push $17
  # se apila b
  push $23
  # se apila a
  push $37
  call mifun

  # El retorno está en %eax
  mov %eax, %ebx # => 77

  # Se desapilan los argumentos
  addl $8, %esp # equivale a dos popl
  
  movl  $1, %eax
  int   $0x80
