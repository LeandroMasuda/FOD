{10. Se tiene información en un archivo de las horas extras realizadas por los empleados de una
empresa en un mes. Para cada empleado se tiene la siguiente información: 


departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el
empleado. 

Se sabe que el archivo se encuentra ordenado por departamento, luego por
división y, por último, por número de empleado. Presentar en pantalla un listado con el
siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría}

program ej10;
const
	valoralto=9999;
type
	num=1..9999;
	horas=record
		dep:num;
		divi:num;
		numE:num;
		cat:integer;
		cant:integer;
	end;
	maestro= file of horas;
	categoria=record
		cate,ho:integer;
	end;
	valor=array[1..15] of integer;
procedure cargarMaestro(var mae:maestro);	
var
	tex:text;
	nom:string;
	h:horas;
begin
	writeln('Ingresar la ruta de datos del archivo maestro');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del archivo maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while( not EOF(tex)) do begin
		read(tex,h.dep,h.divi,h.numE,h.cat,h.cant);
		write(mae,h);;
	end;
	writeln('archivo maestro cargado');
	close(mae);
	close(tex);
end;

procedure cargarArray(var v:valor);
var
	nom:string;
	tex:text;
	c:categoria;
begin
	writeln('Ingresar ruta de datos de las categorias');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	while(not EOF(tex)) do begin
		read(tex,c.cate,c.ho);
		v[c.cate]:=c.ho;
	end;
	writeln('Arreglo de categorias cargado');
end;
procedure leer(var mae:maestro;var h:horas);
begin
	if(not EOF(mae)) then 
		read(mae,h)
	else
		h.dep:=valoralto;

end;
procedure recorrerMaestro(var mae:maestro; v:valor);
var
	h:horas;
	depAux,diviAux,numAux:num;
	totalhorasD,totalhorasE:integer;
	totalCobroD,totalCobroE:real;
begin
	reset(mae);
	leer(mae,h);
	while(h.dep<>valoralto) do begin
		depAux:=h.dep;
		writeln();
		writeln('Departamento N: ',depAux);
		totalhorasD:=0;
		totalCobroD:=0;
		while(depAux=h.dep) do begin
			diviAux:=h.divi;
			writeln();
			writeln('Division N: ',diviAux);
			while(depAux=h.dep)and(diviAux=h.divi) do begin
				numAux:=h.numE;
				totalhorasE:=0;
				totalCobroE:=0;
				writeln();
				writeln('Empleado N: ',numAux);
				while(depAux=h.dep)and(diviAux=h.divi)and(numAux=h.numE) do begin
					totalhorasE:=totalhorasE+h.cant;
					totalCobroE:=totalCobroE+(v[h.cat]*h.cant);
					leer(mae,h);
				end;
				writeln('Total de Hs: ',totalhorasE);
				writeln('Monto total por division: ',totalCobroE:0:2);
				totalhorasD:=totalhorasD+totalhorasE;
				totalCobroD:=totalCobroD+totalCobroE;
			end;

		end;
		writeln();
		writeln('Total de Hs del departamento: ',totalhorasD);
		writeln('Monto total departamento: ',totalCobroD:0:2);
	end;
end;

var
	mae:maestro;
	a:valor;
	
begin
	cargarMaestro(mae);
	cargarArray(a);
	recorrerMaestro(mae,a);
end.
