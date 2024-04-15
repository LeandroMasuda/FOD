{16. Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con información
de las motos que posee a la venta. 

De cada moto se registra: código, nombre, descripción, modelo, marca y stock actual.

Mensualmente se reciben 10 archivos detalles con
información de las ventas de cada uno de los 10 empleados que trabajan. De cada archivo
detalle se dispone de la siguiente 

información: código de moto, precio y fecha de la venta.

Se debe realizar un proceso que actualice el stock del archivo maestro desde los archivos
detalles. Además se debe informar cuál fue la moto más vendida.

NOTA: Todos los archivos están ordenados por código de la moto y el archivo maestro debe
ser recorrido sólo una vez y en forma simultánea con los detalles.}


program ej16p2;
const
	valoralto=9999;
	df=2;
type
	moto=record
		cod,mode,marca,stock:integer;
		nom,desc:string;
	end;
	venta=record
		cod,fecha:integer;
		precio:real;
	end;
	maestro= file of moto;
	detalle= file of venta;
	
	vecd= array[1..df] of detalle;
	vecr= array[1..df] of venta;
	
	
procedure cargarDetalle(var det:detalle);
var
	nom:string;
	tex:text;
	v:venta;
begin
	writeln('Ingresar nombre de la ruta de datos detalle');
	readln(nom);
	nom+='.txt';
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del detalle');
	readln(nom);
	assign(det,nom);
	rewrite(det);
	while(not eof(tex)) do begin
		readln(tex,v.cod,v.fecha,v.precio);
		write(det,v);	
	end;
	close(det);
	close(tex);
	writeln('Detalle cargado');
end;
procedure cargarVariosDetalles(var vd:vecd);
var
	i:integer;
begin
	for i:=1 to df do begin
		cargarDetalle(vd[i]);
	
	
	end;
	writeln();
	writeln('Todos los detalles cargados ');
end;
	
procedure cargarMaestro(var mae:maestro);
var
	nom:string;
	tex:text;
	m:moto;
begin
	writeln('Ingresar nombre de la ruta de datos maestro');
	readln(nom);
	nom+='.txt';
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while(not eof(tex)) do begin
		readln(tex,m.cod,m.mode,m.marca,m.stock,m.nom);
		readln(tex,m.desc);
		write(mae,m);	
	end;
	close(mae);
	close(tex);
	writeln('Maestro cargado');
end;	
procedure leer(var det:detalle;var v:venta);
begin
	if(not eof(det)) then 
		read(det,v)
	else
		v.cod:=valoralto;
end;
	
procedure minimo(var vd:vecd;var vr:vecr;var min:venta);
var
	i,pos:integer;
begin
	min.cod:=valoralto;
	for i:=1 to df do begin
		if(vr[i].cod<min.cod)then begin
			min:=vr[i];
			pos:=i;
		end;
	
	end;
	if(min.cod<>valoralto) then 
		leer(vd[pos],vr[pos]);
end;
procedure actualizar(var mae:maestro;var vd:vecd);
var
	i:integer;
	vr:vecr;
	m:moto;
	min:venta;
	max,codM,cant:integer;
begin
	codM:=0;
	max:=0;
	reset(mae);
	for i:=1 to df do begin
		reset(vd[i]);
		leer(vd[i],vr[i]);
	end;
	read(mae,m);
	minimo(vd,vr,min);
	while(min.cod<>valoralto) do begin
		while(m.cod<>min.cod) do
			read(mae,m);
		cant:=0;
		while(min.cod=m.cod) do begin
			cant:=cant+1;
			minimo(vd,vr,min);	
		end;
		m.stock:=m.stock-cant;
		if(cant>max) then begin
			codM:=m.cod;
			max:=cant;	
		end;
		seek(mae,filepos(mae)-1);
		write(mae,m);	
	end;
	writeln('La moto mas vendida es ',codM,' con ',max,' ventas');
	for i:=1 to df do 
		close(vd[i]);
	close(mae);
end;
var
	mae:maestro;
	vd:vecd;
begin
	cargarVariosDetalles(vd);
	cargarMaestro(mae);
	actualizar(mae,vd);
end.
