%Algoritmo genetico/Pareto

%Juan Camilo Rojas Méndez
%Juan Nicolas Lopez Gaona

clear all
clc
close all

datos =[10 9 8;
        4 3 2;
        3 2 2;
        10 6 3];
syms x1 x2 x3;

mano_obra=1300;
materia_prima=1000;
pc=0.3;
pm=0.2;
penalizacion=5;
cromosomas=10;
iteraciones=50;
matriz_pareto=[];
cont_pareto=1;

%Funcion maximizar

max= x1*datos(1,1)+x2*datos(1,2)+x3*datos(1,3);

%Funcion minimizar

min= x1*datos(4,1)+x2*datos(4,2)+x3*datos(4,3);

%Restricciones

%Restriccion maximizar
r1= x1*datos(2,1)+x2*datos(2,2)+x3*datos(2,3)-mano_obra;
%Restriccion minimizar
r2= x1*datos(3,1)+x2*datos(3,2)+x3*datos(3,3)-materia_prima;

for iter=1:iteraciones
poblacion_inicial_min=[];
poblacion_inicial_max=[];
aleatorios1= randi([10 100],1,10);
aleatorios2= randi([10 100],1,10);
for i=1:cromosomas
    for j=1:3
        if j==1
            poblacion_inicial_min(i,j)=aleatorios1(i);
            poblacion_inicial_max(i,j)=aleatorios2(i);
        elseif j==2
            poblacion_inicial_min(i,j)= 300-aleatorios1(i);
            poblacion_inicial_max(i,j)= 300-aleatorios2(i);
        else
            poblacion_inicial_min(i,j)= 200-(aleatorios1(i))/2;
            poblacion_inicial_max(i,j)= 200-(aleatorios2(i))/2;
        end
    end
end
funcion_evaluada_min=[];
funcion_evaluada_max=[];
for i=1:cromosomas
    x1=poblacion_inicial_min(i,1);
    x2=poblacion_inicial_min(i,2);
    x3=poblacion_inicial_min(i,3);
    funcion_evaluada_min(i)=eval(min);
    %funcion_evaluada_max(i)=eval(max);
end
for i=1:cromosomas
    x1=poblacion_inicial_max(i,1);
    x2=poblacion_inicial_max(i,2);
    x3=poblacion_inicial_max(i,3);
    %funcion_evaluada_min(i)=eval(min);
    funcion_evaluada_max(i)=eval(max);
end
matriz_fitness_min=[];
matriz_fitness_max=[];

for i=1:cromosomas
    matriz_fitness_max(i)=(1/(1+funcion_evaluada_max(i)));
    matriz_fitness_min(i)=(1/(1+funcion_evaluada_min(i)));
end
total_min=sum(matriz_fitness_min);
total_max=sum(matriz_fitness_max);
prob_seleccion_min=[];
prob_seleccion_max=[];
acumulado_min=0;
acumulado_max=0;
for i=1:cromosomas
    for j=1:2
        if j==1
        prob_seleccion_min(i,j)=matriz_fitness_min(i)/total_min;
        prob_seleccion_max(i,j)=matriz_fitness_max(i)/total_max;
        else
        acumulado_max=acumulado_max+prob_seleccion_max(i,1);
        acumulado_min=acumulado_min+prob_seleccion_min(i,1);
        prob_seleccion_max(i,j)=acumulado_max;
        prob_seleccion_min(i,j)=acumulado_min;
        end
    end
end

