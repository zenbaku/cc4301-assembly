CC4301 Arquitectura de Computadores  - Ejemplos de Assembly
===========================================================

Esta sección pretende materializar muchos de los conceptos estudiados hasta ahora y aplicarlos directamente en pequeños programas que puedan ser ejecutados en sistemas modernos.

1. Para los ejemplos de x86 se utilizará un procesador x86 de 64-bits. El sistema operativo utilizado es *Ubuntu 14.04 LTS*.
2. Para los ejemplos de ARM se utilizará una *Raspberry PI*. El sistema operativo utilizado es *Raspbian*.

Software utilizado:
  - `as`, the portable GNU Assembler
  - `gcc`, GNU Project C and C++ compiler
  - `ld`, The GNU linker

Tanto en Ubuntu como en Raspbian se puede instalar el paquete `build-essential` para tener la mayoría de las herramientas necesarias para compilar código.

  `sudo apt-get install build-essential`

También es necesario contar con un editor de texto. Editores como nano, gedit, vim, Sublime Text, Eclipse sirven, pues trabajan con el archivo en texto plano, sin agregarle metadatos (como Word o LibreOffice Writer).

Los ejemplos se dividen según la arquitectura:

  * *ejemplos_x86/* -- Ejemplos para ejecutar en arquitectura x86
  * *ejemplos_arm/* -- Ejemplos para ejecutar en arquitectura ARM

Cada ejemplo está comentado paso a paso y debería ser auto-explicativo, sin embargo, para no repetir las explicaciones, se han ordenado con números, donde el primer ejemplo es el más básico y al aumentar el número, se tratan temas más avanzados.

Por otro lado, esto no pretende ser un tutorial a fondo de Assembly. Sólo se pretende ilustrar algunos puntos y ofrecer una forma
rápida de abordar algunos problemas.

Instrucciones
=============

#### Generar código Assembly usando GCC y C

Cuando se compila un programa en C, el código atraviesa tres grandes etapas:

  1. Generación de código Assembler específico de la arquitectura.
  2. Ensamblar el código Assembler a código máquina (*texto a binario*).
  3. *Linkeo* del código máquina con librerías y más objetos.

El archivo resultante del proceso anterior es directamente ejecutable por el sistema.
El proceso anterior se realiza, típicamente, con estos comandos:

    `$ gcc programa.c -o programa // Compilar`
    `$ ./programa // Ejecutar`

Sin embargo, si a `gcc` se le pasa el parámetro `-S` detendrá la compilación en la etapa 1. Generando un archivo `.s`, el cual tendrá el código en Assembler. Este archivo no es directamente ejecutable, pues aún necesita atravesar las etapas de ensamblado y linkeo (*GCC* puede continuar la compilación a partir del archivo `.s` por lo que no hay de qué preocuparse).

Los pasos serían:

1. Utilizar gcc para generar el código assembler, esto generará el archivo `programa.s`:
  `$ gcc -S programa.c -o programa.s`
2. Ensamblar y linkear:
  `$ gcc programa.s -o programa`
3. Ejecutar:
  `$ ./programa`
  (normalmente hay que otorgar permisos de ejecución al archivo: `$ chmod +x programa`)

Con eso, se pueden generar programas y luego ver cómo C realiza sus operaciones.

###### NOTAS

1. Los archivos `.s` generados con este método suelen no ser directamente ensamblables y ejecutables, pues hacen referencias a librerías de C. Lo mejor en este caso es utilizar `gcc` como frontend para `as` y `ld`. En la sección siguiente se verá cómo utilizar `as` y `ld` para generar código máquina de manera independiente.
2. Por defecto, GCC insertará varias directivas en el archivo resultando, por ejemplo: `.cfi_startproc`, `.cfi_def_cfa_offset 16`, etc. Estas directivas asisten en el proceso de debug, en específico, permiten recorrer el stack y saber cuál ha sido el orden de las llamadas a funciones. Cuando el archivo es grande, puede ser molesto tener que leer estas directivas, por lo que se pueden desactivar utilizando el siguiente parámetro:
  `$ gcc -fno-asynchronous-unwind-tables -S prueba.c -o prueba.s`

#### Ensamblar y ejecutar código Assembly directamente

Para esto es necesario escribir a mano el archivo `.s`. Luego, se utiliza `as` para ensamablarlo (pasar de texto a binario) y luego `ld` para generar el archivo ejecutable.

1. Ensamblar:
  `$ as -o programa.o programa.s`
2. Linkear:
  `$ ld -o programa programa.o`
3. Ejecutar:
  `$ ./programa`


#### Usar GCC para ensamblar y linkear

Si el archivo `.s` ya existe, se puede realizar el ensamblado y linkeo en un solo paso, obteniendo el ejecutable de inmediato:

1. `$ gcc -nostdlib programa.s -o programa`

#### Ensamblar los ejemplos

Para ensamblar todos los ejemplos, se puede utilizar un archivo `Makefile`, provisto en cada carpeta:

  1. `cd ejemplos_x86`
  2. `make`
  3. `./001_inicio`

#### TIPS

1. Cada programa ejecutado en Linux tiene un código de retorno, o de salida. Este es un número utilizado para indicar el resultado de la ejecución. Típicamente, si el programa termina con código `0` (cero), significa que se ejecutó satisfactoriamente. Para saber cuál fue el código de salida del último programa ejecutado, se puede escribir en la consola el siguiente comando:
  `$ echo $?`
  Esto resulta bastante útil al momento de querer imprimir números desde Assembler, pues es mucho más fácil que imprimir una cadena de texto.

###### LINKS ÚTILES

  - http://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.html
  - http://blog.rchapman.org/post/36801038863/linux-system-call-table-for-x86-64
  - http://syscalls.kernelgrok.com/
  - http://en.wikipedia.org/wiki/Function_prologue
  - http://www.cs.virginia.edu/~evans/cs216/guides/x86.html
  - http://www.asciitable.com/
  - http://web.mit.edu/gnu/doc/html/as_7.html
