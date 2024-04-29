{2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla}
program ej02;
type
	numero= file of real;
procedure calcular(var ar:numero;var cant:integer;var prom:real);
var
	aux,total:real;
	canti:integer;
begin
	reset(ar);
	canti:=0;
	total:=0;
	writeln('Numeros: ');
	while not(EOF(ar)) do begin
		read(ar,aux);
		writeln(aux:2:1);
		if(aux<1500) then 
			cant:=cant+1;
		canti:=canti+1;
		total:=total+aux;	
	end;
	prom:=total/filesize(ar);
end;
var
	ar:numero;
	nom:String;
	cant:integer;
	prom:real;
begin
	writeln('Ingresar el nombre del archivo');
	readln(nom);
	Assign(ar,nom);
	cant:=0;
	prom:=0;
	calcular(ar,cant,prom);
	writeln(prom:3:2);
	writeln('la cantidad de numeros menores a 1500 es: ',cant);
end.
