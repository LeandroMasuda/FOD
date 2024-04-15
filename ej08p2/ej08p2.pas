{8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. 

Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido
por la empresa.

El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta. 

El orden del archivo está dado por: cod cliente, año y mes.

Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras. No es necesario que informe tales meses en el reporte.}


program ej08;
const
	valoralto=9999;
type
	num=1..9999;
	formato=record
		cod:num;
		nom,ape:string;
		anio,mes,dia:num;
		monto:real;
	end;
	maestro= file of formato;

procedure cargarMaestro(var mae:maestro);
var
	tex:text;
	nom:string;
	f:formato;
begin
	writeln('Ingresar ruta de datos del maestro');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombre del archivo maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while(not EOF(tex)) do begin
		readln(tex,f.cod,f.anio,f.mes,f.dia,f.monto,f.nom);
		readln(tex,f.ape);
		write(mae,f);
	end;
	writeln('Se cargo el maestro');
	close(mae);
	close(tex);
end;
procedure leer(var mae:maestro;var f:formato);
begin
	if(not EOF(mae)) then 
		read(mae,f)
	else
		f.cod:=valoralto;
end;
procedure recorrerMaestro(var mae:maestro);
var
	f:formato;
	codAux,mesAux,anioAux:num;
	totalAnual,totalMensual,montoEmpre:real;
begin
	reset(mae);
	leer(mae,f);
	montoEmpre:=0;
	writeln('LLEGUE');
	while(f.cod<>valoralto) do begin
		writeln('codigo de cliente: ',f.cod,' nombre: ',f.nom,' apellido: ',f.ape);
		codAux:=f.cod;
		while(f.cod=codAux) do begin
			anioAux:=f.anio;
			writeln('Anio: ',anioAux);
			writeln();
			totalAnual:=0;
			while(f.cod=codAux)and(anioAux=f.anio) do begin
				mesAux:=f.mes;			
				totalMensual:=0;
				while(f.cod=codAux)and(anioAux=f.anio)and(mesAux=f.mes) do begin
					totalMensual:=totalMensual+f.monto;
					leer(mae,f);
				end;
				if(totalMensual<>0) then begin
					writeln('En el mes ',mesAux,' compro :',totalMensual:0:2);
					totalAnual:=totalAnual+totalMensual;
				end;
			end;
			writeln('Recaudado en el anio ', anioAux,'=', totalAnual:0:2);	
			writeln();	
			montoEmpre:=montoEmpre+totalAnual;
		end;
		
	end;
	writeln('El monto total recaudado es: ',montoEmpre:0:2);
	close(mae);
end;	
	
var
	mae:maestro;
begin
	cargarMaestro(mae);
	recorrerMaestro(mae);
end.
	
	
	
	
	
	
	
	
	
	
	
	
	
