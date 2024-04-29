{4. Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
un número de empleado ya registrado (control de unicidad).
b. Modificar edad a uno o más empleados.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}

program ej04;
type
	empleado=record
		num:integer;
		ape:String;
		nom:String;
		edad:integer;
		dni:integer;
	end;
	archivo= file of empleado;
procedure leer(var e:empleado);
begin
	writeln('Ingresar apellido');
	readln(e.ape);
	if(e.ape<>'fin')then begin
		writeln('Ingresar nombre');
		readln(e.nom);
		writeln('Ingresar edad');
		readln(e.edad);
		writeln('Ingresar dni');
		readln(e.dni);
		writeln('Ingresar numero');
		readln(e.num);
	end;
end;
procedure ingreso(var emple:archivo);
var
	e:empleado;
begin
	leer(e);
	while(e.ape<>'fin')do begin
		write(emple,e);
		leer(e);
	end;
	close(emple);
end;
procedure informar(e:empleado);
begin
	write('Numero: ');
	write(e.num);
	write(', Apellido: ');
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
procedure opciona(var emple:archivo);
var
	e,com:empleado;
	ok:boolean;
begin
	leer(e);
	while(e.ape<>'fin') do begin
		ok:=true;
		reset(emple);
		while not(EOF(emple))and(ok) do begin
			read(emple,com);
			if(e.num=com.num) then 
				ok:=false;
		end;
		if(ok) then begin
			write(emple,e);
			writeln('Agrego exitosamente');
		end
		else
			writeln('Numero de empleado repetido');
		leer(e);
	end;
	close(emple);
end;
procedure modificar(n:integer;var emple:archivo);
var
	e:empleado;
	ok:boolean;
	cambio:integer;
begin
	ok:=true;
	reset(emple);
	while not(EOF(emple))and(ok)do begin
		read(emple,e);
		if(e.num=n) then begin
			ok:=false;
			writeln('Ingresar nueva edad');
			readln(cambio);
			e.num:=cambio;
			seek(emple,filepos(emple)-1);
			write(emple,e);
		end;
	end;
	if(ok) then 
		writeln('No se encontro el numero de empleado');
	close(emple);		
end;
procedure opcionb(var emple:archivo);
var
	numero:integer;
begin
	writeln('Ingresar el numero de empleado a cambiar edad');
	readln(numero);
	modificar(numero,emple);
end;
procedure opcionc(var emple:archivo);
var
	arch:text;
	e:empleado;
begin
	reset(emple);
	Assign(arch,'todos_empleados.txt');
	rewrite(arch);
	while not(EOF(emple)) do begin
		read(emple,e);
		write(arch,'datos del empleado');
	end;
	close(emple);
	close(arch);
end;
procedure opciond(var emple:archivo);
var
	e:empleado;
	nuevo_archivo:text;
begin
	reset(emple);
	Assign(nuevo_archivo,'faltaDNIEmpleado.txt');
	rewrite(nuevo_archivo);
	while not(EOF(emple))do begin
		read(emple,e);
		if(e.dni=00) then 
			write(nuevo_archivo,'datos del empleado');
	end;
	close(emple);
	close(nuevo_archivo);
		
end;
var
	emple:archivo;
	nomarc:String;
	ok:boolean;
	opcion:String;
begin
	ok:=true;
	while(ok=true)do begin
		repeat
			writeln('Ingresar A para cargar datos al archivo');
			writeln('Ingresar B para abrir el archivo');
			writeln('Ingresar C para salir');
			writeln('Ingresar a para anadir 1 o mas empleados');
			writeln('Ingresar b para modificar edad a 1 o mas empleados');
			writeln('Ingresar c para exportar archivo ');
			writeln('Ingresar d para exportar archivo de los empleados con dni 00');
			readln(opcion);
		until(opcion='A')or(opcion='B')or(opcion='C')or(opcion='a')or(opcion='b')or(opcion='c')or(opcion='d');
		if(opcion='A') then begin
			writeln('Ingresar nombre del archivo');
			readln(nomarc);
			Assign(emple,nomarc);
			Rewrite(emple);
			ingreso(emple);
		end
		else	
		if(opcion='B') then begin		
			incisob(emple);
		end
		else
		if(opcion='C') then 
			ok:=false
		else
		if(opcion='a') then begin
			opciona(emple);
		end
		else
		if(opcion='b') then 
			opcionb(emple)
		else
		if(opcion='c') then 
			opcionc(emple)
		else
			opciond(emple);
	end;
end.
