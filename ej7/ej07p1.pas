{7. Realizar un programa que permita:
a) Crear un archivo binario a partir de la información almacenada en un archivo de
texto. El nombre del archivo de texto es: “novelas.txt”. La información en el
archivo de texto consiste en: código de novela, nombre, género y precio de
diferentes novelas argentinas. Los datos de cada novela se almacenan en dos
líneas en el archivo de texto. 
* La primera línea contendrá la siguiente información:
código novela, precio y género.
* la segunda línea almacenará el nombre de la novela.
b) Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
agregar una novela y modificar una existente. Las búsquedas se realizan por
código de novela.
NOTA: El nombre del archivo binario es proporcionado por el usuario desde el teclado.}

program ej07;
type
	novela=record
		cod:integer;
		nom:String;
		gen:String;
		precio:real;
	end;
	
	archivo= file of novela;
	
procedure opcionA(var arcL:archivo);
var
	tex:text;
	nom:String;
	n:novela;
begin
	writeln('Ingresar nombre del archivo binario');
	readln(nom);
	Assign(arcL,nom);
	rewrite(arcL);
	Assign(tex,'novelas.txt');
	reset(tex);
	while not(EOF(tex)) do begin
		readln(tex,n.cod,n.precio,n.gen);
		readln(tex,n.nom);
		write(arcL,n);	
	end;
	close(tex);
	close(arcL);
end;
procedure leer(var n:novela);
begin
	writeln('codigo');
	readln(n.cod);
	writeln('nombre');
	readln(n.nom);
	writeln('precio');
	readln(n.precio);
	writeln('genero');
	readln(n.gen);
end;
procedure agregarN(var arcL:archivo);
var
	n:novela;
begin
	reset(arcL);
	seek(arcL,filesize(arcL));
	leer(n);
	write(arcL,n);
	close(arcL);
end;
procedure modificarN(var arcL:archivo);
var
	codi:integer;
	n:novela;
begin
	writeln('Ingresar codigo de novela a modificar');
	readln(codi);
	reset(arcL);
	while not(EOF(arcL))do begin
		read(arcL,n);
		if(codi=n.cod) then 
			
	end;
	close(arcL);
end;
procedure opcionB(var arcL:archivo);
var
	aux:integer;
begin
	writeln('Ingresar 1 para agregar una novela');
	writeln('Ingresar 2 para modificar una existente');
	writeln('Ingresar 3 para finalizar');
	readln(aux);
	while(aux<>3) do begin
		case aux of
			1:
				begin
					agregarN(arcL);
				end;
			2:
				begin
					modificarN(arcL);
				end;
			else
				writeln('numero incorrecto');
		end;
	end;
	
end;

	
var
	arcL:archivo;
	opcion:char;
begin
	repeat 
	writeln('Ingresar A:');
	writeln('Crear un archivo binario a partir de la información almacenada en un archivo de texto');
	writeln('Ingresar B:');
	writeln('Abrir el archivo binario y permitir la actualización del mismo');
	writeln('Ingresar F para finalizar');
	readln(opcion);
		case opcion of
			'A':
				begin
					opcionA(arcL);
				end;
			'B':
				begin
					opcionB(arcL);
				end;
		end;
	until(opcion='F');
end.
