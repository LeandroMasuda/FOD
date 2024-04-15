{12. Suponga que usted es administrador de un servidor de correo electrónico. En los logs del
mismo (información guardada acerca de los movimientos que ocurren en el server) que se
encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.
a. Realice el procedimiento necesario para actualizar la información del log en un
día particular. Defina las estructuras de datos que utilice su procedimiento.
b. Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema. Considere la implementación de esta opción de las
siguientes maneras:
i- Como un procedimiento separado del punto a).
ii- En el mismo procedimiento de actualización del punto a). Qué cambios
se requieren en el procedimiento del punto a) para realizar el informe en
el mismo recorrido?}

program e12;
const
	valoralto=999;
type
	num=1..999;
	info=record
		numU:num;
		nomU,ape,nom:string;
		cant:integer;
	end;
	
	genera=record
		numU:num;
		des,msj:string;
	end;
	maestro= file of info;
	detalle= file of genera;
	
procedure crearMaestro(var mae:maestro);
var
	nom:string;
	tex:text;
	i:info;
begin
	writeln('Ingresar ruta de datos del maestro');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombres del maestro');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while(not EOF(tex))do begin
		readln(tex,i.numU,i.cant,i.nomU);
		readln(tex,i.ape);
		readln(tex,i.nom);
		write(mae,i);	
	end;
	writeln('Se cargo el maestro');
	close(tex);
	close(mae);
end;

procedure crearDetalle(var det:detalle);
var
	nom:string;
	tex:text;
	g:genera;
begin
	writeln('Ingresar ruta de datos del detalle');
	readln(nom);
	assign(tex,nom);
	reset(tex);
	writeln('Ingresar nombres del detalle');
	readln(nom);
	assign(det,nom);
	rewrite(det);
	while(not EOF(tex))do begin
		readln(tex,g.numU,g.des);
		readln(tex,g.msj);
		write(det,g);	
	end;
	writeln('Se cargo el datelle');
	close(det);
	close(tex);
end;
procedure leer(var det:detalle;var g:genera);
begin
	if(not EOF(det)) then 
		read(det,g)
	else
		g.numU:=valoralto;
end;

		
procedure procesar(var mae:maestro;var det:detalle);
var
	g:genera;
	auxN:num;
	cant:integer;
	i:info;
	tex:text;
	nom:string;
begin
	writeln('Ingresar el nombre del archivo de texto(texto)');
	readln(nom);
	nom+='.txt';
	assign(tex,nom);
	rewrite(tex);
	reset(mae);
	reset(det);
	leer(det,g);
	read(mae,i);
	while(g.numU<>valoralto)do begin
		auxN:=g.numU;
		cant:=0;
		while(g.numU<>valoralto)and(auxN=g.numU) do begin
			cant:=cant+1;
			leer(det,g);		
		end;	
		while(auxN<>i.numU) do
			read(mae,i);
		i.cant:=i.cant+cant;
		writeln(tex,auxN,' ',i.cant);
		seek(mae,filepos(mae)-1);
		write(mae,i);	
		writeln('usuario: ',auxN);
		writeln('acceso: ',i.cant);
	end;
	close(mae);
	close(det);
	close(tex);
end;
var
	mae:maestro;
	det:detalle;
begin
	crearDetalle(det);
	crearMaestro(mae);
	procesar(mae,det);
end.
