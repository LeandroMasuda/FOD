{ 6. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
 construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
 máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
 archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
 cuánto tiempo estuvo abierta. 
 
 Cada archivo detalle contiene los siguientes campos:
 cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
 detalle y 
 
 genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
 tiempo_total_de_sesiones_abiertas.
 Notas:
 ● Cadaarchivo detalle está ordenado por cod_usuario y fecha.
 ● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
 inclusive, en diferentes máquinas.
 ● Elarchivo maestro debe crearse en la siguiente ubicación física: /var/log.
}
program ej06;
const
	valoralto=999;
	numalto=999;
	df=3;
type
	str=String[4];
	num=1..999;
	sesion=record
		cod:num;
		fecha:num;
		tiempo:integer;
	end;
	detalle= file of sesion;
	maestro= file of sesion;
	vecd=array[1..df] of detalle;
	vecr=array[1..df] of sesion;
procedure crearUnSoloDetalle(var det: detalle);
var
    carga: text;
    nombre: string;
    s: sesion;
begin
    writeln('Ingrese la ruta del detalle');
    readln(nombre);
    assign(carga, nombre);
    reset(carga);
    writeln('Ingrese un nombre para el archivo detalle');
    readln(nombre);
    assign(det, nombre);
    rewrite(det);
    while(not eof(carga)) do
        begin           
			readln(carga, s.cod, s.tiempo, s.fecha);
			write(det, s);             
        end;
    writeln('Archivo binario detalle creado');
    close(det);
    close(carga);
end;
procedure crearDetalles(var vec: vecd);
var
    i: integer;
begin
    for i:= 1 to df do
        crearUnSoloDetalle(vec[i]);
end;
procedure imprimirMaestro(var mae: maestro);
var
    s: sesion;
begin
    reset(mae);
    while(not eof(mae)) do
        begin
            read(mae, s);
            writeln('Codigo=', s.cod, ' Fecha=', s.fecha, ' Tiempo=', s.tiempo);
        end;
    close(mae);
end;
procedure leer(var det: detalle; var infoDet: sesion);
begin
    if(not eof(det)) then
        read(det, infoDet)
    else
        infoDet.cod := valoralto;
end;
procedure minimo(var vec:vecd;var veccr:vecr;var min:sesion);
var
	i,pos:integer;
begin
	min.cod:=valoralto;
	min.fecha:=numalto;
	for i:=1 to df do 
		if((veccr[i].cod < min.cod)or((veccr[i].cod=min.cod)and(veccr[i].fecha<min.fecha))) then begin
			min:=veccr[i];
			pos:=i;
		end;
	if(min.cod<>valoralto) then 
		leer(vec[pos],veccr[pos]);
end;
procedure crearM(var mae:maestro;var vec:vecd);
var
	min,aux:sesion;
	veccR:vecr;
	i:integer;
begin
	assign(mae, 'ArcMaestro');
    rewrite(mae);   
	for i:= 1 to df do begin
		reset(vec[i]);
		leer(vec[i], veccR[i]);
	end;
	minimo(vec,veccR,min);
	while(min.cod<>valoralto) do begin
		aux.cod:=min.cod;
		while(aux.cod=min.cod) do begin
			aux.fecha:=min.fecha;
			aux.tiempo:=0;
			while(aux.cod=min.cod)and(aux.fecha=min.fecha) do begin
				aux.tiempo:=aux.tiempo+min.tiempo;
				minimo(vec,veccR,min);
			end;
			write(mae,aux);	
		end;	
	end;
	close(mae);
	for i:=1 to df do 
		close(vec[i]);
end;
var
	vdet:vecd;
	mae:maestro;
begin
	crearDetalles(vdet);
	crearM(mae,vdet);
	imprimirMaestro(mae);
end.