aleatorios_nueva_generacion_min=rand(1,10);
aleatorios_nueva_generacion_max=rand(1,10);
nueva_poblacion_max=[];
nueva_poblacion_min=[];
%Se genera una nueva poblacion para minimizar
for i=1:cromosomas
    nueva_poblacion_min(i,1)=aleatorios_nueva_generacion_min(i);
    %nueva_poblacion_max(i,1)=aleatorios_nueva_generacion_max(i);
    if aleatorios_nueva_generacion_min(i) >=0 && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(1,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(1,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(1,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(1,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(1,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(2,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(2,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(2,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(2,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(2,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(3,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(3,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(3,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(3,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(3,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(4,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(4,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(4,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(4,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(4,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(5,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(5,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(5,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(5,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(5,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(6,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(6,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(6,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(6,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(6,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(7,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(7,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(7,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(7,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(7,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(8,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(8,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(8,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(8,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(8,2) && aleatorios_nueva_generacion_min(i) <= prob_seleccion_min(9,2)
        nueva_poblacion_min(i,2)= poblacion_inicial_min(9,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(9,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(9,3);
    elseif aleatorios_nueva_generacion_min(i) > prob_seleccion_min(9,2) && aleatorios_nueva_generacion_min(i) <= 1
        nueva_poblacion_min(i,2)= poblacion_inicial_min(10,1);
        nueva_poblacion_min(i,3)= poblacion_inicial_min(10,2);
        nueva_poblacion_min(i,4)= poblacion_inicial_min(10,3);
    end
end

%Se genera una nueva poblacion para maximizar
for i=1:cromosomas
    %nueva_poblacion_min(i,1)=aleatorios_nueva_generacion_min(i);
    nueva_poblacion_max(i,1)=aleatorios_nueva_generacion_max(i);
    if aleatorios_nueva_generacion_max(i) >=0 && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(1,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(1,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(1,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(1,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(1,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(2,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(2,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(2,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(2,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(2,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(3,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(3,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(3,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(3,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(3,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(4,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(4,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(4,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(4,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(4,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(5,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(5,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(5,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(5,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(5,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(6,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(6,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(6,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(6,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(6,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(7,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(7,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(7,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(7,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(7,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(8,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(8,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(8,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(8,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(8,2) && aleatorios_nueva_generacion_max(i) <= prob_seleccion_max(9,2)
        nueva_poblacion_max(i,2)= poblacion_inicial_max(9,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(9,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(9,3);
    elseif aleatorios_nueva_generacion_max(i) > prob_seleccion_max(9,2) && aleatorios_nueva_generacion_max(i) <= 1
        nueva_poblacion_max(i,2)= poblacion_inicial_max(10,1);
        nueva_poblacion_max(i,3)= poblacion_inicial_max(10,2);
        nueva_poblacion_max(i,4)= poblacion_inicial_max(10,3);
    end
end

%Se crean los aleatorios para el cruce
aleatorios_cruce_min=rand(1,10);
aleatorios_cruce_max=rand(1,10);
ubicaciones_cruce_min=[];
ubicaciones_cruce_max=[];
%Se buscan los valores que sean menores a la probabilidad de cruce
%definida.

a1=1;
a2=1;
for i=1:cromosomas
     if aleatorios_cruce_min(i)<pc
         ubicaciones_cruce_min(a1)=i;
         a1=a1+1;
     end
     if aleatorios_cruce_max(i)<pc
         ubicaciones_cruce_max(a2)=i;
         a2=a2+1;
     end
end
poblacion_cruce_min=nueva_poblacion_min;
poblacion_cruce_max=nueva_poblacion_max;
%Cruce minimizar
if size(ubicaciones_cruce_min,2)==1 || size(ubicaciones_cruce_min,2)==0
    %disp("Minimizar: El cruce minimo solo tiene 1 elemento o ninguno cumplio con ser menor al pc");
else
for i=1:size(ubicaciones_cruce_min,2)
    if i==size(ubicaciones_cruce_min,2)
        poblacion_cruce_min(ubicaciones_cruce_min(i),3)=poblacion_cruce_min(ubicaciones_cruce_min(1),3);
        poblacion_cruce_min(ubicaciones_cruce_min(i),4)=poblacion_cruce_min(ubicaciones_cruce_min(1),4);
    else
        poblacion_cruce_min(ubicaciones_cruce_min(i),3)=poblacion_cruce_min(ubicaciones_cruce_min(i+1),3);
        poblacion_cruce_min(ubicaciones_cruce_min(i),4)=poblacion_cruce_min(ubicaciones_cruce_min(i+1),4);
    end
end
end

%Cruce maximizar
if size(ubicaciones_cruce_max,2)==1 || size(ubicaciones_cruce_max,2)==0
    %disp("Maximizar: El cruce maximo solo tiene 1 elemento o ninguno cumplio con ser menor al pc");
else
for i=1:size(ubicaciones_cruce_max,2)
    if i==size(ubicaciones_cruce_max,2)
        poblacion_cruce_max(ubicaciones_cruce_max(i),3)=poblacion_cruce_max(ubicaciones_cruce_max(1),3);
        poblacion_cruce_max(ubicaciones_cruce_max(i),4)=poblacion_cruce_max(ubicaciones_cruce_max(1),4);
    else
        poblacion_cruce_max(ubicaciones_cruce_max(i),3)=poblacion_cruce_max(ubicaciones_cruce_max(i+1),3);
        poblacion_cruce_max(ubicaciones_cruce_max(i),4)=poblacion_cruce_max(ubicaciones_cruce_max(i+1),4);
    end
end
end

%Quitando el aleatorio de la nueva generacion:
poblacion_mutacion_min=[];
poblacion_mutacion_max=[];
for i=1:cromosomas
    poblacion_mutacion_min(i,1)=poblacion_cruce_min(i,2);
    poblacion_mutacion_min(i,2)=poblacion_cruce_min(i,3);
    poblacion_mutacion_min(i,3)=poblacion_cruce_min(i,4);
    poblacion_mutacion_max(i,1)=poblacion_cruce_max(i,2);
    poblacion_mutacion_max(i,2)=poblacion_cruce_max(i,3);
    poblacion_mutacion_max(i,3)=poblacion_cruce_max(i,4);
end

numero_mutaciones=cromosomas*pm;
aleatorios_mutacion_min= randi([1 30],1,numero_mutaciones);
aleatorios_mutacion_max= randi([1 30],1,numero_mutaciones);
valores_mutacion_max=randi([1 300],1,numero_mutaciones);
valores_mutacion_min=randi([1 300],1,numero_mutaciones);
%Mutacion minimizacion
for n=1:numero_mutaciones
cont_min=1;
ubi_min=n;
for i=1:cromosomas
    for j=1:size(poblacion_mutacion_min,2)
        if cont_min == aleatorios_mutacion_min(ubi_min)
            poblacion_mutacion_min(i,j)=valores_mutacion_min(ubi_min);
            cont_min=cont_min+1;
        else
            cont_min=cont_min+1;
        end
    end
end
end
%Mutacion maximizacion
for n=1:numero_mutaciones
cont_max=1;
ubi_max=n;
for i=1:cromosomas
    for j=1:size(poblacion_mutacion_max,2)
        if cont_max == aleatorios_mutacion_max(ubi_max)
            poblacion_mutacion_max(i,j)=valores_mutacion_max(ubi_max);
            cont_max=cont_max+1;
        else
            cont_max=cont_max+1;
        end
    end
end
end

%Evaluando la funcion en las nuevas poblaciones
funcion_mutaciones_min=[];
funcion_mutaciones_max=[];
%minimizacion
for i=1:cromosomas
 x1=poblacion_mutacion_min(i,1);
 x2=poblacion_mutacion_min(i,2);
 x3=poblacion_mutacion_min(i,3);
 funcion_mutaciones_min(i)=eval(min);
end
%maximizacion
for i=1:cromosomas
 x1=poblacion_mutacion_max(i,1);
 x2=poblacion_mutacion_max(i,2);
 x3=poblacion_mutacion_max(i,3);
 funcion_mutaciones_max(i)=eval(max);
end

%Ingresando valores al pareto
mejor_min=1;
mejor_evaluado_min=1;
for i=1:cromosomas
 x1=poblacion_mutacion_min(i,1);
 x2=poblacion_mutacion_min(i,2);
 x3=poblacion_mutacion_min(i,3);
 if eval(r2)==0
     if i==1
         mejor_min=eval(min);
     else
        mejor_evaluado_min=eval(min);
        if mejor_evaluado_min<mejor_min
            mejor_min=mejor_evaluado_min;
        end
     end
 end
end
mejor_max=1;
mejor_evaluado_max=1;
for i=1:cromosomas
 x1=poblacion_mutacion_max(i,1);
 x2=poblacion_mutacion_max(i,2);
 x3=poblacion_mutacion_max(i,3);
 if eval(r1)==0
     if i==1
         mejor_max=eval(max);
     else
        mejor_evaluado_max=eval(max);
        if mejor_evaluado_max>mejor_max
            mejor_max=mejor_evaluado_max;
        end
     end
 end
end

if mejor_min==1
    %disp("No se encontro un cromosoma minimizando que cumpla con las restricciones");
elseif mejor_max==1
    %disp("No se encontro un cromosoma maximizando que cumpla con las restricciones");
else
    matriz_pareto(cont_pareto,1)=mejor_min;
    matriz_pareto(cont_pareto,2)=mejor_max;
    cont_pareto=cont_pareto+1;
end
end
disp("Matriz resultante para el FOP")
disp("   FO1        FO2")
disp(matriz_pareto)
solucion_pareto=[];
for i=1:size(matriz_pareto,1)
    es_solucion=false;
    for j=1:size(matriz_pareto,1)
        if(i~=j)
        end
        if matriz_pareto(i,1)<matriz_pareto(j,1)&&matriz_pareto(i,2)>matriz_pareto(j,2)
            es_solucion=true;
        end
    end
    if es_solucion==true
        solucion_pareto=[solucion_pareto;matriz_pareto(i) matriz_pareto(i,2)];
    end

end

disp("FRENTE OPTIMO DE PARETO")
disp("   FO1        FO2")
disp(solucion_pareto);
%desviacion estandar
% %minimzacion
% prom_min=sum(funcion_mutaciones_min)/cromosomas;
% suma_prom_min=[];
% for i=1:cromosomas
%     suma_prom_min(i)=(funcion_mutaciones_min(i)-prom_min)^2;
% end
% desviacion_min= sqrt(sum(suma_prom_min)/cromosomas);
% %maximizar
% prom_max=sum(funcion_mutaciones_max)/cromosomas;
% suma_prom_max=[];
% for i=1:cromosomas
%     suma_prom_max(i)=(funcion_mutaciones_max(i)-prom_max)^2;
% end
% desviacion_max= sqrt(sum(suma_prom_max)/cromosomas);
