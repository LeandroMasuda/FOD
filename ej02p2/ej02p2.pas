{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).

Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
 
a. Actualizar el archivo maestro de la siguiente manera:
 
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado,
y se decrementa en uno la cantidad de materias sin final aprobado.
 
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.

b. Listar en un archivo de texto aquellos alumnos que tengan más materias con finales
aprobados que materias sin finales aprobados. Teniendo en cuenta que este listado
es un reporte de salida (no se usa con fines de carga), debe informar todos los
campos de cada alumno en una sola línea del archivo de texto.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}

program ej02;
const
	valoralto = 'ZZZZ';
type
	str4 = string[4]; 
	alumno=record
		cod:str4;
		ape:String;
		nom:String;
		cursada:integer;
		finales:integer;
	end;
	regd=record
		cod:str4;
		cur:boolean;
		fin:boolean;
	end;
	maetro= file of alumno;
	detalle= file of regd;
procedure leer(	var archivo: detalle; var dato: regd);
begin
    if (not(EOF(archivo))) then 
       read (archivo, dato)
    else 
		    dato.cod := valoralto;
end;

procedure opcionA(var mae:maetro;var det:detalle);
var
	regm:alumno;
	regdd:regd;
	tcur,tfin:integer;
	aux:str4;
begin
	Assign(mae,'maetro');
	Assign(det,'detalle');
	reset(mae);
	reset(det);
	read(mae, regm);
    leer(det, regdd);
	while (regdd.cod <> valoralto) do begin
		aux := regdd.cod;
		tfin:=0;
		tcur:=0;
		while (aux = regdd.cod) do begin
			if(regdd.cur) then 
				tcur:=tcur+1;
			if(regdd.fin) then 
				tfin:=tfin+1;
			leer(det, regdd);
		end;
		while (regm.cod <> aux) do
			read (mae, regm);
		if(tfin>=1) then begin
			regm.finales:=regm.finales-tfin;
		end;
		if(tcur>=1) then begin
			regm.cursada:=regm.cursada+tcur;
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regm);
		if (not(EOF(mae))) then 
   			read(mae, regm);
	end;
	close(mae);
	close(det);
end;	
procedure opcionB(var mae:maetro;var tex:text);
var
	a:alumno;
begin
	reset(mae);
	Assign(tex,'alumnos.txt');
	rewrite(tex);	
	while not(EOF(mae)) do begin
		read(mae,a);
		if(a.finales>a.cursada) then 
			writeln(a.cod,' ',a.ape,' ',a.nom,' ',a.cursada,' ',a.finales);			
	end;
	close(mae);
	close(tex)
end;
var
	opcion:char;
	mae:maetro;
	det:detalle;
	tex:text;
begin
	repeat
		writeln('Ingresar una opcion');
		writeln('a. Actualizar el archivo maestro');
		writeln('b. Listar en un archivo de texto');
		writeln('c. para finalizar');
		readln(opcion);
		case opcion of 
			'a':	begin
				opcionA(mae,det);
		
			end;
			'b':	begin
			
				opcionB(mae,tex);
		
			end;
		else
			writeln('caracter no registrado');
		end;
	until(opcion='c');
end.
