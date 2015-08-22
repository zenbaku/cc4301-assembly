# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 001 - Inicio
#
# Ejemplo básico con lo mínimo para ensamblar y ejecutar.
# En este ejemplo sólo se realiza una llamada al sistema, sys_exit
# para notificar al sistema que el programa terminó. Adicionalmente se puede
# entregar un código (número) que el sistema usa para diagnosticar el resultado
# del programa. Típicamente retornar 0 (cero) es terminar bien.
#
#
# Se declara un segmento de texto, que tendrá código ejecutable
# Otro segmento usual es el de ".data", que declara datos (en vez de código).
.text
# Se declara que el símbolo "_start" es global y visible para todo el programa
  .global _start
# Se declara la etiqueta "_start". Esto crea un símbolo que apunta a esta
# ubicación en el archivo.
_start:
  # Inicio del programa

  # Se prepara una llamada al sistema
  # Llamada: sys_exit
  # Código de la llamada: 1, se ubica en R7
  mov  %r7, $1
  # Código de retorno: 0, se ubica en R0
  # Se puede cambiar por cualquie otro número. En la consola pueda verse
  # con el comando `echo $?`
  mov  %r0, $0
  # Se invoca al sistema. Cada llamada e invocación al sistema es específico
  # del sistema operativo.
  # En este caso ARM
  svc $0
