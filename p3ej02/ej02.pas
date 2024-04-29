{2. Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. 

Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, 


a partir del archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’}


program ej02;
type
	asistente=record
		nro,tele,dni:integer;
		ape,nom,mail:string;
	end;
	archivo= file of asistente;
	
procedure cargarArchivo(var ar:archivo);
var
	a:asistente;
	i:integer;
begin
	assign(ar,'asistente');
	rewrite(ar);
	writeln('Informacion de los asistentes');
	for i:=1 to 3 do begin
		writeln('Ingresar nro ');
		readln(a.nro);
		writeln('Ingresar apellido ');
		readln(a.ape);
		writeln('Ingresar nombre ');
		readln(a.nom);
		writeln('Ingresar email ');
		readln(a.mail);
		writeln('Ingresar telefono ');
		readln(a.tele);
		writeln('Ingresar D.N.I ');
		readln(a.dni);
		write(ar,a);
	end;
	close(ar);
	writeln('Archivo de asistentes cargado');
end;
procedure eliminarLogica(var a:archivo);
var
	as:asistente;
begin
	reset(a);
	while(not eof(a))do begin	
		read(a,as);
		if(as.nro<1000) then begin
			as.nom:='****';
			seek(a,filepos(a)-1);
			write(a,as);
		end;
	end;
	close(a);
end;
procedure imprimir(var a:archivo);
var
	as:asistente;
begin
	reset(a);
	while(not eof(a))do begin
		read(a,as);
		writeln('Nombre:',as.nom);
	end;

	close(a);
end;
var
	a:archivo;
begin
	cargarArchivo(a);
	writeln('Archivo original');
	imprimir(a);
	eliminarLogica(a);
	writeln('Archivo con eliminacion logica');
	imprimir(a);
end.
