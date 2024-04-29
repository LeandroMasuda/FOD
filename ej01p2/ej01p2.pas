{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program ej01;
const valoralto = 'ZZZZ';
type	str4 = string[4]; 

	ingresos=record
		cod:str4;
		nom:String;
		monto:real;
	end;
	archivo = file of ingresos;
var
   total: real;	
   aux: str4; 
   regm:ingresos;
procedure leer(	var archivo: archivo; var dato: ingresos);
begin
    if (not(EOF(archivo))) then 
		read (archivo, dato)
    else 
		dato.cod := valoralto;
end;

procedure generar (var arcL:archivo;var arNue:archivo);
var
	nombre:String;
begin
	writeln('Ingresar nombre del nuevo archivo nuevo');
	readln(nombre);
	Assign(arNue,nombre);
	rewrite(arNue);
	reset(arcL);
    leer(arcL, regm);
	while (regm.cod <> valoralto) do begin
		aux := regm.cod;
		total := 0;
		while (aux = regm.cod) do begin
			total := total + regm.monto; 
			leer(arcL, regm);
		end;
		regm.monto := regm.monto + total;
		write(arNue, regm);
		if (not(EOF(arcL))) then 
   			read(arcL, regm);
	end;
	close(arcL);
	close(arNue);
end;
var
	arcL:archivo;
	arNue:archivo;
begin
	Assign(arcL,'ingresos');
	generar(arcL,arNue);
end.
