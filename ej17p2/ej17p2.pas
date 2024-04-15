{17. Se cuenta con un archivo con información de los casos de COVID-19 registrados en los
diferentes hospitales de la Provincia de Buenos Aires cada día. 





Dicho archivo contiene: código
de localidad, nombre de localidad, código de municipio, nombre de municipio, código de hospital,
nombre de hospital, fecha y cantidad de casos positivos detectados. El archivo está ordenado
por localidad, luego por municipio y luego por hospital.
Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga un
listado con el siguiente formato:
Nombre: Localidad 1
Nombre: Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
NombreHospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad 1
-----------------------------------------------------------------------------------------
Nombre Localidad N
Nombre Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad N
Cantidad de casos Totales en la Provincia
Además del informe en pantalla anterior, es necesario exportar a un archivo de texto la siguiente
información: nombre de localidad, nombre de municipio y cantidad de casos del municipio, para
aquellos municipios cuya cantidad de casos supere los 1500. El formato del archivo de texto
deberá ser el adecuado para recuperar la información con la menor cantidad de lecturas
posibles.
NOTA: El archivo debe recorrerse solo una vez.}




program p2ej17;
const
	valoralto=9999;
type
	archivo=record
		codL,codM,codH,fecha,casos:integer;
		nomL,nomM,nomH:string;
	end;
	maestro= file of archivo;
	
procedure cargarMaestro(var mae:maestro);
var
	nom:string;
	a:archivo;
	t:text;
begin
	writeln('Ingresar ruta de datos del maestro');
	readln(nom);
	nom+='.txt';
	assign(t,nom);
	reset(t);	
	writeln('Ingresar nombre del maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while (not eof(t))do begin
		readln(t,a.codL,a.codM,a.codH,a.fecha,a.casos,a.nomL);
		readln(t,a.nomM);
		readln(t,a.nomH);
		write(mae,a);
	end;
	writeln();
	writeln('cargado el maestro');
	close(mae);
	close(t);
end;
procedure leer(var mae:maestro;var a:archivo);
begin
	if(not eof(mae)) then 
		read(mae,a)
	else
		a.codL:=valoralto;
end;
procedure procesar(var mae:maestro);
var
	a:archivo;
	auxL,auxM:integer;
	casosP,casosL,casosM:integer;
begin
	reset(mae);
	leer(mae,a);
	casosP:=0;
	while(a.codL<>valoralto)do begin
		auxL:=a.codL;
		writeln('Localidad: ',a.nomL);
		casosL:=0;
		while(auxL=a.codL)do begin
			auxM:=a.codM;
			writeln('Municipio: ',a.nomM);
			casosM:=0;
			while(auxL=a.codL)and(auxM=a.codM)do begin
				writeln('Hospital',a.nomH);
				casosM:=casosM+a.casos;
				writeln('cantidad de casos: ',a.casos);
				leer(mae,a);
			end;
			writeln('cantidad de casos en el municipio: ',casosM);
			casosL:=casosL+casosM;
		end;
		writeln('cantidad de casos en la localidad: ',casosL);
		casosP:=casosP+casosL;
	end;
	writeln('cantidad de casos en la provincia: ',casosP);

end;

var
	mae:maestro;
begin
	cargarMaestro(mae);
	procesar(mae);
end.
