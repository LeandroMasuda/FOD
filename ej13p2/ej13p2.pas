{13. Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus
próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la
cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
sin asiento disponible.
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
tengan menos de una cantidad específica de asientos disponibles. La misma debe
ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}

program ej13;
const
	valoralto=9999;
type
	num=1..9999;
	vuelos=record	
		dest,fecha,hora:num;
		asi:integer;
	end;
	archivo=file of vuelos;
	lista=^nodo;
	nodo=record
		dato:vuelos;
		sig:lista;
	end;
procedure leer(var arc:archivo;var v:vuelos);
begin
	if(not EOF(arc)) then
		read(arc,v)
	else
		v.dest:=valoralto;
end;
procedure minimo(var det1:archivo;var det2:archivo;var r1,r2,v:vuelos);
begin
	if(r1.dest<r2.dest) then begin
		v:=r1;
		leer(det1,r1);
	end
	else begin
		v:=r2;
		leer(det2,r2);
	end;
end;
procedure actualizar(var mae:archivo;var det1,det2:archivo);
var
	min,r1,r2,v:vuelos;
	cant:integer;
begin
	writeln('Ingresar cantidad de asientos minima');
	readln(cant);
	reset(mae);
	reset(det1);
	reset(det2);
	leer(det1,r1);
	leer(det2,r2);
	read(mae,v);
	minimo(det1,det2,r1,r2,min);
	while(min.dest<>valoralto) do begin
		while(v.dest<>min.dest) do
			read(mae,v);
		v.asi:=v.asi-min.asi;
		seek(mae,filepos(mae)-1);
		if(cant>v.asi) then 
			writeln(v.dest,v.fecha,v.hora);
		write(mae,v);
		minimo(det1,det2,r1,r2,min);
		writeln('actualizado ',v.asi);	
	end;
end;
procedure crearUnDetalle(var det:archivo);
var
	tex:text;
	nom:string;
	v:vuelos;
begin
	writeln('Ingresar ruta de datos del detalle');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del detalle');
	readln(nom);
	assign(det,nom);
	rewrite(det);
	while(not eof(tex)) do begin
		readln(tex,v.dest,v.fecha,v.hora,v.asi);
		write(det,v);
	end;
	close(det);
	close(tex);
	writeln('Se cargo el detalle');
end;
procedure crearMaestro(var mae:archivo);
var
	tex:text;
	nom:string;
	v:vuelos;
begin
	writeln('Ingresar ruta de datos del maestro');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while(not eof(tex)) do begin
		readln(tex,v.dest,v.fecha,v.hora,v.asi);
		write(mae,v);
	end;
	close(mae);
	close(tex);
	writeln('Se cargo el detalle');
end;
var
	mae,det1,det2:archivo;
begin
	crearUnDetalle(det1);
	crearUnDetalle(det2);
	crearMaestro(mae);
	actualizar(mae,det1,det2);

end.



