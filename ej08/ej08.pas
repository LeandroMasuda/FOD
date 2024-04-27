program ej08;
const
	valoralto=9999;
type
	distribucion=record
		nom,desc:string;
		lanza,version,cant:integer;
	end;
	archivo=file of distribucion;
	
function ExisteDistribucion(var a:archivo;nombre :string):boolean;
var
	ok:boolean;
	d:distribucion;	
begin
	ok:=false;
	reset(a);
	while(not eof(a))and not(ok)do begin
		read(a,d);
		if(d.nom=nombre) then
			ok:=true;
	end;
	close(a);
	ExisteDistribucion:=ok;
end;
procedure leerD(var d:distribucion);
begin
	writeln('Ingresar nombre');
	read(d.nom);
	if(d.nom<>'zzz') then begin
		writeln('Ingresar anio de lanzamiento');
		read(d.lanza);
		writeln('Ingresar numero de version');
		read(d.version);
		writeln('Ingresar cantidad de desarrolladores');
		read(d.cant);
		writeln('Ingresar descripcion');
		read(d.desc);
	end;
end;	
procedure AltaDistribucion(var a:archivo);
var
	d,d2:distribucion;
begin
	
	writeln('Ingresar datos de la nueva distribucion');
	leerD(d);
	if not (ExisteDistribucion(a,d.nom)) then begin
		reset(a);
		read(a,d2);
		if(d2.cant=0) then begin
			seek(a,filesize(a));
			write(a,d);
		end
		else begin
			seek(a,d2.cant*-1);
			read(a,d2);
			seek(a,filepos(a)-1);
			write(a,d);
			seek(a,0);		
			write(a,d2);
		end;
		close(a);
	end
	else
		writeln('ya existe la distribución');	
end;


procedure BajaDistribucion(var a:archivo);
var
	nombre:string;
	d,d2:distribucion;
begin
	writeln('Ingresar nombre de la distribucion a dar de baja');
	read(nombre);
	read(a,d2);
	if( ExisteDistribucion(a,nombre)) then begin
		reset(a);
		read(a,d);
		while(d.nom<>nombre) do begin
			read(a,d);
			seek(a,filepos(a)-1);
			d.cant:=filepos(a)*-1;
			write(a,d2);
			seek(a,0);
			write(a,d);
			close(a);
		end;
	end
	else
		writeln('Distribucion no existente');
end;

var
	a:archivo;
begin


end.
