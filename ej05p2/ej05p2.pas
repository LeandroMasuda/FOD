{5. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. 



 
Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto}
program ej05;
const
	valorA='ZZZZ';
type
	str=String[4];
	producto=record
		nom:String;
		cod:str;
		desc:String;
		stockD:integer;
		stockM:integer;
		precio:real;
	end;
	venta=record
		cod:str;
		cant:integer;
	end;
	regt=record
		nom:String;
		desc:String;
		stockD:integer;
		precio:real;
	end;
	maestro = file of producto;
	detalle=file of venta;
procedure leer(var arc:detalle;var v:venta);
begin
	if not(EOF(arc))then 
		read(arc,v)
	else
		v.cod:=valorA;
end;

procedure actualizar(var mae:maestro;var det:detalle);
var
	regm:producto;
	regd:venta;
	total:integer;
	aux:str;
	tex:text;
begin
	Assign(tex,'texto.txt');
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
		regm.stockD:=regm.stockD-total;
		seek(mae, filepos(mae)-1);
		write(mae, regm);
		if(regm.stockD<regm.stockM)then begin	
			writeln(tex,regm.nom);
			writeln(tex,regm.precio,' ',regm.stockD,' ',regm.desc);
		end;
		if (not(EOF(mae))) then 
   			read(mae, regm);
   	end;
   	close(mae);
   	close(det);

end;
var
	mae:maestro;
	det:detalle;
	nombre:String;
	i:integer;
begin
	Assign(mae,'producto');	
	for i:=1 to 10 do begin
		writeln('Ingresar nombre del archivo detalle');
		readln(nombre);
		Assign(det,nombre);
		actualizar(mae,det);
	end;
end.
	
