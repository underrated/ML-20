
data = load('../data_sets/ex1data1.txt');
x = data(:,1);
y = data(:,2);
m = length(y);

plot(x,y, 'rx', 'MarkerSize', 3);
xlabel('Profit in $10,000');
ylabel('Population of city in 10,000s');

