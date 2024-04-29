{5. Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:


Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente

procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);}
program ej04;
const
	valoralto=9999;
type
	flor=record
		nom:String;
		cod:integer;
	end;
	archivoF=file of flor;


procedure cargarArchivo(var a:archivoF);
var
	t:text;
	f:flor;
begin
	Assign(a,'flor');
	Assign(t,'flores.txt');
	rewrite(a);
	reset(t);
	f.nom:='principio';
	f.cod:=0;
	write(a,f);
	while(not eof(t))do begin
		read(t,f.cod,f.nom);
		write(a,f);	
	end;
	close(a);
	close(t);
	writeln('Carga completa');
end;
procedure leer(var a:archivoF;var f:flor);
begin
	if(not  eof(a)) then
		read(a,f)
	else
		f.cod:=valoralto;
end;
procedure agregarFlor (var a: archivoF ; nombre: string;codigo:integer);
var
	f,cabecera:flor;
begin
	reset(a);
	leer(a,cabecera);
	if(cabecera.cod<>0) then begin
		seek(a,cabecera.cod*-1);
		f.nom:=nombre;
		f.cod:=codigo;
		leer(a,cabecera);
		seek(a,filepos(a)-1);
		write(a,f);
		seek(a,0);
		write(a,cabecera);
	end
	else
		writeln('No hay lugar vacio');
		writeln();
	close(a);
end;
procedure listar(var a:archivoF);
var
	f:flor;
begin
	reset(a);
	writeln();
	while(not eof(a))do begin
		read(a,f);
		write('Nombre ',f.nom);
		writeln(' Codigo ',f.cod);	
		writeln();
	end;
	close(a);
end;
procedure eliminarFlor (var a: archivoF; f:flor);
var
	cabecera,flo:flor;
	ok:boolean;
begin
	ok:=true;
	reset(a);
	leer(a,cabecera);
	while(not eof(a))and(ok)do begin
		leer(a,flo);
		if(flo.cod=f.cod)and(flo.nom=f.nom) then begin
			seek(a,filepos(a)-1);
			write(a,cabecera);
			cabecera.cod:=(filepos(a)-1)*-1;
			seek(a,0);		
			write(a,cabecera);
			ok:=false;
		end;
	end;
	close(a);
end;

var
	a:archivoF;
	f:flor;
begin
	cargarArchivo(a);
	writeln('Archivo sin cambios ');
	listar(a);
	writeln('------------------------');
	f.nom:='flor9';
	f.cod:=80;
	eliminarFlor(a,f);
	writeln('Archivo eliminando uno ');
	listar(a);
	writeln('------------------------');
	agregarFlor(a,'flor1000',1000);
	writeln('Archivo agregando uno  ');
	listar(a);
	writeln('------------------------');

end.
