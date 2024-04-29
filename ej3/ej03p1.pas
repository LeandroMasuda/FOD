{3. Realizar un programa que presente un menú con opciones para:

a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. 

De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.

b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario}

program ej03;
type
	empleado=record
		num:integer;
		ape:String;
		nom:String;
		edad:integer;
		dni:integer;
	end;
	archivo= file of empleado;
procedure ingreso(var emple:archivo);
var
	e:empleado;
begin
	writeln('Ingresar apellido');
	readln(e.ape);
	while(e.ape<>'fin')do begin
		writeln('Ingresar nombre');
		readln(e.nom);
		writeln('Ingresar edad');
		readln(e.edad);
		writeln('Ingresar dni');
		readln(e.dni);
		writeln('Ingresar numero');
		readln(e.num);
		write(emple,e);
		writeln('Ingresar apellido');
		readln(e.ape);
	end;
	close(emple);
end;
procedure informar(e:empleado);
begin
	write('Numero: ');
	write(e.num);
	write(',Apellido: ');
	write(e.ape);
	write(', Nombre: ');
	write(e.nom);
	write(', Edad: ');
	write(e.edad);
	write(', Dni: ');
	writeln(e.dni);
end;
procedure opcion1(var emple:archivo);
var
	nombre:String;
	e:empleado;
	ok:boolean;
begin
	ok:=false;
	writeln('Ingresar un nombre o apellido a buscar');
	readln(nombre);
	reset(emple);
	while not(EOF(emple))and(ok=false) do begin
		read(emple,e);
		if(e.nom=nombre)or(e.ape=nombre) then begin
			informar(e);
			ok:=true;
		end;
	end;
	close(emple);
end;
procedure opcion2(var emple:archivo);
var
	e:empleado;
begin
	reset(emple);
	while not(EOF(emple)) do begin
		read(emple,e);
		informar(e);		
	end;
	close(emple);
end;
procedure opcion3(var emple:archivo);
var
	e:empleado;
begin
	reset(emple);
	while not(EOF(emple)) do begin
		read(emple,e);
		if(e.edad>=70) then 
			informar(e);			
	end;
	close(emple);
end;
procedure incisob(var emple:archivo);
var
	o:integer;
begin
	writeln('Ingresar el numero de la opcion a elegir');
	writeln('opcion 1: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
	writeln('opcion 2: Listar en pantalla los empleados de a uno por linea.');
	writeln('opcion 3: Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse.');
	readln(o);
	if(o=1) then 
		opcion1(emple)
	else
		if(o=2) then 
			opcion2(emple)
			else
				opcion3(emple);
end;
var
	emple:archivo;
	nomarc:String;
	ok:boolean;
	opcion:char;
begin
	ok:=true;
	while(ok=true)do begin
		writeln('Ingresar A para cargar datos al archivo');
		writeln('Ingresar B para abrir el archivo');
		writeln('Ingresar C para salir');
		readln(opcion);
		case opcion of
			'A':begin
				writeln('Ingresar nombre del archivo');
				readln(nomarc);
				Assign(emple,nomarc);
				Rewrite(emple);
				ingreso(emple);
			end;
			'B':begin
				incisob(emple);
			end;
			'C':begin
				ok:=false;
			end;
		end;
	end;
end.
