{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
 
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares deben contener: código de celular, nombre,
descripción, marca, precio, stock mínimo y stock disponible.

b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.

c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.

d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
debería respetar el formato dado para este tipo de archivos en la NOTA 2.

NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas. 
* En la primera se especifica: código de celular, el precio y
marca, 
* en la segunda el stock disponible, stock mínimo y la descripción 
* y en la tercera nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.
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
var
	arcL:archivo;
	opcion:char;
begin
	writeln('Ingresar una opcion: ');
	writeln('"a" Crear un archivo de registros');
	writeln('"b" Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.');
	writeln('"c" Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.');
	writeln('"d" Exportar el archivo creado en el inciso a)');
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
		else
			writeln('letra incorrecta');
	end;
end.	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
