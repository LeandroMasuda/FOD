{11. La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web
de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, día,
idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado
por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.}
{Usar un corte de contol para conseguir el anio}
program ej11;
const
	valoralto=99;
type
	num=1.. 99;
	archivo=record
		anio,mes,dia,id:integer;
		tiempo:integer;
	end;
	maestro= file of archivo;
procedure crearMaestro(var mae:maestro);
var
	tex:text;
	nom:string;
	a:archivo;
begin
	writeln('Ingresar ruta de datos del archivo');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del archivo');
	readln(nom);
	assign(mae,nom);	
	rewrite(mae);
	while(not EOF(tex)) do begin
		readln(tex,a.anio,a.mes,a.dia,a.id,a.tiempo);
		write(mae,a);	
	end;
	writeln('Maestro cargado');
	close(tex);
	close(mae);
end;
procedure leer(var mae:maestro;var a:archivo);
begin
	if(not EOF(mae)) then 
		read(mae,a)
	else
		a.anio:=valoralto;

end;


procedure procesarMaestro(var mae:maestro);
var
	nume,auxMes,auxDia,auxId:integer;
	a:archivo;
	accesos,accesoA,accesoM:integer;
begin
	writeln('Ingresar el anio a procesar');
	readln(nume);
	reset(mae);
	leer(mae,a);
	writeln(a.anio);
	if(a.anio<>valoralto) then begin
		while(a.anio<>valoralto)and(a.anio<>nume)do 
			leer(mae,a);
		if(nume=a.anio) then begin
			writeln('Anio: ',a.anio);
			accesoA:=0;
			while(a.anio=nume)do begin
				auxMes:=a.mes;
				writeln('Mes: ',auxMes);
				accesoM:=0;
				while(nume=a.anio)and(auxMes=a.mes) do begin
					auxDia:=a.dia;
					writeln('Dia: ',auxDia);
					accesos:=0;
					while(nume=a.anio)and(auxMes=a.mes)and(auxDia=a.dia)do begin
						auxId:=a.id;
						writeln('idUsuario: ',auxId);
						while(nume=a.anio)and(auxMes=a.mes)and(auxDia=a.dia)and(auxId=a.id) do begin	
							accesos:=accesos+a.tiempo;
							leer(mae,a);
						end;
						writeln('Tiempo de acceso en el dia ',auxDia,' mes ',auxMes,' = ',accesos);						
					end;
					accesoM:=accesoM+accesos;
				end;	
				writeln('Tiempo total del mes ',auxMes,'= ',accesoM);
				accesoA:=accesoA+accesoM;
			end;
			writeln('Tiempo total del anio ',nume,'= ',accesoA);
		end
		else	
			writeln('No se encontro el anio  buscado');
	end;

end;
var
	mae:maestro;
begin
	crearMaestro(mae);
	procesarMaestro(mae);
end.
