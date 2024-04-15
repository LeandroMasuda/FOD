{9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información está ordenada por código de provincia y código de localidad.
}
program ej09;
const
	valoralto=9999;
type
	num=1..9999;
	mesa=record
		codP:num;
		codL:num;
		numM,votos:integer;
	end;
	maestro= file of mesa;
procedure cargarMaestro(var mae:maestro);
var
	tex:text;
	m:mesa;
	nom:string;
begin
	writeln('Ingresar ruta del archivo maestro');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del archivo maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while(not EOF(tex)) do begin
		readln(tex,m.codP,m.codL,m.numM,m.votos);
		write(mae,m);
	end;
	writeln('Maestro cargado');
	close(mae);
	close(tex);	
end;
procedure leer(var mae:maestro;var m:mesa);
begin
	if(not EOF(mae)) then
		read(mae,m)
	else
		m.codP:=valoralto;
end;
procedure recorrerMaestro(var mae:maestro);
var
	m:mesa;
	totalVotosLoca,totalVotosPro,totalVotosGene:integer;
	auxLoca,auxPro:num;
begin
	reset(mae);
	leer(mae,m);
	totalVotosGene:=0;
	while(m.codP<>valoralto) do begin
		auxPro:=m.codP;
		totalVotosPro:=0;
		writeln();
		writeln('Codigo de Provincia: ',auxPro);
		while(auxPro=m.codP) do begin
			totalVotosLoca:=0;
			auxLoca:=m.codL;
			writeln();
			writeln('Codigo de Localidad: ',auxLoca);
			while(auxPro=m.codP)and(auxLoca=m.codL) do begin
				totalVotosLoca:=totalVotosLoca+m.votos;
				leer(mae,m);
			end;
			writeln('Total de votos por localidad: ',totalVotosLoca);
			totalVotosPro:=totalVotosPro+totalVotosLoca
		end;		
		writeln('Total de votos por Provincia: ',totalVotosPro);
		totalVotosGene:=totalVotosGene+totalVotosPro;
	end;
	writeln();
	writeln('Total general de votos: ',totalVotosGene);
end;
var
	mae:maestro;
begin
	cargarMaestro(mae);
	recorrerMaestro(mae);
end.
