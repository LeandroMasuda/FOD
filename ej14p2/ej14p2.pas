{14. Se desea modelar la información de una ONG dedicada a la asistencia de personas con
carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
agua, # viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
provincia y código de localidad.
Para la actualización del archivo maestro, se debe proceder de la siguiente manera:
● Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
● Idem para viviendas sin agua, sin gas y sin sanitarios.
● A las viviendas de chapa se le resta el valor recibido de viviendas construidas
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas).}

program ej14;
const
	valoralto=9999;
	df=2;
type
	infoM=record
		codP,codL:integer;
		nomP,nomL:string;
		luz,gas,chapa,agua,sani:integer;
	end;
	infoD=record
		codP,codL:integer;
		luz,gas,chapa,agua,sani:integer;
	end;
	maestro=file of infoM;
	detalle= file of infoD;
	vecd= array[1..df] of detalle;
	vecr= array[1..df] of infoD;



procedure cargarMaestro(var mae:maestro);
var
	nom:string;
	tex:text;
	i:infoM;
begin
	writeln('Ingresar ruta de datos del maestro');
	readln(nom);
	nom+='.txt';
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while(not EOF(tex)) do begin
		readln(tex,i.codP,i.codL,i.luz,i.gas,i.chapa,i.agua,i.sani,i.nomP);
		readln(tex,i.nomL);
		write(mae,i);	
	end;
	writeln('Maestro cargado');
	close(mae);
	close(tex);
end;	
procedure cargarUnDetalle(var det:detalle);
var
	nom:string;
	tex:text;
	i:infoD;
begin
	writeln('Ingresar ruta de datos del detalle');
	readln(nom);
	nom+='.txt';
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del detalle');
	readln(nom);
	assign(det,nom);
	rewrite(det);
	while(not EOF(tex)) do begin
		readln(tex,i.codP,i.codL,i.luz,i.gas,i.chapa,i.agua,i.sani);
		write(det,i);	
	end;
	writeln('Detalle cargado');
	close(det);
	close(tex);
end;	
procedure cargaDetalles(var vd:vecd);
var
	i:integer;
begin
	for i:=1 to df do begin
		cargarUnDetalle(vd[i]);
	end;
end;
procedure leer(var vd:detalle;var min:infoD);
begin
	if( not eof(vd)) then 
		read(vd,min)
	else
		min.codP:=valoralto;


end;

procedure minimo(var vd:vecd;var vr:vecr;var min:infoD);
var
	i,pos:integer;
begin
	min.codL:=valoralto;
	for i:=1 to df do begin
		if(vr[i].codP<min.codP)or((vr[i].codP=min.codP)and(vr[i].codL<min.codL)) then begin
			min:=vr[i];
			pos:=i;
		end;
	end;
	if(min.codL<>valoralto) then 
		leer(vd[pos],vr[pos]);
end;
procedure procesar(var vd:vecd;var mae:maestro);
var
	ii:integer;
	vr:vecr;
	i:infoM;
	min:infoD;
	auxP,auxL,cant:integer;
begin
	for ii:=1 to df do begin
		reset(vd[ii]);
		leer(vd[ii],vr[ii]);
	end;
	cant:=0;
	reset(mae);
	read(mae,i);
	minimo(vd,vr,min);
	while(min.codL<>valoralto) do begin
		auxP:=i.codP;	
		while(i.codL<>min.codP) do
			read(mae,i);
		while(auxP=i.codP) do begin
			auxL:=i.codL;
			while(i.codP<>min.codP) do
				read(mae,i);
			while(auxP=i.codP)and(auxL=i.codL) do begin
				i.luz:=i.luz-min.luz;
				i.gas:=i.gas-min.gas;
				i.sani:=i.sani-min.sani;
				i.agua:=i.agua-min.agua;
				i.chapa:=i.chapa-min.chapa;
				minimo(vd,vr,min);
			end;
			seek(mae,filepos(mae)-1); 
			write(mae,i);
			if(i.chapa=0) then 
				cant:=cant +1;
		end;
	
	end;
	close(mae);
	for ii:= 1 to df do
		close(vd[ii]);
end;
var
	mae:maestro;
	vd:vecd;
begin
	cargarMaestro(mae);
	cargaDetalles(vd);
	procesar(vd,mae);
end.
