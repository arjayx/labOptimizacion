clear;
clc;
syms x1 x2 obj rest;
obj = sym(input('Por favor digite z : ', 's'));
fprintf('Por favor digite las restricciones en el siguiente formato :\n');
fprintf('ejemplo [x1^2 + 3; x1 + 2 + x2] :\n');
rest = sym(input('Puede digitar las restricciones aqui : ', 's'));
clc;
fprintf('El programa de optimizacion a resolver ingresado es el siguiente :\n');
fprintf('funcion objetivo : \n');
pretty(obj);
fprintf('sujeto a :\n');
pretty(rest);
for i=1:length(rest)
    degree = feval(symengine, 'degree', rest(i));
    if degree > 1
        fprintf('Hay que linealizar la siguiente ecuacion : \n');
        pretty(rest(i));
        % Voy a llamar la funcion para linelizar
    end
end
input('para continuar presione cualquier caracter : ', 's')
clc;
g = 3*x1^2 -2*x1*x2 + x2^2 - 1;
obj = x1-x2
f = [1,-1];
A=[];
b=[];
Aeq=[];
beq=[];
lb = [-2,-2];
ub = [2,2];
x = linprog(f,A,b,Aeq,beq,lb,ub)
x = round(x)'
neweq =  sym(subs(g,[x1 x2],x) + subs(gradient(g)',[x1 x2], x)*([x1 x2]'-x' ))
c = coeffs(neweq)
A = double([c(3) c(2)])
b = double([-c(1)])
x = linprog(f,A,b,Aeq,beq,lb,ub)'
disp(subs(g,[x1 x2], x))
disp(subs(obj,[x1 x2], x))