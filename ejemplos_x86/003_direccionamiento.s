# CC4301 - Arquitectura de Computadores
# Facultad de Ciencias Físicas y Matemáticas
# Universidad de Chile
#
# 003 - Manejo de Datos
#
# Ejemplo básico con uso de datos y direccionamiento.
# En este ejemplo, se muestra cómo acceder a secciones de la memoria
# donde se hayan alojado datos, y cómo leer estos datos para usarlos
# en el programa.
#
#
# Se inicia un segmento de datos. Acá NO va ningún tipo de instrucción
# y sólo se pueden usar directivas para generar datos.
.data
# Se declara el símbolo `mi_numero`. Esto genera una etiqueta que apunta
# a esta sección de memoria (al principio de ella).
mi_numero:
  # Se guarda un número de tipo "long" en esta sección.
  # Esto guardará el número utilizando 4 bytes.
  .long 234
# Se declara otro símbolo, que apuntará justo después del anterior.
mi_palabra:
  # Se usa la directiva `.ascii` para guardar una cadena de texto.
  .ascii "Hola, que tal?"
  # Esto es equivalente a escribir
  # .byte 72
  # .byte 111
  # .byte 108
  # .byte 97
  # ... etc
.text
  .global _start
_start:
  # Para referirse al valor, basta con usar el símbolo
  movl mi_numero, %edx

  # `mi_palabra` apunta al primer caracter de la palabra.
  # en este caso, "H", que está codificado con el número 72
  # que es el código que tiene en la tabla ASCII.
  # se puede operar como si fuera un número.
  # Luego, se verá cómo imprimir la palabra completa utilizando
  # la salida estándar.

  # Para leer un dato, basta con referirse a él.
  # Por ejemplo, para cargar el número 234, alojado en "mi_numero":
  movl mi_numero, %ebx

  # Sin embargo, si hay varios datos, por ejemplo, un arreglo o una cadena
  # de texto, es necesaria una forma de "recorrer" la memoria.
  # Para eso se puede utilizar el direccionamiento (addressing)

  # Primero, hay que partir con una dirección de memoria.
  # Para obtener la dirección de memoria que ocupa un dato, basta con agregar
  # el signo $ (peso) antes del nombre.
  movl $mi_palabra, %ecx

  # Otra forma, equivalente y más programática, es utilizar LEA
  leal mi_palabra, %ecx

  # La ventana de LEA es que también acepta direcciones de memoria y registros
  # como argumentos, lo que entrega cierto dinamismo en tiempo de ejecución
  # que permite, por ejemplo, la funcionalidad de punteros en C.

  # Para leer cada caracter de la cadena (o números de un arreglo)
  # basta con copiar el valor, entregando un desplazamiento.
  # En este caso, cada caracter ocupa un byte de memoria, por lo que el
  # desplazamiento es de 1 siempre. Si el arreglo fuera de INTs, y suponiendo
  # que se utilizan 4 bytes para almacenar cada valor.
  movl 0(%ecx), %ebx # 72  = H
  movl 1(%ecx), %ebx # 111 = o
  movl 2(%ecx), %ebx # 108 = l
  movl 3(%ecx), %ebx # 97  = a

  # También se puede utilizar otro registro como índice
  # Supongamos que se desea acceder al 5to elemento.
  # El índice sería el 4, puse se cuenta desde el cero.
  # Se guarda en un registro
  movl $4, %edx
  # Y se realiza desplazamiento, pero esta base usando esta notación
  movl (%ecx, %edx), %ebx # 44  = ,

  # La notación completa es
  #   displacement(base, index, scale)
  # Donde:
  # - displacemente: es un inmediato, que se suma al resultado
  # - base: un registro, que tiene la dirección de memoria base
  # - index: un registro utilizado para "salta", o "indexar" la dirección
  # - scale: un registro para escalar el salto.
  #
  # Se calcula como:
  # resultado = base + (index * scale) + displacement
  #
  # Scale por defecto es 1 (un byte). Para arreglos de INTs, debería usarse 4.

  # Llamada: sys_exit
  movl  $1, %eax
  int   $0x80
