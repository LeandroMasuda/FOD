{7. Se cuenta con un archivo que almacena información sobre especies de aves en vía
de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las
especies a eliminar. Deberá realizar todas las declaraciones necesarias, implementar
todos los procedimientos que requiera y una alternativa para borrar los registros. Para
ello deberá implementar dos procedimientos, uno que marque los registros a borrar y
posteriormente otro procedimiento que compacte el archivo, quitando los registros
marcados. Para quitar los registros se deberá copiar el último registro del archivo en la
posición del registro a borrar y luego eliminar del archivo el último registro de forma tal
de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000}
program ej07;
const
	valoralto=9999;
type
	ave=record
		cod:integer;
		nom,familia,desc,zona:string;
	end;
	archivo= file of ave;
	
procedure crearArchivo(var a:archivo);
var
	t:text;
	av:ave;
begin
	assign(a,'archivo');
	rewrite(a);
	assign(t,'ave.txt');
	reset(t);
	while(not eof(t))do begin
		readln(t,av.cod,av.nom);
		readln(t,av.familia);
		readln(t,av.desc);
		readln(t,av.zona);
		write(a,av);	
	end;
	close(a);
	close(t);
	writeln('Archivo de aves cargado');
end;
procedure crearArchivo2(var a:archivo);
var
	t:text;
	av:ave;
begin
	assign(a,'archivo2');
	rewrite(a);
	assign(t,'ave2.txt');
	reset(t);
	while(not eof(t))do begin
		readln(t,av.cod,av.nom);
		readln(t,av.familia);
		readln(t,av.desc);
		readln(t,av.zona);
		write(a,av);	
	end;
	close(a);
	close(t);
	writeln('Archivo de aves 2 cargado');
end;	
procedure leer(var a:archivo;var av:ave);
begin
	if(not eof(a))then
		read(a,av)
	else
		av.cod:=valoralto;
end;
procedure imprimir(var a:archivo);
var
	av:ave;
begin
	reset(a);
	while(not eof(a))do begin
		read(a,av);
		writeln('Codigo ',av.cod,' Nombre ',av.nom);
	end;
	close(a);
end;
procedure eliminar(var a:archivo;av:ave);
var
	avee:ave;
	ok:boolean;
begin
	reset(a);
	ok:=true;
	leer(a,avee);
	while(avee.cod<>valoralto)and(ok) do begin
		if(avee.cod=av.cod) then begin
			ok:=false;
			seek(a,filepos(a)-1);
			avee.cod:=avee.cod*-1;
			write(a,avee);
		end;
		leer(a,avee);
	end;
	close(a);
end;

procedure EliminacionLogica(var a:archivo;var a2:archivo);
var
	av:ave;
begin
	reset(a2);
	leer(a2,av);
	while(av.cod<>valoralto) do begin
		eliminar(a,av);
		leer(a2,av);
	end;
	close(a2);
end;
procedure compactar(var a:archivo);
var
	av,aux:ave;
	indice:integer;
begin
	reset(a);
	leer(a,av);
	while(av.cod<>valoralto)do begin
		if(av.cod<=0) then begin
			indice:=filepos(a)-1;
			seek(a,filesize(a)-1);
			read(a,aux);
			seek(a,indice);
			write(a,aux);
			seek(a, filesize(a)-1);
			truncate(a);
			seek(a,indice);
		end;
		leer(a,av);
	end;
	close(a);
end;
var 	
	a,a2:archivo;
begin
	crearArchivo(a);
	crearArchivo2(a2);
	writeln('---------------------------');
	writeln('ORIGINAL');
	imprimir(a);
	EliminacionLogica(a,a2);
	writeln('---------------------------');
	writeln('BAJA LOGICA');
	imprimir(a);
	compactar(a);
	writeln('---------------------------');
	writeln('COMPACTADO');
	imprimir(a);
end.
