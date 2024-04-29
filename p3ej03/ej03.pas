{3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:


a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario
}


program ej03;
const
	valoralto=9999;
type
	novela=record
		cod,gen,dura:integer;
		nom,dire:string;
		precio:real;
	end;
	archivo= file of novela;
procedure leerN(var n:novela);
begin
	writeln('Ingresar cod');
	readln(n.cod);
	if(n.cod<>-1) then begin
		writeln('Ingresar genero');
		readln(n.gen);
		writeln('Ingresar duracion');
		readln(n.dura);
		writeln('Ingresar nombre');
		readln(n.nom);
		writeln('Ingresar director');
		readln(n.dire);
		writeln('Ingresar precio');
		readln(n.precio);
	end;
end;
procedure opcionA(var a:archivo);
var
	n:novela;
begin
	Assign(a,'novela');
	rewrite(a);
	n.cod:=0;
	write(a,n);
	leerN(n);
	while(n.cod<>-1)do begin
		write(a,n);	
		leerN(n);
	end;
	close(a);
	writeln();
	writeln('Archivo creado  correctamente');
end;
procedure leer(var a:archivo;var n:novela);
begin
	if(not eof(a))then
		read(a,n)
	else
		n.cod:=valoralto;

end;
procedure alta(var a:archivo);
var
	n,i:novela;
begin
	reset(a);
	leer(a,n);
	if(n.cod<0) then begin
		seek(a,n.cod);
		read(a,i);
		seek(a,filepos(a)-1);
		leerN(n);
		write (a,n); 
		seek (a,0); 
		write(a,i);	
	end
	else begin
		seek(a,filepos(a)-1);
		leerN(n);
		write(a,n);
	end;
	writeln('Alta hecha');	
	close(a);
end;
procedure modificar(var a:archivo);
var
	ok:boolean;
	n:novela;
	codi:integer;
begin
	reset(a);
	writeln('Ingresar codido de novela a modificar');
	readln(codi);
	ok:=true;
	leer(a,n);
	while(n.cod<>valoralto)and(ok) do begin
		if(n.cod=codi) then begin
			ok:=false;
			writeln('Ingresar nuevos valores');
			writeln('Ingresar genero');
			readln(n.gen);
			writeln('Ingresar duracion');
			readln(n.dura);
			writeln('Ingresar nombre');
			readln(n.nom);
			writeln('Ingresar director');
			readln(n.dire);
			writeln('Ingresar precio');
			readln(n.precio);
			seek(a,filepos(a)-1);
			write(a,n);
		end;
		leer(a,n);	
	end;
	if(ok) then 
		writeln('codigo no encontrado');
	close(a);
end;
procedure eliminar(var a:archivo);
var
	codi:integer;
	n,i:novela;
	ok:boolean;
begin
	reset(a);
	ok:=true;
	writeln('Ingresar codigo de la novela a eliminar');
	readln(codi);
	leer(a,i);
	leer(a,n);
	while(n.cod<>valoralto)and(ok)do begin
		if(n.cod=codi)then begin
			ok:=false;
			seek(a,filepos(a)-1);
			write(a,i);
			i.cod:=(filepos(a)-1)*-1;
			seek(a,0);
			write(a,i);		
		end;
		leer(a,n);
	end;
	if(ok) then 
		writeln('No se pudo encontrar la novela con ese codigo');
	close(a);
end;
procedure opcionB(var a:archivo);
var
	opcion:char;
begin
	
	writeln('Ingresar la opcion deseada');
	writeln('a. Dar de alta una novela leyendo la información desde teclado. ');
	writeln('b. Modificar los datos de una novela leyendo la información desde teclado.');
	writeln('c. Eliminar una novela cuyo código es ingresado por teclado.');
	readln(opcion);
	case opcion of
		'a':
		begin
			alta(a);
		end;
		'b':
		begin
			modificar(a);
		end;
		'c':
		begin
			eliminar(a);
		end
		else
			writeln('Opcion no valida');
	end;
	
end;
procedure opcionC(var a:archivo);
var
	n:novela;
begin
	reset(a);
	leer(a,n);
	while(n.cod<>valoralto)do begin
		writeln('Codigo ',n.cod);
		writeln('Genero ',n.gen);
		writeln('Duracion ',n.dura);
		writeln('Nombre  ',n.nom);
		writeln('Director  ',n.dire);
		writeln('Precio ',n.precio:2:0);
		leer(a,n);
	end;
	close(a);
end;
var
	opcion:char;
	a:archivo;
begin
	repeat
	writeln('A. crear archivo');
	writeln('B. mantenimiento del archivo creado');
	writeln('C. listar en un archivo de texto');
	readln(opcion);
	case opcion of
		'A': 
		begin
			opcionA(a);
		end;
		'B':
		begin
			opcionB(a);
		end;
		'C':
		begin
			opcionC(a);
		end
		else
			writeln('Caracter no reconocido');
	end;
	until(opcion='A')and(opcion='B')and(opcion='C');
end.
