{15. La editorial X, autora de diversos semanarios, posee un archivo maestro con la información
correspondiente a las diferentes emisiones de los mismos. De cada emisión se registra:
fecha, código de semanario, nombre del semanario, descripción, precio, total de ejemplares
y total de ejemplares vendido.
Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el
país. La información que poseen los detalles es la siguiente: fecha, código de semanario y
cantidad de ejemplares vendidos. Realice las declaraciones necesarias, la llamada al
procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realice la
actualización del archivo maestro en función de las ventas registradas. Además deberá
informar fecha y semanario que tuvo más ventas y la misma información del semanario con
menos ventas.
Nota: Todos los archivos están ordenados por fecha y código de semanario. No se realizan
ventas de semanarios si no hay ejemplares para hacerlo}


program ej15;
const
	valoralto=9999;
	df=2;
type
	emision=record
		fecha,cod:integer;
		nom,desc:string;
		precio:real;
		total,vendi:integer;
	end;
	infoD=record
		fecha,cant,cod:integer;
	end;
	
	maestro= file of emision;
	detalle= file of infoD;
	vecd= array[1..df] of detalle;
	vecr=array[1..df] of infoD;
	
procedure cargarMaestro(var mae:maestro);
var
	tex:text;
	nom:string;
	e:emision;
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
	while (not eof(tex)) do begin
		readln(tex,e.fecha,e.cod,e.precio,e.total,e.vendi,e.nom);
		readln(tex,e.desc);
		write(mae,e);	
	end;
	writeln('Se cargo el maestro');
	close(mae);
	close(tex);
end;
procedure cargarUnDetalle(var det:detalle);
var
	tex:text;
	nom:string;
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
	while (not eof(tex)) do begin
		readln(tex,i.fecha,i.cant,i.cod);
		write(det,i);	
	end;
	writeln('Se cargo el detalle');
	close(det);
	close(tex);
end;
procedure cargarDetalle(var vd:vecd);
var
	i:integer;
begin
	for i:=1 to df do begin
		cargarUnDetalle(vd[i]);	
	end;
	writeln();
	writeln('Se cargar TODOS los detalles');
end;



procedure leer(var det:detalle;var min:infoD);
begin
	if(not eof(det)) then 
		read(det,min)
	else
		min.fecha:=valoralto;
end;


procedure minimo(var vd:vecd;var vr:vecr;var min:infoD);
var
	i,pos:integer;
begin
	min.fecha:=valoralto;
	for i:=1 to df do begin
		if(vr[i].fecha<min.fecha)or((vr[i].fecha=min.fecha)and(vr[i].cod<min.cod)) then begin
			min:=vr[i];
			pos:=i;
		
		end;
	end;
	if(min.fecha<>valoralto) then 
		leer(vd[pos],vr[pos]);

end;
procedure procesar(var mae:maestro;var vd:vecd);
var
	i:integer;
	vr:vecr;
	min:infoD;
	e:emision;
	minn,max,cant:integer;
	nomMax,nomMin:string;
	fechaMax,fechaMin:integer;
begin
	max:=-1;
	minn:=9999;
	reset(mae);
	for i:=1 to df do begin
		reset(vd[i]);
		leer(vd[i],vr[i]);
	end;
	read(mae,e);
	minimo(vd,vr,min);
	while(min.fecha<>valoralto) do begin
		while(min.fecha<>e.fecha) do 
			read(mae,e);
		while(min.fecha=e.fecha) do begin
			while(min.cod<>e.cod) do
				read(mae,e);
			cant:=0;
			while(min.fecha=e.fecha)and(min.cod=e.cod)do begin
				if(e.total>=min.cant) then begin
					e.total:=e.total-min.cant;
					cant:=cant+min.cant;
					e.vendi:=e.vendi+min.cant;				
				end;	
				minimo(vd,vr,min);	
				writeln(min.fecha)
			end;
			if(cant>max) then begin
				max:=cant;
				fechaMax:=e.fecha;
				nomMax:=e.nom;
			end;
			if(cant<minn) then begin
				minn:=cant;
				fechaMin:=e.fecha;
				nomMin:=e.nom;
			end;
			seek(mae,filepos(mae)-1);
			write(mae,e);
		end;
		
	end;
	writeln('termino');
	writeln('Fecha ',fechaMax,' semanario ',nomMax,' es el que tuvo mas ventas');
	writeln('Fecha ',fechaMin,' semanario ',nomMin,' es el que tuvo menos ventas');
	for i:=1 to df do
		close(vd[i]);
	close(mae);
end;
var
	mae:maestro;
	vd:vecd;
begin
	cargarMaestro(mae);
	cargarDetalle(vd);
	procesar(mae,vd);
end.
