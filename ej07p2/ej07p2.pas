{7. Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
para el ministerio de salud de la provincia de buenos aires.

Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: 


código de localidad, código cepa, cantidad de casos activos, cantidad de casos nuevos, 
cantidad de casos recuperados, cantidad de casos fallecidos.




El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de recuperados y cantidad de fallecidos.



Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. 


Todos los archivos están ordenados por código de
localidad y código de cepa.



Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.

Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}


program ej07;
const
	valoralto=9999;
	df=2;
type
	str= 1..9999;
	municipio=record
		codL:str;
		codC:str;
		casosA:integer;
		casosN:integer;
		cantR:integer;
		cantF:integer;
	end;
	ministerio=record
		codL:str;
		nomL:string;
		codC:str;
		nomC:string;
		casosA:integer;
		casosN:integer;
		cantR:integer;
		cantF:integer;
	end;
	maestro= file of ministerio;
	detalle= file of municipio;
	vecDet= array[1..df] of detalle;
	vecReg= array[1..df] of municipio;
	
procedure crearUnSoloDetalle(var det:detalle);
var
	tex:text;
	nom:string;
	mun:municipio;
begin
	writeln('Ingresar la ruta del detalle');
	readln(nom);
	Assign(tex,nom);
	reset(tex);
	writeln('Ingresar el nombre del detalle');
	readln(nom);
	Assign(det,nom);
	rewrite(det);
	while(not EOF(tex)) do begin
		readln(tex,mun.codL,mun.codC,mun.casosA,mun.casosN,mun.cantR,mun.cantF);
		write(det,mun);
	end;
	writeln('Se logro cargar el archivo');
	close(det);
	close(tex);
end;
procedure crearDetalle(var vecd:vecDet);
var
	i:integer;
begin
	for i:=1 to df do
		crearUnSoloDetalle(vecd[i]);
end;
procedure leer(var det:detalle;var m:municipio);
begin
	if( not EOF(det)) then
		read(det,m)
	else
		m.codL:=valoralto;
end;



procedure minimo(var vecd:vecDet;var vecr:vecReg;var min:municipio);
var
	i,pos:integer;
begin
	min.codL:=valoralto;
	for i:=1 to df do begin
		if(vecr[i].codL<min.codL)or((vecr[i].codL=min.codL)and(vecr[i].codC<min.codC)) then begin
			min:=vecr[i];
			pos:=i;
		end;
	end;
	if(min.codL<>valoralto)then
		leer(vecd[pos],vecr[pos]);
			
end;
procedure actualizarMaestro(var mae:maestro;var vecd:vecDet);
var
	mun:municipio;
	min:ministerio;
	vecr:vecReg;
	i:integer;
	cantCasosL,cantL:integer;
begin
	reset(mae);
	for i:=1 to df do begin
		reset(vecd[i]);
		leer(vecd[i],vecr[i]);
	end;
	minimo(vecd,vecr,mun);
	cantL:=0;
	read(mae,min);
	while(mun.codL<>valoralto)do begin
		cantCasosL:=0;
		while(min.codL<>mun.codL)do
			read(mae,min);
		while(mun.codL=min.codL) do begin
			while(mun.codC<>min.codC)do
				read(mae,min);
			while(min.codL=mun.codL)and(min.codC=mun.codC) do begin
				min.cantF:=min.cantF+mun.cantF;
				min.cantR:=min.cantR+mun.cantR;
				cantCasosL:=cantCasosL+mun.casosA;
				min.casosA:=mun.casosA;
				min.casosN:=mun.casosN;
				minimo(vecd,vecr,mun);			
			end;
			seek(mae,filepos(mae)-1);
			write(mae,min);
		end;
		writeln('Cantidad de casos en la localidad: ', cantCasosL);
		if(cantCasosL>50) then	
			cantL:=cantL+1;
	end;
	close(mae);
	for i:=1 to df do
		close(vecd[i]);
	writeln('La cantidad de localidades con mas de 50 casos activos es: ', cantL);
end;
procedure imprimirMaestro(var mae: maestro);
var
    infoMae: ministerio;
begin
    reset(mae);
    while(not eof(mae)) do
        begin
            read(mae, infoMae);
            writeln('Localidad=', infoMae.codL, ' Cepa=', infoMae.codC, ' CA=', infoMae.casosA, ' CN=', infoMae.casosN, ' CR=', infoMae.cantR, ' CF=', infoMae.cantF, ' NombreCepa=', infoMae.nomC, ' NombreLocalidad=', infoMae.nomL);
        end;
    close(mae);
end;
procedure crearMaestro(var mae: maestro);
var
    txt: text;
    infoMae: ministerio;
    nombre: string;
begin
    assign(txt, 'casos.txt');
    reset(txt);
    writeln('Ingrese un nombre para el archivo maestro');
    readln(nombre);
    assign(mae, nombre);
    rewrite(mae);
    while(not eof(txt)) do
        begin
            with infoMae do
                begin
                    readln(txt, codL, codC, casosA, casosN, cantR, cantF, nomC);
                    readln(txt, nomL);
                    write(mae, infoMae);
                end;
        end;
    writeln('Archivo binario maestro creado');
    close(txt);
    close(mae);
end;
var
    vecd: vecDet;
    mae: maestro;
begin
    crearDetalle(vecd);
    crearMaestro(mae);
    actualizarMaestro(mae, vecd);
    imprimirMaestro(mae);
end.
