{3. El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:

a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}

program ej03;
const
	valorA='ZZZZ';
type
	str=String[4];
	producto =record
		cod:str;
		nom:String;
		precio:real;
		stockA:integer;
		StockM:integer;
	end;
	venta=record
		cod:str;
		cant:integer;
	end;
	maestro= file of producto;
	detalle= file of venta;
procedure leer(var det:detalle;var regd:venta);
begin
	if not(EOF(det))then 
		read(det,regd)
	else
		regd.cod:=valorA;
end;
procedure opcionA(var mae:maestro;var det:detalle);
var
	regm:producto;
	regd:venta;
	total:integer;
	aux:str;
begin
	reset(mae);
	reset(det);
	read(mae,regm);
	leer(det,regd);
	while(regd.cod<>valorA) do begin
		total:=0;
		aux:=regd.cod;
		while(aux=regd.cod) do begin
			total:=total+regd.cant;
			leer(det,regd);	
		end;
		while(regm.cod<>aux)do
			read(mae,regm);
		regm.stockA:=regm.stockA-total;
		seek(mae, filepos(mae)-1);
		write(mae, regm);
		if (not(EOF(mae))) then 
   			read(mae, regm);
   	end;
   	close(mae);
   	close(det);
end;
procedure opcionB(var mae:maestro);
var
	tex:text;
	p:producto;
begin
	Assign(tex,'stock_minimo.txt');
	rewrite(tex);
	while not(EOF(mae))do begin
		read(mae,p);
		if(p.stockA<p.stockM) then 
			write(tex,p.precio,' ',p.stockA,' ',p.stockM,' ',p.nom);
			write(tex,p.cod);	
	end;
end;
var	
	mae:maestro;
	det:detalle;
	opcion:char;	
begin
	Assign(mae,'productos');
	Assign(det,'ventas');
	repeat
		writeln('a. Actualizar el archivo maestro con el archivo detalle');
		writeln('b. Listar en un archivo de texto llamado “stock_minimo.txt”');
		writeln('c. terminar');
		readln(opcion);
		case opcion of 
			'a': begin
				opcionA(mae,det);
			end;
			'b': begin
				opcionB(mae);
			end;
			else
				writeln('no hace nada');
		end;
	until(opcion='c');
end.
