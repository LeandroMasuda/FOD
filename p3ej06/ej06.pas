{6. Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con
la información correspondiente a las prendas que se encuentran a la venta. De cada


prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario. 

Ante un eventual cambio de temporada, se deben actualizar las
prendas a la venta. Para ello reciben un 

archivo conteniendo: cod_prenda de las prendas que quedarán obsoletas. 

Deberá implementar un procedimiento que reciba 
ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el
stock de la prenda correspondiente a valor negativo.
Adicionalmente, deberá implementar otro procedimiento que se encargue de
efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la
información de las prendas a la venta. Para ello se deberá utilizar una estructura
auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas
que no están marcadas como borradas. Al finalizar este proceso de compactación
del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro
original.
}
program ej06;
const
	valoralto=9999;
type
	prenda=record
		cod,stock:integer;
		desc,color,tipo:string;
		precio:real;
	end;
	maestro= file of prenda;
	actualizar=file of integer;
	
procedure crearMaestro(var mae:maestro);
var
	t:text;
	p:prenda;
begin
	assign(t,'maestro.txt');
	assign(mae,'maestro');
	reset(t);
	rewrite(mae);
	while(not eof(t)) do begin
		readln(t,p.cod,p.stock,p.precio,p.desc);
		readln(t,p.color);
		readln(t,p.tipo);
		write(mae,p);
	end;
	close(mae);
	close(t);
	writeln('Archivo de prendas cargado');
end;
procedure crearActua(var ac:actualizar);
var
	t:text;
	i:integer;
begin
	assign(t,'actualizar.txt');
	assign(ac,'actualizar');
	reset(t);
	rewrite(ac);
	while(not eof(t)) do begin
		readln(t,i);
		write(ac,i);
	end;
	close(ac);
	close(t);
	writeln('Archivo de prendas para actualizar');
end;
procedure leer(var ac:actualizar;var i:integer);
begin
	if(not eof(ac))then 
		read(ac,i)
	else
		i:=valoralto;
end;
procedure leerM(var mae:maestro;var p:prenda);
begin
	if(not eof(mae))then 
		read(mae,p)
	else
		p.cod:=valoralto;
end;
procedure eliminar(i:integer;var mae:maestro);
var
	p:prenda;
begin
	reset(mae);
	leerM(mae,p);
	while(p.cod<>i) do begin	
		leerM(mae,p);
	end;
	seek(mae,filepos(mae)-1);
	p.stock:=p.stock*-1;
	write(mae,p);
	close(mae);
end;
procedure actua(var mae:maestro;var ac:actualizar);
var
	i:integer;
begin
	reset(ac);
	leer(ac,i);
	while(i<>valoralto)do begin
		eliminar(i,mae);
		leer(ac,i);
	end;
end;
procedure imprimir(var mae:maestro);
var
	p:prenda;
begin
	reset(mae);
	while(not eof(mae))do begin
		read(mae,p);
		writeln('Codigo ',p.cod,' Stock ',p.stock);
	end;
	close(mae);
end;
procedure nuevoM(var mae:maestro;var nue:maestro);
var
	p:prenda;
begin
	reset(mae);
	assign(nue,'nuevo');
	rewrite(nue);
	while(not eof(mae))do begin
		read(mae,p);
		if (p.stock>=0) then begin
			write(nue,p);
		end;	
	end;
	close(mae);
	close(nue);
end;
var
	nuevo,mae:maestro;
	
	ac:actualizar;
begin
	crearMaestro(mae);
	crearActua(ac);
	writeln();
	writeln('Archivo sin cambios');
	imprimir(mae);
	actua(mae,ac);
	writeln('-----------------------');
	writeln('Archivo actualizado');
	imprimir(mae);
	nuevoM(mae,nuevo);
	writeln('-----------------------');
	writeln('Archivo Nuevo');
	imprimir(nuevo);
end.
