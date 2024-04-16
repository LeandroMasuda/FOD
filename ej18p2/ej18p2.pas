{18. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.

Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.

En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.

Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.
Se deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única. Tenga
en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.}


program p2ej18;
const
	valoralto=9999;
	df=2;
type
	infoM=record
		dire,numP,dniM,dniP,matricula:integer;
		nom,nomM,nomP:string;
		fallecio:boolean;
		matriculaF,fecha,hora:integer;
		lugar:string;
		
	end;


	nacimiento=record
		partida,dire,matricula,dniM,dniP:integer;
		nom,nomM,nomP:string;
	end;
	fallecimiento=record
		partida,dni,matricula,fecha,hora:integer;
		nom,lugar:string;
	end;
	maestro= file of infoM;
	nacimien= file of nacimiento;
	falleci=file of fallecimiento;
	
	vecn=array[1..df] of nacimien;
	vecRegN=array[1..df] of nacimiento;
	vecf=array[1..df] of falleci;
	vecRegF=array[1..df] of fallecimiento;
procedure cargarNacimiento(var naci:nacimien);
var
	nom:string;
	t:text;
	n:nacimiento;
begin
	writeln('Ingresar ruta de datos del nacimiento');
	readln(nom);
	nom+='.txt';
	assign(t,nom);
	reset(t);
	writeln('Ingresar nombre del archivo del nacimiento');
	readln(nom);
	assign(naci,nom);
	rewrite(naci);
	while(not eof(t))do begin
		readln(t,n.partida,n.dire,n.dniM,n.dniP,n.matricula,n.nom);
		readln(t,n.nomM);
		readln(t,n.nomP);
		write(naci,n);
	end;
	close(t);
	close(naci);
end;
procedure cargarFallecimiento(var falle:falleci);
var
	nom:string;
	t:text;
	f:fallecimiento;
begin
	writeln('Ingresar ruta de datos del fallecimiento');
	readln(nom);
	nom+='.txt';
	assign(t,nom);
	reset(t);
	writeln('Ingresar nombre del archivo del fallecimiento');
	readln(nom);
	assign(falle,nom);
	rewrite(falle);
	while(not eof(t))do begin
		readln(t,f.partida,f.dni,f.matricula,f.fecha,f.hora,f.nom);
		readln(t,f.lugar);
		write(falle,f);
	end;
	close(t);
	close(falle);
end;
procedure cargarVariosFalle(var vd:vecf);
var
	i:integer;
begin
	for i:=1 to df do begin
		cargarFallecimiento(vd[i]);	
	end;
	writeln();
	writeln('Todos los detalles cargados ');
end;
procedure cargarVariosNaci(var vd:vecn);
var
	i:integer;
begin
	for i:=1 to df do begin
		cargarNacimiento(vd[i]);	
	end;
	writeln();
	writeln('Todos los detalles cargados ');
end;
procedure leerf(var falle:falleci;var minf:fallecimiento);
begin
	if(not eof(falle))then 
		read(falle,minf)
	else
		minf.partida:=valoralto;
end;
procedure leern(var naci:nacimien;var minn:nacimiento);
begin
	if(not eof(naci))then 
		read(naci,minn)
	else
		minn.partida:=valoralto;
end;

procedure minimof(var vecfalle:vecf;var vecrfalle:vecRegF;var min:fallecimiento);
var
	pos,i:integer;
begin
	min.partida:=valoralto;
	for i:=1 to df do begin
		if(vecrfalle[i].partida<min.partida) then begin
			pos:=i;
			min:=vecrfalle[i];	
		end;
	end;
	leerf(vecfalle[pos],vecrfalle[pos]);
end;
procedure minimon(var vecnaci:vecn;var vecrnaci:vecRegN;var min:nacimiento);
var
	pos,i:integer;
begin
	min.partida:=valoralto;
	for i:=1 to df do begin
		if(vecrnaci[i].partida<min.partida) then begin
			pos:=i;
			min:=vecrnaci[i];	
		end;
	end;
	leern(vecnaci[pos],vecrnaci[pos]);
end;
procedure cargarMaestro(var vecnaci:vecn;var vecfalle:vecf; var mae:maestro);
var
	m:infoM;
	i:integer;
	vecrnaci:vecRegN;
	vecrfalle:vecRegF;
	minn:nacimiento;
	minf:fallecimiento;
	t:text;
begin
	assign(t,'texto.txt');
	rewrite(t);
	for i:=1 to df do begin
		reset(vecnaci[i]);
		leern(vecnaci[i],vecrnaci[i]);	
		reset(vecfalle[i]);
		leerf(vecfalle[i],vecrfalle[i]);	
	end;
	minimon(vecnaci,vecrnaci,minn);
	minimof(vecfalle,vecrfalle,minf);
	while(minn.partida<>valoralto)do begin
		if(minn.partida=minf.partida) then begin
		m.dire:=minn.dire;
			m.numP:=minn.partida;
			m.dniM:=minn.dniM;
			m.dniP:=minn.dniM;
			m.matricula:=minn.matricula;
			m.nom:=minn.nom;
			m.nomM:=minn.nomM;
			m.nomP:=minn.nomP;
			m.fallecio:=true;
			m.matriculaF:=minf.matricula;
			m.fecha:=minf.fecha;
			m.hora:=minf.hora;
			m.lugar:=minf.lugar;
			write(mae,m);
			minimon(vecnaci,vecrnaci,minn);
			minimof(vecfalle,vecrfalle,minf);
		end
		else begin		
			m.dire:=minn.dire;
			m.numP:=minn.partida;
			m.dniM:=minn.dniM;
			m.dniP:=minn.dniM;
			m.matricula:=minn.matricula;
			m.nom:=minn.nom;
			m.nomM:=minn.nomM;
			m.nomP:=minn.nomP;
			m.fallecio:=false;
			m.matriculaF:=-1;
			m.fecha:=0;
			m.hora:=0;
			m.lugar:='NULL';
			write(mae,m);
			minimon(vecnaci,vecrnaci,minn);
		end;
		writeln(t,m.dire,' ',m.numP,' ',m.dniM,' ',m.dniP,' ',m.matricula,' ',m.nom,' ',m.nomM,' ',m.nomP,' ',m.fallecio,' ',m.matriculaF,' ',m.fecha,' ',m.hora,' ',m.lugar);
	end;
end;


var
	mae:maestro;
	vecfalle:vecf;
	vecnaci:vecn;
begin
	cargarVariosNaci(vecnaci);
	cargarVariosFalle(vecfalle);
	cargarMaestro(vecnaci,vecfalle,mae);
end.
//
