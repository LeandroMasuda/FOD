{6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.
}
program ej05;
type
	celular=record	
		cod,stockM,stockD:integer;
		nom,desc,marca:String;
		precio:real;
	end;
	
	archivo= file of celular;
procedure opciona(var arcL:archivo);
var
	nom:String;
	tex:text;
	c:celular;
begin
	writeln('Nombre del archivo de carga');
	readln(nom);
	Assign(arcL,nom);
	rewrite(arcL);
	Assign(tex,'celulares.txt');
	reset(tex);
	while not(EOF(tex))do begin
		readln(tex,c.cod,c.precio,c.marca);
		readln(tex,c.stockD,c.stockM,c.desc);
		readln(tex,c.nom);
		write(arcL,c);
	end;
	close(tex);
	close(arcL);
end;
procedure informar(c:celular);
begin
	writeln('codigo de celular',c.cod);
	writeln('stock minimo de celular',c.stockM);
	writeln('stock disponible celular',c.stockD);
	writeln('nombre de celular',c.nom);
	writeln('descripcion de celular',c.desc);
	writeln('marca de celular',c.marca);
	writeln('precio de celular',c.precio);
end;
procedure opcionb(var arcL:archivo);
var
	c:celular;
begin
	reset(arcL);
	while(EOF(arcL))do begin
		read(arcL,c);
		Informar(c);	
	end;
end;
procedure opcionc(var arcL:archivo);
var
	c:celular;
	d:String;
begin
	writeln('Ingresar descripcion del celular a buscar');
	readln(d);
	reset(arcL);
	while(EOF(arcL))do begin
		read(arcL,c);
		if(d=c.desc) then 
			Informar(c);	
	end;
end;
procedure opciond(var arcL:archivo);
var
	tex:text;
	c:celular;
begin
	reset(arcL);
	Assign(tex,'celulares.txt');
	rewrite(tex);
	while not(EOF(arcL))do begin
		read(arcL,c);
		writeln(tex,c.cod,' ',c.precio,' ',c.marca);
		writeln(tex,c.stockD,' ',c.stockM,' ',c.desc);
		writeln(tex,c.nom);		
	end;
end;
procedure leer(var c:celular);
begin
	writeln('codigo de celular');
	readln(c.cod);
	writeln('stock minimo de celular');
	readln(c.stockM);
	writeln('stock disponible celular');
	readln(c.stockD);
	writeln('nombre de celular');
	readln(c.nom);
	writeln('descripcion de celular');
	readln(c.desc);
	writeln('marca de celular');
	readln(c.marca);
	writeln('precio de celular');
	readln(c.precio);
end;
procedure opcionAA(var arcL:archivo);
var
	c:celular;
begin
	reset(arcL);
	seek(arcL,filesize(arcL));
	writeln('Para salir ingresar en el nombre de cel "fin"');
	leer(c);
	while(c.nom<>'fin')do begin
		write(arcL,c);
		leer(c);
	end;
	close(arcL);
end;
procedure opcionBB(var arcL:archivo);
var
	aux:String;
	c:celular;
	s:integer;
begin
	reset(arcL);
	writeln('Ingresar el nombre de un cel para modificar stock');
	readln(aux);
	while not(EOF(arcL)) do begin
		read(arcL,c);
		if(c.nom=aux) then begin
			writeln('Ingresar nuevo stock');
			readln(s);
			c.stockD:=s;
			seek(arcL,filepos(arcL)-1);
			write(arcL,c);
		end;
	end;
	close(arcL);
end;
procedure opcionCC(var arcL:archivo);
var
	c:celular;
	tex:text;
begin
	Assign(tex,'SinStock.txt');
	rewrite(tex);
	reset(arcL);
	while not(EOF(arcL)) do begin
		read(arcL,c);
		if(c.stockD=0) then begin
			writeln(tex,c.cod,' ',c.precio,' ',c.marca);
			writeln(tex,c.stockD,' ',c.stockM,' ',c.desc);
			writeln(tex,c.nom);				
		end;
	end;
	close(arcL);
	close(tex);
end;
var
	arcL:archivo;
	opcion:char;
begin
	writeln('Ingresar una opcion: ');
	writeln('"a" Crear un archivo de registros');
	writeln('"b" Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.');
	writeln('"c" Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.');
	writeln('"d" Exportar el archivo creado en el inciso a');
	writeln('"A" Añadir uno o más celulares al final del archivo');
	writeln('"B" Modificar el stock de un celular dado.');
	writeln('"C" Exportar el contenido de celulares con 0 stock');
	readln(opcion);
	case opcion of
		'a':
			begin
				opciona(arcL);
			end;
		'b':
			begin
				opcionb(arcL);	
			end;
		'c':
			begin
				opcionc(arcL);
			end;
		'd':
			begin
				opciond(arcL);
			end;
		'A':
			begin
				opcionAA(arcL);
			end;
		'B':
			begin
				opcionBB(arcL);
			end;
		'C':
			begin
				opcionCC(arcL);
			end;
		else
			writeln('letra incorrecta');
	end;
end.	
	
	
	
	
	
	
	
	
	
