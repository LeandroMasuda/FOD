{4. A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.
}
program ej04;
const
	valorA='ZZZZZZZZZZ';
type
	str=String[10];
	provincia=record
		nom:str;
		cant:integer;
		total:integer;
	end;
	archivo= file of provincia;
var	
	mae:archivo;
	det1,det2:archivo;	
	reg1,reg2,regm,min:provincia;
procedure leer(var arc:archivo;var d:provincia);
begin
	if not(EOF(arc))then 
		read(arc,d)
	else
		d.nom:=valorA;
end;

procedure minimo(var reg1,reg2:provincia;var min:provincia);
begin
	if(reg1.nom<=reg2.nom)then begin
		min:=reg1;
		leer(det1,reg1);
	end
	else
		min:=reg2;
		leer(det2,reg2);
end;		
begin
	Assign(mae,'infoG');
	Assign(det1,'provincias1');
	Assign(det2,'provincias2');
	reset(det1);
	reset(det2);
	reset(mae);
	leer(det1,reg1);
	leer(det2,reg2);
	minimo(reg1,reg2,min);
	while(min.nom<>valorA)do begin
		read(mae,regm);
		while(regm.nom<>valorA)do
			read(mae,regm);
		while(regm.nom=min.nom) do begin
			regm.cant:=regm.cant+min.cant;
			regm.total:=regm.total+min.total;
			minimo(reg1,reg2,min)
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;	
end.
