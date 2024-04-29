program ej01;
type
	numero = file of real;
var
	arnum: numero;
	nomA:String;
	num:real;
begin
	writeln('Ingresar nombre del archivo');
	readln(nomA);
	Assign(arnum,nomA);
	Rewrite(arnum);
	writeln('Ingresar un numero');
	readln(num);
	while(num<>30000)do begin
		write(arnum,num);
		writeln('Ingresar un numero');
		readln(num);
	end;
	close(arnum);
	reset(arnum);
	while not(EOF(arnum))do begin
		read(arnum,num);
		writeln('Numero: ',num:2:1);
	end;
	close(arnum);
end.
