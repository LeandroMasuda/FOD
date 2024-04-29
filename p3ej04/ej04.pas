{4. Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
end;
tArchFlores = file of reg_flor;
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:

Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descrita anteriormente

procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.}
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
	f.cod:=-3;
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
var
	a:archivoF;
begin
	cargarArchivo(a);
	writeln('Archivo sin cambios ');
	listar(a);
	agregarFlor(a,'flor1000',1000);
	listar(a);
end.
